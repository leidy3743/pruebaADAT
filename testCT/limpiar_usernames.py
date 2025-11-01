#!/usr/bin/env python3
"""Script para limpiar usernames con espacios, manejando duplicados"""

import sys
import os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from app import app, db
from models import User

def limpiar_usernames():
    """Limpia usernames con espacios, agregando números a duplicados"""
    with app.app_context():
        print("\n" + "="*70)
        print("  LIMPIEZA DE USERNAMES CON ESPACIOS")
        print("="*70 + "\n")
        
        users = User.query.all()
        cleaned = 0
        conflicts = 0
        
        for user in users:
            original = user.username
            cleaned_username = user.username.strip()
            
            if original != cleaned_username:
                print(f"• ID {user.id:3} | [{original}] → [{cleaned_username}]")
                
                # Verificar si ya existe
                existing = User.query.filter_by(username=cleaned_username).filter(User.id != user.id).first()
                
                if existing:
                    print(f"  ⚠️  Ya existe '{cleaned_username}' (ID {existing.id})")
                    
                    # Buscar un username disponible agregando número
                    counter = 2
                    new_username = f"{cleaned_username}{counter}"
                    
                    while User.query.filter_by(username=new_username).first():
                        counter += 1
                        new_username = f"{cleaned_username}{counter}"
                    
                    print(f"  → Renombrando a: [{new_username}]")
                    user.username = new_username
                    conflicts += 1
                else:
                    user.username = cleaned_username
                
                cleaned += 1
        
        if cleaned > 0:
            try:
                db.session.commit()
                print(f"\n✅ Proceso completado:")
                print(f"   • Usernames limpiados: {cleaned}")
                print(f"   • Conflictos resueltos: {conflicts}")
            except Exception as e:
                db.session.rollback()
                print(f"\n❌ Error al guardar: {e}")
        else:
            print("✅ No se encontraron usernames con espacios")
        
        print("\n" + "="*70 + "\n")

if __name__ == '__main__':
    limpiar_usernames()
