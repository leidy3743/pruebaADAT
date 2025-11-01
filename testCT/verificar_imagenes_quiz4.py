#!/usr/bin/env python3
"""Verificar imágenes en preguntas Quiz4"""

import os
import sys

# Configurar path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from app import app
from models import QuestionCuatro, db

with app.app_context():
    # Buscar preguntas con imágenes
    preguntas = QuestionCuatro.query.all()
    
    print(f"Total preguntas Quiz4: {len(preguntas)}")
    print("\nPreguntas con imagen:")
    
    for p in preguntas:
        if p.image_url:
            print(f"\nID: {p.id}")
            print(f"  Statement: {p.statement[:50]}...")
            print(f"  Image URL: {p.image_url}")
            
            # Verificar si el archivo existe
            if p.image_url.startswith('/static/'):
                file_path = os.path.join(os.path.dirname(__file__), p.image_url.lstrip('/'))
                exists = os.path.exists(file_path)
                print(f"  ¿Archivo existe? {exists}")
