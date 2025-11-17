#!/usr/bin/env python3
"""Crear tabla password_reset_tokens"""

import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from app import app
from models import db

with app.app_context():
    # Crear tabla directamente
    db.engine.execute("""
        CREATE TABLE IF NOT EXISTS password_reset_tokens (
            id SERIAL PRIMARY KEY,
            user_id INTEGER NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
            token VARCHAR(100) UNIQUE NOT NULL,
            created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            expires_at TIMESTAMP NOT NULL,
            used BOOLEAN NOT NULL DEFAULT FALSE
        );
        
        CREATE INDEX IF NOT EXISTS idx_token ON password_reset_tokens(token);
        CREATE INDEX IF NOT EXISTS idx_user_id ON password_reset_tokens(user_id);
    """)
    
    print("✓ Tabla password_reset_tokens creada exitosamente")
