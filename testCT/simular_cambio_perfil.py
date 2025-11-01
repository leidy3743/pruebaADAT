#!/usr/bin/env python3
"""Script para simular exactamente el cambio de contraseña desde /profile"""

import sys
import os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from app import app, db
from models import User

def simular_cambio_perfil(username, nueva_password):
    """Simula exactamente lo que hace la ruta /profile"""
    with app.app_context():
        print("\n" + "="*70)
        print(f"  SIMULACIÓN DE CAMBIO DE CONTRASEÑA EN /PROFILE")
        print("="*70 + "\n")
        
        # PASO 1: Obtener el usuario (como current_user)
        print("PASO 1: Obtener usuario")
        user = User.query.filter_by(username=username).first()
        
        if not user:
            print(f"❌ Usuario '{username}' no encontrado")
            return False
        
        print(f"✓ Usuario: {user.username}")
        print(f"  Hash antes: {user.password[:60]}...")
        
        # PASO 2: Validar longitud
        print(f"\nPASO 2: Validar longitud de nueva contraseña")
        if len(nueva_password) < 6:
            print(f"❌ Contraseña muy corta (mínimo 6 caracteres)")
            return False
        print(f"✓ Longitud válida: {len(nueva_password)} caracteres")
        
        # PASO 3: Ejecutar set_password (como en /profile)
        print(f"\nPASO 3: Ejecutar set_password('{nueva_password}')")
        try:
            user.set_password(nueva_password)
            print(f"✓ set_password ejecutado")
            print(f"  Hash después: {user.password[:60]}...")
        except Exception as e:
            print(f"❌ Error en set_password: {e}")
            return False
        
        # PASO 4: Commit (como en /profile)
        print(f"\nPASO 4: Hacer commit a la base de datos")
        try:
            db.session.commit()
            print(f"✓ Commit exitoso")
        except Exception as e:
            db.session.rollback()
            print(f"❌ Error en commit: {e}")
            return False
        
        # PASO 5: Verificar en la BD
        print(f"\nPASO 5: Verificar en base de datos (query fresh)")
        user_fresh = User.query.filter_by(username=username).first()
        print(f"✓ Usuario refrescado")
        print(f"  Hash en BD: {user_fresh.password[:60]}...")
        
        # PASO 6: Probar login
        print(f"\nPASO 6: Simular login (check_password)")
        print(f"  Probando contraseña: '{nueva_password}'")
        
        if user_fresh.check_password(nueva_password):
            print(f"  ✅ check_password() = True")
            print(f"\n" + "="*70)
            print(f"✅ ÉXITO: Contraseña cambiada correctamente")
            print(f"   Usuario: {username}")
            print(f"   Nueva contraseña: {nueva_password}")
            print(f"="*70 + "\n")
            return True
        else:
            print(f"  ❌ check_password() = False")
            print(f"\n⚠️  ERROR: La contraseña no funciona después del cambio")
            return False

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("Uso: python3 simular_cambio_perfil.py <username> <nueva_password>")
        print("\nEjemplo: python3 simular_cambio_perfil.py Baquero MiNuevaPassword123")
        sys.exit(1)
    
    username = sys.argv[1]
    nueva_password = sys.argv[2]
    
    success = simular_cambio_perfil(username, nueva_password)
    sys.exit(0 if success else 1)
