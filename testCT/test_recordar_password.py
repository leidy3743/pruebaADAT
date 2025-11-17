#!/usr/bin/env python3
"""Probar sistema de recordar contraseña (sin email)"""

import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from app import app
from models import db, User

print("=== PRUEBA DEL SISTEMA DE RECORDAR CONTRASEÑA ===\n")

with app.app_context():
    # Buscar un usuario de prueba
    user = User.query.first()
    
    if not user:
        print("❌ No hay usuarios en la base de datos")
        sys.exit(1)
    
    print("✓ Usuario de prueba encontrado:")
    print(f"  Nombre: {user.nombres}")
    print(f"  Usuario: {user.username}")
    print(f"  Email: {user.correo}")
    print(f"  Cédula: {user.cedula if user.cedula else 'No tiene'}")
    
    print("\n=== FLUJO DEL SISTEMA ===")
    print("1. Usuario va a: https://akila.work/forgot-password")
    print("2. Ingresa UNO de estos datos:")
    print(f"   - Cédula: {user.cedula if user.cedula else 'N/A'}")
    print(f"   - Usuario: {user.username}")
    print(f"   - Email: {user.correo}")
    print("3. Click en 'Recordar contraseña'")
    print("4. ✨ El sistema muestra en pantalla:")
    print("   - Usuario")
    print("   - Nueva contraseña temporal (8 caracteres)")
    print("5. Usuario copia las credenciales")
    print("6. Click en 'Iniciar Sesión Ahora'")
    print("7. Usa las credenciales para entrar")
    print("8. Opcional: Cambiar contraseña desde el perfil")
    
    print("\n=== CARACTERÍSTICAS ===")
    print("✅ NO requiere email funcionando")
    print("✅ Muestra credenciales inmediatamente")
    print("✅ Botones para copiar al portapapeles")
    print("✅ Diseño moderno con gradientes")
    print("✅ Genera contraseña temporal segura")
    print("✅ Busca por cédula, usuario o email")
    
    print("\n🎯 Listo para probar en: https://akila.work/forgot-password")
