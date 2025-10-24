"""
Script para agregar índices compuestos adicionales para optimizar queries complejas
"""
from app import app, db
from sqlalchemy import text

def create_composite_indexes():
    """Crea índices compuestos para mejorar queries con múltiples condiciones"""
    
    indexes = [
        # Índice compuesto para búsquedas de resultados por usuario y fecha
        """
        CREATE INDEX IF NOT EXISTS idx_resultado_quiz_user_fecha 
        ON resultado_quiz(user_id, fecha_realizacion);
        """,
        
        """
        CREATE INDEX IF NOT EXISTS idx_resultado_quiz_dos_user_fecha 
        ON resultado_quiz_dos(user_id, fecha_realizacion);
        """,
        
        """
        CREATE INDEX IF NOT EXISTS idx_resultado_quiz_tres_user_fecha 
        ON resultado_quiz_tres(user_id, fecha_realizacion);
        """,
        
        """
        CREATE INDEX IF NOT EXISTS idx_resultado_quiz_cuatro_user_fecha 
        ON resultado_quiz_cuatro(user_id, fecha_realizacion);
        """,
        
        # Índices para respuestas con usuario y pregunta
        """
        CREATE INDEX IF NOT EXISTS idx_answer_user_question 
        ON answer(user_id, question_id);
        """,
        
        # Índices para actividades con usuario y estado
        """
        CREATE INDEX IF NOT EXISTS idx_actividad_user_completada 
        ON actividad_generada(user_id, completada);
        """,
        
        # Índice para búsquedas por rol y colegio (común en estadísticas)
        """
        CREATE INDEX IF NOT EXISTS idx_user_rol_colegio 
        ON "user"(rol, colegio_id);
        """,
        
        # Índice para ordenamiento por fecha de creación
        """
        CREATE INDEX IF NOT EXISTS idx_user_created_at 
        ON "user"(created_at DESC);
        """,
        
        # Índices para quiz questions (si existen tablas separadas)
        """
        CREATE INDEX IF NOT EXISTS idx_question_quiz_id 
        ON question(quiz_id) WHERE quiz_id IS NOT NULL;
        """,
        
        """
        CREATE INDEX IF NOT EXISTS idx_question_dos_quiz_id 
        ON question_dos(quiz_id) WHERE quiz_id IS NOT NULL;
        """,
    ]
    
    print("🔧 Creando índices compuestos...")
    print("=" * 60)
    
    created_count = 0
    skipped_count = 0
    
    with app.app_context():
        for idx, sql in enumerate(indexes, 1):
            index_name = sql.split('idx_')[1].split()[0] if 'idx_' in sql else f'index_{idx}'
            try:
                db.session.execute(text(sql))
                db.session.commit()
                print(f"✅ Índice idx_{index_name} creado")
                created_count += 1
            except Exception as e:
                db.session.rollback()
                error_msg = str(e)
                if 'already exists' in error_msg or 'does not exist' in error_msg:
                    if 'does not exist' in error_msg:
                        print(f"⏭️  Tabla no existe para idx_{index_name}, saltando...")
                    else:
                        print(f"ℹ️  Índice idx_{index_name} ya existe")
                    skipped_count += 1
                else:
                    print(f"❌ Error creando idx_{index_name}: {error_msg}")
                    skipped_count += 1
    
    print("=" * 60)
    print(f"\n📊 Resumen:")
    print(f"   ✅ Índices creados: {created_count}")
    print(f"   ⏭️  Índices saltados/existentes: {skipped_count}")
    print(f"   📝 Total procesados: {created_count + skipped_count}")
    
    if created_count > 0:
        print(f"\n🎉 ¡{created_count} índices compuestos creados exitosamente!")
        print("\n💡 Beneficios:")
        print("   • Queries con filtros múltiples (user_id + fecha) más rápidas")
        print("   • Ordenamiento por fecha optimizado")
        print("   • Búsquedas por rol + colegio aceleradas")
        print("   • Mejora en estadísticas y reportes")
    else:
        print("\n✨ Todos los índices ya estaban creados o las tablas no existen")

if __name__ == '__main__':
    create_composite_indexes()
