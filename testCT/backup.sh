#!/bin/bash

# Script de backup automático para base de datos PostgreSQL en Render
# Se ejecuta cada 24 horas y mantiene solo el backup más reciente

# Configuración de la base de datos
DB_HOST="dpg-d3peql2li9vc73bh2lt0-a.oregon-postgres.render.com"
DB_USER="leidy_user"
DB_PASS="uVPTOe32sInjJYl5c1OpF3XFzKi6SKn8"
DB_NAME="leidy"

# Directorio de backups
BACKUP_DIR="/root/pruebaADAT/testCT/backups"

# Timestamp para el nombre del archivo
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.sql"

# Crear directorio si no existe
mkdir -p $BACKUP_DIR

# Ejecutar backup usando Docker
echo "Iniciando backup de la base de datos..."
docker run --rm --env PGPASSWORD=$DB_PASS -v $BACKUP_DIR:/backups postgres:17 pg_dump -h $DB_HOST -U $DB_USER -d $DB_NAME -f /backups/$(basename $BACKUP_FILE)

# Verificar si el backup fue exitoso
if [ $? -eq 0 ] && [ -f $BACKUP_FILE ]; then
    echo "Backup exitoso: $BACKUP_FILE"
    
    # Eliminar todos los backups anteriores (solo mantener el actual)
    find $BACKUP_DIR -name "backup_*.sql" -type f ! -name "$(basename $BACKUP_FILE)" -delete
    
    echo "Backups anteriores eliminados. Solo se mantiene: $(basename $BACKUP_FILE)"
else
    echo "Error: El backup falló. Eliminando archivo incompleto."
    rm -f $BACKUP_FILE
    exit 1
fi