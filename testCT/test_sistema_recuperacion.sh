#!/bin/bash
# Script para probar el sistema de recuperación de contraseña

echo "=== PRUEBA DEL SISTEMA DE RECUPERACIÓN ==="
echo ""
echo "📋 Checklist de verificación:"
echo ""

# 1. Verificar página de login
echo -n "1. ✓ Página de login accesible... "
if curl -s -o /dev/null -w "%{http_code}" https://akila.work/login | grep -q "200"; then
    echo "✅ OK"
else
    echo "❌ FALLO"
fi

# 2. Verificar página forgot-password
echo -n "2. ✓ Página de recuperación accesible... "
if curl -s -o /dev/null -w "%{http_code}" https://akila.work/forgot-password | grep -q "200"; then
    echo "✅ OK"
else
    echo "❌ FALLO"
fi

# 3. Verificar enlace en login
echo -n "3. ✓ Enlace en login presente... "
if curl -s https://akila.work/login | grep -q "Olvidaste tu contraseña"; then
    echo "✅ OK"
else
    echo "❌ FALLO"
fi

# 4. Verificar tabla en BD
echo -n "4. ✓ Tabla password_reset_tokens existe... "
if docker exec adat_db psql -U postgres -d postgres -c "\dt password_reset_tokens" 2>/dev/null | grep -q "password_reset_tokens"; then
    echo "✅ OK"
else
    echo "❌ FALLO"
fi

# 5. Verificar Flask-Mail instalado
echo -n "5. ✓ Flask-Mail instalado... "
if docker exec adat_app python3 -c "import flask_mail" 2>/dev/null; then
    echo "✅ OK"
else
    echo "❌ FALLO"
fi

echo ""
echo "=== INSTRUCCIONES PARA PRUEBA MANUAL ===" 
echo ""
echo "1. Abre en tu navegador: https://akila.work/login"
echo "2. Click en el enlace azul: '¿Olvidaste tu contraseña?'"
echo "3. Ingresa:"
echo "   - Cédula o Usuario: [tu usuario]"
echo "   - Email: [tu email registrado]"
echo "4. Click en 'Enviar instrucciones'"
echo "5. Revisa tu bandeja de entrada"
echo "6. Abre el email de 'ADAT - Sistema de Recuperación'"
echo "7. Click en el botón morado 'Restablecer mi contraseña'"
echo "8. Ingresa tu nueva contraseña (mínimo 6 caracteres)"
echo "9. Confirma la contraseña"
echo "10. ¡Listo! Ya puedes iniciar sesión con tu nueva contraseña"
echo ""
echo "📧 Configuración de Email:"
echo "   Servidor: smtp.gmail.com:587"
echo "   Usuario: carlos.hidalgo@correounivalle.edu.co"
echo ""
echo "💡 Si no recibes el email, revisa la carpeta de SPAM"
echo ""
