#!/usr/bin/env python3
"""
Script para hacer merge de datos de ayuda1.sql a la base de datos de Render
sin sobrescribir datos existentes.
"""

import psycopg
from psycopg import sql
import sys

# Configuración de la base de datos destino (Render)
RENDER_DB_URL = "postgresql://leidy_user:uVPTOe32sInjJYl5c1OpF3XFzKi6SKn8@dpg-d3peql2li9vc73bh2lt0-a.oregon-postgres.render.com/leidy"

# Configuración de la base de datos fuente (local ayuda)
LOCAL_DB_URL = "postgresql://postgres:lady@localhost/ayuda"

def get_table_names(conn):
    """Obtiene los nombres de todas las tablas de usuario"""
    with conn.cursor() as cur:
        cur.execute("""
            SELECT tablename 
            FROM pg_tables 
            WHERE schemaname = 'public'
            AND tablename NOT LIKE 'alembic%'
            ORDER BY tablename;
        """)
        return [row[0] for row in cur.fetchall()]

def get_primary_key_column(conn, table_name):
    """Obtiene el nombre de la columna de clave primaria"""
    with conn.cursor() as cur:
        cur.execute("""
            SELECT a.attname
            FROM pg_index i
            JOIN pg_attribute a ON a.attrelid = i.indrelid
                AND a.attnum = ANY(i.indkey)
            WHERE i.indrelid = %s::regclass
            AND i.indisprimary;
        """, (table_name,))
        result = cur.fetchone()
        return result[0] if result else None

def get_table_columns(conn, table_name):
    """Obtiene las columnas de una tabla"""
    with conn.cursor() as cur:
        cur.execute("""
            SELECT column_name 
            FROM information_schema.columns 
            WHERE table_name = %s
            ORDER BY ordinal_position;
        """, (table_name,))
        return [row[0] for row in cur.fetchall()]

def merge_table_data(source_conn, dest_conn, table_name):
    """Hace merge de datos de una tabla sin sobrescribir"""
    print(f"\n📋 Procesando tabla: {table_name}")
    
    # Obtener columnas
    columns = get_table_columns(source_conn, table_name)
    if not columns:
        print(f"  ⚠️  No se encontraron columnas para {table_name}")
        return
    
    # Obtener clave primaria
    pk_column = get_primary_key_column(source_conn, table_name)
    
    # Leer datos de origen
    with source_conn.cursor() as cur:
        cols_str = ", ".join([f'"{col}"' for col in columns])
        cur.execute(f'SELECT {cols_str} FROM "{table_name}"')
        source_data = cur.fetchall()
    
    if not source_data:
        print(f"  ℹ️  No hay datos en la tabla fuente")
        return
    
    print(f"  📊 Encontrados {len(source_data)} registros en origen")
    
    # Insertar datos en destino (ignorando duplicados)
    inserted = 0
    skipped = 0
    
    with dest_conn.cursor() as cur:
        cols_str = ", ".join([f'"{col}"' for col in columns])
        placeholders = ", ".join(["%s"] * len(columns))
        
        for row in source_data:
            try:
                # Intentar insertar
                insert_query = f'INSERT INTO "{table_name}" ({cols_str}) VALUES ({placeholders})'
                
                if pk_column:
                    # Si hay clave primaria, usar ON CONFLICT DO NOTHING
                    insert_query += f' ON CONFLICT ("{pk_column}") DO NOTHING'
                
                cur.execute(insert_query, row)
                
                if cur.rowcount > 0:
                    inserted += 1
                else:
                    skipped += 1
                    
            except Exception as e:
                skipped += 1
                print(f"  ⚠️  Error al insertar registro: {e}")
                dest_conn.rollback()
        
        dest_conn.commit()
    
    print(f"  ✅ Insertados: {inserted}, Omitidos (ya existían): {skipped}")

def main():
    print("=" * 60)
    print("🔄 MERGE DE DATOS: ayuda1 → leidy (Render)")
    print("=" * 60)
    
    try:
        # Conectar a base de datos fuente (local)
        print("\n🔌 Conectando a base de datos LOCAL (ayuda)...")
        source_conn = psycopg.connect(LOCAL_DB_URL)
        print("  ✅ Conectado a base de datos fuente")
        
        # Conectar a base de datos destino (Render)
        print("\n🔌 Conectando a base de datos RENDER (leidy)...")
        dest_conn = psycopg.connect(RENDER_DB_URL)
        print("  ✅ Conectado a base de datos destino")
        
        # Obtener tablas
        tables = get_table_names(source_conn)
        print(f"\n📑 Tablas encontradas: {len(tables)}")
        print(f"  {', '.join(tables)}")
        
        # Confirmar antes de continuar
        print("\n⚠️  Este script hará MERGE de datos (no sobrescribirá registros existentes)")
        respuesta = input("¿Deseas continuar? (si/no): ").lower()
        
        if respuesta not in ['si', 's', 'yes', 'y']:
            print("\n❌ Operación cancelada")
            return
        
        # Procesar cada tabla
        print("\n" + "=" * 60)
        print("🚀 Iniciando merge de datos...")
        print("=" * 60)
        
        for table in tables:
            try:
                merge_table_data(source_conn, dest_conn, table)
            except Exception as e:
                print(f"  ❌ Error en tabla {table}: {e}")
        
        print("\n" + "=" * 60)
        print("✅ MERGE COMPLETADO")
        print("=" * 60)
        
        # Cerrar conexiones
        source_conn.close()
        dest_conn.close()
        
    except psycopg.OperationalError as e:
        print(f"\n❌ Error de conexión: {e}")
        print("\nVerifica que:")
        print("  1. PostgreSQL esté corriendo localmente")
        print("  2. La base de datos 'ayuda' existe localmente")
        print("  3. Las credenciales sean correctas")
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ Error inesperado: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
