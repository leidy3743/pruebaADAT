#!/usr/bin/env python3
"""Enviar email de prueba real para recuperación de contraseña"""

import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from app import app, mail
from flask_mail import Message
from models import db, User, PasswordResetToken
from datetime import datetime, timedelta
import secrets

print("=== ENVÍO DE EMAIL DE PRUEBA ===\n")

# Pedir datos al usuario
print("Ingresa los datos para la prueba:")
username_or_cedula = input("Cédula o Usuario: ").strip()
email_destino = input("Email de destino: ").strip()

with app.app_context():
    # Buscar usuario
    user = User.query.filter(
        (User.cedula == username_or_cedula) | (User.username == username_or_cedula)
    ).first()
    
    if not user:
        print(f"\n❌ No se encontró usuario con cédula/usuario: {username_or_cedula}")
        sys.exit(1)
    
    print(f"\n✓ Usuario encontrado: {user.username}")
    print(f"  Nombre: {user.nombres}")
    print(f"  Email registrado: {user.correo}")
    
    if user.correo.lower() != email_destino.lower():
        print(f"\n⚠️  ADVERTENCIA: El email ingresado ({email_destino}) no coincide con el registrado ({user.correo})")
        continuar = input("¿Continuar de todas formas? (s/n): ").lower()
        if continuar != 's':
            print("Cancelado.")
            sys.exit(0)
    
    # Generar token
    print("\n--- Generando token ---")
    token = secrets.token_urlsafe(32)
    expires_at = datetime.utcnow() + timedelta(hours=1)
    
    reset_token = PasswordResetToken(
        user_id=user.id,
        token=token,
        expires_at=expires_at
    )
    db.session.add(reset_token)
    db.session.commit()
    
    print(f"✓ Token generado: {token[:30]}...")
    print(f"  Expira: {expires_at.strftime('%Y-%m-%d %H:%M:%S')}")
    
    # Generar URL de reseteo
    reset_url = f"https://akila.work/reset-password/{token}"
    print(f"  URL: {reset_url}")
    
    # Enviar email
    print("\n--- Enviando email ---")
    try:
        msg = Message(
            subject='Recuperación de Contraseña - ADAT',
            recipients=[email_destino],
            html=f"""
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <style>
        body {{ font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }}
        .container {{ max-width: 600px; margin: 40px auto; background-color: #ffffff; border-radius: 10px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); overflow: hidden; }}
        .header {{ background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px 20px; text-align: center; }}
        .header h1 {{ margin: 0; font-size: 28px; font-weight: 600; }}
        .content {{ padding: 40px 30px; }}
        .button-container {{ text-align: center; margin: 35px 0; }}
        .reset-button {{ display: inline-block; padding: 15px 40px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white !important; text-decoration: none; border-radius: 50px; font-weight: 600; font-size: 16px; }}
        .info-box {{ background-color: #f8f9fa; border-left: 4px solid #667eea; padding: 15px; margin: 25px 0; border-radius: 4px; }}
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🔐 Recuperación de Contraseña</h1>
            <p>Sistema ADAT - Plataforma Educativa</p>
        </div>
        
        <div class="content">
            <div style="font-size: 18px; color: #333; margin-bottom: 20px;">
                Hola <strong>{user.nombres}</strong>,
            </div>
            
            <div style="color: #666; line-height: 1.6; margin-bottom: 30px;">
                <p>Recibimos una solicitud para restablecer la contraseña de tu cuenta en ADAT.</p>
                <p>Si fuiste tú quien solicitó este cambio, haz clic en el siguiente botón:</p>
            </div>
            
            <div class="button-container">
                <a href="{reset_url}" class="reset-button">Restablecer mi contraseña</a>
            </div>
            
            <div class="info-box">
                <p><strong>⏱️ Este enlace expirará en 60 minutos</strong></p>
                <p style="margin: 5px 0 0 0; color: #666; font-size: 14px;">Por razones de seguridad, el enlace solo puede usarse una vez.</p>
            </div>
            
            <div style="color: #666; line-height: 1.6; margin-top: 20px;">
                <p>Si el botón no funciona, copia y pega el siguiente enlace en tu navegador:</p>
                <p style="word-break: break-all; color: #667eea; font-size: 12px;">{reset_url}</p>
            </div>
            
            <div style="margin-top: 20px; padding: 15px; background-color: #fff3cd; border-left: 4px solid #ffc107; border-radius: 4px;">
                <strong style="color: #856404;">⚠️ Nota de seguridad</strong>
                <p style="margin: 5px 0 0 0; color: #856404; font-size: 13px;">
                    Si NO solicitaste este cambio, ignora este correo. Tu contraseña actual seguirá siendo válida.
                </p>
            </div>
        </div>
        
        <div style="background-color: #f8f9fa; padding: 20px; text-align: center; font-size: 12px; color: #999; border-top: 1px solid #e0e0e0;">
            <p><strong>ADAT - Plataforma de Evaluación Educativa</strong></p>
            <p>Universidad del Valle | <a href="https://akila.work" style="color: #667eea; text-decoration: none;">akila.work</a></p>
        </div>
    </div>
</body>
</html>
            """
        )
        
        mail.send(msg)
        print("✅ EMAIL ENVIADO EXITOSAMENTE")
        print(f"\nRevisa la bandeja de entrada de: {email_destino}")
        print("\nPara completar la prueba:")
        print("1. Abre el email recibido")
        print("2. Haz click en el botón de recuperación")
        print(f"3. O accede directamente a: {reset_url}")
        print("4. Establece una nueva contraseña")
        
    except Exception as e:
        print(f"❌ ERROR AL ENVIAR EMAIL: {str(e)}")
        import traceback
        traceback.print_exc()
        
        # Limpiar token si el envío falló
        db.session.delete(reset_token)
        db.session.commit()
        print("\n✓ Token eliminado de la base de datos")
