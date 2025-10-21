#!/usr/bin/env python3
"""
Script para crear el usuario administrador leidy_admin
"""

from werkzeug.security import generate_password_hash
import psycopg

# Configuración de la base de datos
DATABASE_URL = "postgresql://leidy_user:uVPTOe32sInjJYl5c1OpF3XFzKi6SKn8@dpg-d3peql2li9vc73bh2lt0-a.oregon-postgres.render.com/leidy"

def crear_usuario_admin():
    try:
        # Conectar a la base de datos
        conn = psycopg.connect(DATABASE_URL)
        cur = conn.cursor()
        
        # Hashear la contraseña
        password_hash = generate_password_hash('leidy_admin', method='pbkdf2:sha256')
        
        # Verificar si el usuario ya existe
        cur.execute("SELECT id FROM \"user\" WHERE username = 'leidy_admin'")
        if cur.fetchone():
            print("⚠️  El usuario 'leidy_admin' ya existe")
            return
        
        # Insertar el usuario administrador
        cur.execute("""
            INSERT INTO "user" 
            (nombres, correo, edad, username, password, nivel_educativo, anios_experiencia, rol, institucion)
            VALUES 
            (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (
            'Administrador ADAT',
            'admin@adat.com',
            30,
            'leidy_admin',
            password_hash,
            'Administrador',
            5,
            'admin',
            'ADAT System'
        ))
        
        conn.commit()
        print("✅ Usuario 'leidy_admin' creado exitosamente")
        print("   Username: leidy_admin")
        print("   Password: leidy_admin")
        print("   Rol: admin")
        
        cur.close()
        conn.close()
        
    except Exception as e:
        print(f"❌ Error al crear usuario: {e}")

if __name__ == "__main__":
    crear_usuario_admin()
