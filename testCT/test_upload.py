#!/usr/bin/env python3
"""Script para probar el upload de imágenes en Quiz4"""

import os

# Verificar que existe la carpeta uploads
upload_folder = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'static', 'uploads')
print(f"Carpeta de uploads: {upload_folder}")
print(f"¿Existe? {os.path.exists(upload_folder)}")
print(f"¿Es escribible? {os.access(upload_folder, os.W_OK)}")

# Listar archivos en la carpeta
if os.path.exists(upload_folder):
    archivos = os.listdir(upload_folder)
    print(f"\nArchivos en uploads ({len(archivos)}):")
    for f in archivos[:10]:  # Mostrar solo los primeros 10
        print(f"  - {f}")
