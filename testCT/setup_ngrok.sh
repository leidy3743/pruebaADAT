#!/bin/bash
# Script para configurar y ejecutar ngrok

echo "==================================="
echo "  CONFIGURACIÓN DE NGROK"
echo "==================================="
echo ""

# Verificar si ngrok está instalado
if ! command -v ngrok &> /dev/null; then
    echo "❌ ngrok no está instalado"
    echo "Instalar con: snap install ngrok"
    exit 1
fi

echo "✅ ngrok está instalado ($(ngrok version))"
echo ""

# Verificar configuración
if [ ! -f ~/.config/ngrok/ngrok.yml ]; then
    echo "⚠️  ngrok no está configurado"
    echo ""
    echo "Pasos para configurar:"
    echo "1. Crear cuenta gratuita: https://dashboard.ngrok.com/signup"
    echo "2. Obtener authtoken: https://dashboard.ngrok.com/get-started/your-authtoken"
    echo "3. Ejecutar: ngrok config add-authtoken TU_TOKEN"
    echo ""
    read -p "¿Tienes un authtoken? (s/n): " tiene_token
    
    if [ "$tiene_token" = "s" ] || [ "$tiene_token" = "S" ]; then
        read -p "Ingresa tu authtoken: " token
        ngrok config add-authtoken "$token"
        echo "✅ Token configurado"
    else
        echo ""
        echo "❌ No se puede continuar sin authtoken"
        echo "Por favor, obtén tu token en: https://dashboard.ngrok.com/get-started/your-authtoken"
        exit 1
    fi
fi

echo ""
echo "🚀 Iniciando ngrok en puerto 80..."
echo ""
echo "NOTA: Deja esta terminal abierta mientras uses el túnel"
echo "Presiona Ctrl+C para detener ngrok"
echo ""
echo "==================================="
echo ""

# Iniciar ngrok
ngrok http 80
