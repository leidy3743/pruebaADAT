"""Script para agregar la columna cedula a la tabla user"""
from app import app, db
from sqlalchemy import inspect, text

with app.app_context():
    try:
        insp = inspect(db.engine)
        if 'user' in insp.get_table_names():
            cols = insp.get_columns('user')
            col_names = [c.get('name') for c in cols]
            
            if 'cedula' not in col_names:
                print('Agregando columna cedula...')
                db.session.execute(text('ALTER TABLE "user" ADD COLUMN cedula VARCHAR(20)'))
                db.session.commit()
                print('✅ Columna cedula agregada exitosamente')
            else:
                print('✅ La columna cedula ya existe')
        else:
            print('⚠️ La tabla user no existe')
    except Exception as e:
        db.session.rollback()
        print(f'❌ Error: {e}')
