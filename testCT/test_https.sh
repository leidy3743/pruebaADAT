#!/bin/bash
# Script de diagnóstico HTTPS para akila.work

echo "==================================="
echo "   DIAGNÓSTICO HTTPS - akila.work"
echo "==================================="
echo ""

echo "1. Resolviendo DNS..."
dig akila.work +short
echo ""

echo "2. Certificado SSL..."
echo | openssl s_client -connect akila.work:443 -servername akila.work 2>/dev/null | openssl x509 -noout -subject -issuer -dates
echo ""

echo "3. Headers de seguridad..."
curl -Iks https://akila.work | grep -iE 'http|server|strict-transport|x-frame|x-content|x-xss|referrer|permissions'
echo ""

echo "4. Test de conectividad..."
curl -o /dev/null -s -w "Código HTTP: %{http_code}\nTiempo total: %{time_total}s\nSSL verify: %{ssl_verify_result}\n" https://akila.work
echo ""

echo "5. Verificando robots.txt..."
curl -s https://akila.work/robots.txt
echo ""

echo "==================================="
echo "   FIN DEL DIAGNÓSTICO"
echo "==================================="
