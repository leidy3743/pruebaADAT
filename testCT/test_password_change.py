#!/usr/bin/env python3
"""Script para probar cambio de contraseña en la base de datos"""

import sys
import os

# Agregar el directorio actual al path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from app import app, db
from models import User
from werkzeug.security import check_password_hash

def test_password_change():
    """Prueba el cambio de contraseña de un usuario existente"""
    with app.app_context():
        # Buscar un usuario de prueba (puede ser cualquier admin o docente)
        print("\n=== TEST DE CAMBIO DE CONTRASEÑA ===\n")
        
        # Buscar el primer usuario admin
        user = User.query.filter_by(rol='admin').first()
        
        if not user:
            print("❌ No se encontró ningún usuario admin para probar")
            return
        
        print(f"✓ Usuario encontrado: {user.username} (ID: {user.id})")
        print(f"  Email: {user.correo}")
        print(f"  Hash actual: {user.password[:60]}...")
        
        # Guardar el hash original
        original_hash = user.password
        
        # Intentar cambiar la contraseña
        nueva_password = "test123456"
        print(f"\n→ Cambiando contraseña a: '{nueva_password}'")
        
        try:
            user.set_password(nueva_password)
            print(f"✓ set_password() ejecutado")
            print(f"  Nuevo hash: {user.password[:60]}...")
            
            # Verificar que el hash cambió
            if user.password == original_hash:
                print("❌ ERROR: El hash NO cambió después de set_password()")
                return
            else:
                print("✓ Hash cambió correctamente")
            
            # Hacer commit
            db.session.commit()
            print("✓ Commit exitoso")
            
            # Verificar la contraseña
            print(f"\n→ Verificando contraseña '{nueva_password}'...")
            if user.check_password(nueva_password):
                print("✅ check_password() funciona correctamente")
            else:
                print("❌ ERROR: check_password() falló")
                return
            
            # Verificar con check_password_hash directo
            if check_password_hash(user.password, nueva_password):
                print("✅ check_password_hash directo funciona")
            else:
                print("❌ ERROR: check_password_hash directo falló")
                return
            
            # Revertir a un password conocido para no bloquear el usuario
            print(f"\n→ Revirtiendo a password anterior...")
            user.password = original_hash
            db.session.commit()
            print("✓ Password revertido")
            
            print("\n" + "="*50)
            print("✅ TODOS LOS TESTS PASARON CORRECTAMENTE")
            print("="*50 + "\n")
            
        except Exception as e:
            db.session.rollback()
            print(f"\n❌ ERROR: {e}")
            import traceback
            traceback.print_exc()

if __name__ == '__main__':
    test_password_change()
