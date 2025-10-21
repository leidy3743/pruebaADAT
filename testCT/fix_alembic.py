from app import db

# Verificar si la tabla de Alembic existe
check = db.engine.execute("SELECT to_regclass('public.alembic_version');").fetchone()[0]

if check:
    print("✅ Tabla alembic_version encontrada, eliminando...")
    db.engine.execute("DROP TABLE alembic_version;")
    print("🗑️  Tabla alembic_version eliminada correctamente.")
else:
    print("⚠️  No se encontró la tabla alembic_version (ya estaba eliminada).")
