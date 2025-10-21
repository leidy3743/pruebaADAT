#!/usr/bin/env python3
"""Script para crear la tabla actividad_generada en la base de datos"""

from app import app, db
from sqlalchemy import text

with app.app_context():
    # Crear tabla actividad_generada
    db.session.execute(text('''
        CREATE TABLE IF NOT EXISTS actividad_generada (
            id SERIAL PRIMARY KEY,
            user_id INTEGER NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
            nombre_profesor VARCHAR(200) NOT NULL,
            grado VARCHAR(50) NOT NULL,
            asignatura VARCHAR(200) NOT NULL,
            tematica VARCHAR(500) NOT NULL,
            cantidad_estudiantes INTEGER NOT NULL,
            tipo_actividad VARCHAR(50) NOT NULL,
            tiempo INTEGER NOT NULL,
            recursos VARCHAR(1000) NOT NULL,
            contenido TEXT NOT NULL,
            fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        )
    '''))
    
    # Crear índice para user_id
    db.session.execute(text('''
        CREATE INDEX IF NOT EXISTS idx_actividad_user_id ON actividad_generada(user_id)
    '''))
    
    db.session.commit()
    print('✅ Tabla actividad_generada creada exitosamente')
    print('✅ Índice idx_actividad_user_id creado exitosamente')
