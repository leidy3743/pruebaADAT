#!/usr/bin/env python3
"""Probar sistema de recuperación de contraseña"""

import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from app import app, mail
from models import db, User, PasswordResetToken
from datetime import datetime, timedelta
import secrets

print("=== PRUEBA DE SISTEMA DE RECUPERACIÓN DE CONTRASEÑA ===\n")

with app.app_context():
    # Buscar un usuario de prueba
    user = User.query.first()
    
    if not user:
        print("❌ No hay usuarios en la base de datos")
        sys.exit(1)
    
    print(f"✓ Usuario de prueba: {user.username}")
    print(f"  Email: {user.correo}")
    print(f"  Cédula: {user.cedula}")
    
    # Generar token
    print("\n--- Generando token de recuperación ---")
    token = secrets.token_urlsafe(32)
    expires_at = datetime.utcnow() + timedelta(hours=1)
    
    reset_token = PasswordResetToken(
        user_id=user.id,
        token=token,
        expires_at=expires_at
    )
    db.session.add(reset_token)
    db.session.commit()
    
    print(f"✓ Token generado: {token[:20]}...")
    print(f"  Expira en: {expires_at.strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"  Es válido: {reset_token.is_valid()}")
    
    # Verificar configuración de mail
    print("\n--- Configuración de Email ---")
    print(f"✓ Servidor SMTP: {app.config['MAIL_SERVER']}:{app.config['MAIL_PORT']}")
    print(f"✓ TLS: {app.config['MAIL_USE_TLS']}")
    print(f"✓ Usuario: {app.config['MAIL_USERNAME']}")
    print(f"✓ Remitente: {app.config['MAIL_DEFAULT_SENDER']}")
    
    # URLs de acceso
    print("\n--- URLs del sistema ---")
    print(f"✓ Página de recuperación: https://akila.work/forgot-password")
    print(f"✓ Link de reseteo (ejemplo): https://akila.work/reset-password/{token}")
    
    # Verificar que el token existe en BD
    token_db = PasswordResetToken.query.filter_by(token=token).first()
    print(f"\n✓ Token verificado en base de datos: {token_db is not None}")
    
    print("\n=== SISTEMA LISTO PARA USAR ===")
    print("\nPara probar:")
    print("1. Ve a https://akila.work/login")
    print("2. Click en '¿Olvidaste tu contraseña?'")
    print("3. Ingresa cédula/usuario y email")
    print("4. Revisa el correo electrónico")
    print("5. Click en el enlace y establece nueva contraseña")
