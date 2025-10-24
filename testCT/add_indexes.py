"""
Script para agregar índices críticos a la base de datos
Ejecutar: python add_indexes.py
"""
from app import app, db
from sqlalchemy import text

with app.app_context():
    try:
        print("Agregando índices para mejorar rendimiento...")
        
        # Índices en tabla user
        db.session.execute(text('CREATE INDEX IF NOT EXISTS idx_user_username ON "user"(username)'))
        db.session.execute(text('CREATE INDEX IF NOT EXISTS idx_user_correo ON "user"(correo)'))
        db.session.execute(text('CREATE INDEX IF NOT EXISTS idx_user_rol ON "user"(rol)'))
        db.session.execute(text('CREATE INDEX IF NOT EXISTS idx_user_colegio ON "user"(colegio_id)'))
        
        # Índices en resultados de quizzes
        db.session.execute(text('CREATE INDEX IF NOT EXISTS idx_resultado_quiz_user ON resultado_quiz(user_id)'))
        db.session.execute(text('CREATE INDEX IF NOT EXISTS idx_resultado_quiz_dos_user ON resultado_quiz_dos(user_id)'))
        db.session.execute(text('CREATE INDEX IF NOT EXISTS idx_resultado_quiz_tres_user ON resultado_quiz_tres(user_id)'))
        db.session.execute(text('CREATE INDEX IF NOT EXISTS idx_resultado_quiz_cuatro_user ON resultado_quiz_cuatro(user_id)'))
        
        # Índices en Answer
        db.session.execute(text('CREATE INDEX IF NOT EXISTS idx_answer_user ON answer(user_id)'))
        db.session.execute(text('CREATE INDEX IF NOT EXISTS idx_answer_question ON answer(question_id)'))
        
        # Índices en actividades generadas
        db.session.execute(text('CREATE INDEX IF NOT EXISTS idx_actividad_user ON actividad_generada(user_id)'))
        
        db.session.commit()
        print("✅ Índices creados exitosamente")
        
        # Mostrar estadísticas
        result = db.session.execute(text("""
            SELECT schemaname, tablename, indexname 
            FROM pg_indexes 
            WHERE schemaname = 'public' AND indexname LIKE 'idx_%'
            ORDER BY tablename, indexname
        """))
        
        print("\n📊 Índices creados:")
        for row in result:
            print(f"  - {row[1]}.{row[2]}")
            
    except Exception as e:
        db.session.rollback()
        print(f"❌ Error: {e}")
