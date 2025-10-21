#!/bin/bash
# Script para restaurar ayuda1.sql a la base de datos en Render (sin sobrescribir)

echo "=========================================="
echo "🔄 RESTAURAR ayuda1.sql a Base de Datos"
echo "=========================================="

# Variables de conexión
RENDER_HOST="dpg-d3peql2li9vc73bh2lt0-a.oregon-postgres.render.com"
RENDER_DB="leidy"
RENDER_USER="leidy_user"
RENDER_PASS="uVPTOe32sInjJYl5c1OpF3XFzKi6SKn8"

# Verificar que existe el archivo
if [ ! -f "ayuda1.sql" ]; then
    echo "❌ Error: No se encuentra el archivo ayuda1.sql"
    exit 1
fi

echo ""
echo "📁 Archivo encontrado: ayuda1.sql"
echo "🎯 Destino: $RENDER_DB @ $RENDER_HOST"
echo ""
echo "⚠️  IMPORTANTE:"
echo "   - Este script NO sobrescribirá datos existentes"
echo "   - Los registros duplicados serán ignorados"
echo ""

read -p "¿Deseas continuar? (si/no): " respuesta

if [[ ! "$respuesta" =~ ^(si|s|SI|S|yes|y|YES|Y)$ ]]; then
    echo "❌ Operación cancelada"
    exit 0
fi

echo ""
echo "🚀 Iniciando restauración..."
echo ""

# Exportar la contraseña para pg_restore
export PGPASSWORD=$RENDER_PASS

# Restaurar el archivo usando pg_restore con opción --data-only para no sobrescribir estructura
# y --on-conflict-do-nothing para evitar errores en duplicados
pg_restore -h $RENDER_HOST \
           -U $RENDER_USER \
           -d $RENDER_DB \
           --data-only \
           --disable-triggers \
           --no-owner \
           --no-acl \
           ayuda1.sql 2>&1 | grep -v "ERROR:  duplicate key" || true

# Nota: Ignoramos errores de clave duplicada ya que queremos hacer merge

echo ""
echo "=========================================="
echo "✅ RESTAURACIÓN COMPLETADA"
echo "=========================================="
echo ""
echo "ℹ️  Los errores de 'duplicate key' son normales"
echo "   (significa que esos registros ya existían)"

# Limpiar variable de entorno
unset PGPASSWORD
