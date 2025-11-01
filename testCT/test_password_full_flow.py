#!/usr/bin/env python3
"""Script para probar el flujo completo de cambio de contraseña y login"""

import sys
import os

# Agregar el directorio actual al path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from app import app, db
from models import User

def test_full_password_flow():
    """Prueba el flujo completo: cambiar contraseña y verificar login"""
    with app.app_context():
        print("\n" + "="*60)
        print("  TEST COMPLETO: CAMBIO DE CONTRASEÑA Y LOGIN")
        print("="*60 + "\n")
        
        # Buscar usuario de prueba
        user = User.query.filter_by(rol='admin').first()
        
        if not user:
            print("❌ No se encontró usuario admin para probar")
            return False
        
        print(f"📋 Usuario de prueba: {user.username}")
        print(f"   Email: {user.correo}")
        print(f"   ID: {user.id}")
        
        # Guardar hash original
        original_hash = user.password
        print(f"\n🔐 Hash original: {original_hash[:50]}...")
        
        # PASO 1: Cambiar contraseña (simulando /profile)
        print("\n" + "-"*60)
        print("PASO 1: Cambiar contraseña")
        print("-"*60)
        
        nueva_password = "TestPassword123"
        print(f"→ Nueva contraseña: '{nueva_password}'")
        
        try:
            user.set_password(nueva_password)
            print(f"✓ set_password() ejecutado")
            print(f"  Nuevo hash: {user.password[:50]}...")
            
            db.session.commit()
            print("✓ Cambios guardados en DB")
            
        except Exception as e:
            print(f"❌ ERROR al cambiar contraseña: {e}")
            return False
        
        # PASO 2: Refrescar el objeto desde la BD
        print("\n" + "-"*60)
        print("PASO 2: Refrescar usuario desde BD (simular nuevo login)")
        print("-"*60)
        
        db.session.expire(user)
        db.session.refresh(user)
        print(f"✓ Usuario refrescado desde BD")
        print(f"  Hash en BD: {user.password[:50]}...")
        
        # PASO 3: Verificar contraseña (simulando login)
        print("\n" + "-"*60)
        print("PASO 3: Verificar contraseña (simulando login)")
        print("-"*60)
        
        print(f"→ Intentando login con: '{nueva_password}'")
        
        # Método usado en /login
        if user.check_password(nueva_password):
            print("✅ check_password() = True")
        else:
            print("❌ check_password() = False")
            print("\n⚠️  ERROR: La contraseña no funciona después del commit")
            # Revertir
            user.password = original_hash
            db.session.commit()
            return False
        
        # PASO 4: Intentar con contraseña incorrecta
        print("\n" + "-"*60)
        print("PASO 4: Verificar rechazo de contraseña incorrecta")
        print("-"*60)
        
        print(f"→ Intentando login con contraseña incorrecta")
        if not user.check_password("PasswordIncorrecta"):
            print("✅ Contraseña incorrecta rechazada correctamente")
        else:
            print("❌ ERROR: Aceptó contraseña incorrecta")
            user.password = original_hash
            db.session.commit()
            return False
        
        # PASO 5: Simular query fresh (como en login real)
        print("\n" + "-"*60)
        print("PASO 5: Query fresh del usuario (como en login real)")
        print("-"*60)
        
        user_fresh = User.query.filter_by(username=user.username).first()
        print(f"✓ Usuario consultado fresh desde BD")
        print(f"  Hash: {user_fresh.password[:50]}...")
        
        if user_fresh.check_password(nueva_password):
            print("✅ check_password() funciona con query fresh")
        else:
            print("❌ ERROR: check_password() falló con query fresh")
            user.password = original_hash
            db.session.commit()
            return False
        
        # PASO 6: Revertir cambios
        print("\n" + "-"*60)
        print("PASO 6: Revertir contraseña original")
        print("-"*60)
        
        user.password = original_hash
        db.session.commit()
        print("✓ Password revertido al original")
        
        # Verificación final
        user_final = User.query.filter_by(username=user.username).first()
        if user_final.password == original_hash:
            print("✓ Hash original restaurado correctamente")
        
        print("\n" + "="*60)
        print("✅ TODOS LOS TESTS PASARON")
        print("   El cambio de contraseña funciona correctamente")
        print("="*60 + "\n")
        
        return True

if __name__ == '__main__':
    success = test_full_password_flow()
    sys.exit(0 if success else 1)
