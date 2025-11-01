#!/usr/bin/env python3
"""Script para diagnosticar y resetear contraseña de un usuario específico"""

import sys
import os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from app import app, db
from models import User
from werkzeug.security import check_password_hash

def diagnosticar_usuario(username):
    """Diagnostica la contraseña de un usuario"""
    with app.app_context():
        print("\n" + "="*70)
        print(f"  DIAGNÓSTICO DE CONTRASEÑA: {username}")
        print("="*70 + "\n")
        
        user = User.query.filter_by(username=username).first()
        
        if not user:
            print(f"❌ Usuario '{username}' no encontrado")
            return
        
        print(f"✓ Usuario encontrado")
        print(f"  ID: {user.id}")
        print(f"  Username: {user.username}")
        print(f"  Email: {user.correo}")
        print(f"  Rol: {user.rol}")
        print(f"\n🔐 Hash actual:")
        print(f"  {user.password}")
        
        # Detectar el método de hash
        if user.password.startswith('pbkdf2:sha256:260000'):
            print(f"\n  ℹ️  Método: pbkdf2:sha256 con 260000 iteraciones (NUEVO)")
        elif user.password.startswith('pbkdf2:sha256:1000000'):
            print(f"\n  ℹ️  Método: pbkdf2:sha256 con 1000000 iteraciones (ANTIGUO)")
        elif user.password.startswith('pbkdf2:sha256'):
            print(f"\n  ℹ️  Método: pbkdf2:sha256 (ESTÁNDAR)")
        else:
            print(f"\n  ⚠️  Método: DESCONOCIDO")
        
        # Probar contraseñas comunes
        print(f"\n🔍 Probando contraseñas comunes...")
        contraseñas_test = [
            username,  # mismo que username
            username.lower(),
            username.upper(),
            '123456',
            '1234567',
            'password',
            'admin123',
        ]
        
        for pwd in contraseñas_test:
            if user.check_password(pwd):
                print(f"  ✅ ENCONTRADA: '{pwd}'")
                return pwd
            else:
                print(f"  ❌ No: '{pwd}'")
        
        print(f"\n⚠️  No se encontró la contraseña entre las comunes")
        
        # Ofrecer resetear
        print(f"\n" + "-"*70)
        print(f"¿Deseas resetear la contraseña de '{username}'?")
        respuesta = input("Ingresa la nueva contraseña (o Enter para cancelar): ").strip()
        
        if respuesta:
            try:
                user.set_password(respuesta)
                db.session.commit()
                print(f"\n✅ Contraseña actualizada exitosamente")
                print(f"   Nueva contraseña: '{respuesta}'")
                print(f"   Nuevo hash: {user.password[:60]}...")
                
                # Verificar
                if user.check_password(respuesta):
                    print(f"   ✓ Verificación exitosa")
                else:
                    print(f"   ❌ ERROR: Verificación falló")
            except Exception as e:
                db.session.rollback()
                print(f"\n❌ Error: {e}")
        else:
            print(f"\nCancelado.")
        
        print(f"\n" + "="*70 + "\n")

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Uso: python3 diagnosticar_password.py <username>")
        print("\nEjemplo: python3 diagnosticar_password.py Baquero")
        sys.exit(1)
    
    username = sys.argv[1]
    diagnosticar_usuario(username)
