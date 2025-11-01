#!/usr/bin/env python3
"""Script para verificar login de un usuario"""

import sys
import os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from app import app, db
from models import User

def verificar_login(username, password):
    """Verifica si las credenciales son correctas"""
    with app.app_context():
        print("\n" + "="*70)
        print(f"  VERIFICACIÓN DE LOGIN")
        print("="*70 + "\n")
        
        # Simular exactamente lo que hace /login
        print(f"→ Buscando usuario: '{username}'")
        user = User.query.filter_by(username=username).first()
        
        if not user:
            print(f"❌ Usuario no encontrado")
            return False
        
        print(f"✓ Usuario encontrado: {user.username}")
        print(f"  Email: {user.correo}")
        print(f"  Rol: {user.rol}")
        print(f"  Hash: {user.password[:60]}...")
        
        print(f"\n→ Verificando contraseña: '{password}'")
        password_match = user.check_password(password)
        
        if password_match:
            print(f"✅ CONTRASEÑA CORRECTA")
            print(f"\n✓ Login exitoso para '{username}'")
            return True
        else:
            print(f"❌ CONTRASEÑA INCORRECTA")
            print(f"\n✗ Login fallido para '{username}'")
            return False

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("Uso: python3 verificar_login.py <username> <password>")
        print("\nEjemplo: python3 verificar_login.py Baquero TestPass123")
        sys.exit(1)
    
    username = sys.argv[1]
    password = ' '.join(sys.argv[2:])  # Por si la contraseña tiene espacios
    
    success = verificar_login(username, password)
    
    print("\n" + "="*70 + "\n")
    sys.exit(0 if success else 1)
