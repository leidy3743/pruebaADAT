import json
from pathlib import Path

from app import app, db, QuizCuatro

JSON_PATH = Path(__file__).with_name('ctt_questions.json')

def load_questions():
    if not JSON_PATH.exists():
        raise FileNotFoundError(f'No se encontró {JSON_PATH}. Asegúrate de que el archivo exista.')
    data = json.loads(JSON_PATH.read_text(encoding='utf-8'))
    if not isinstance(data, list):
        raise ValueError('El JSON debe ser una lista de preguntas.')
    return data

def upsert_question(q):
    # Campos esperados en el JSON
    statement = q.get('statement')
    option_a = q.get('option_a')
    option_b = q.get('option_b')
    option_c = q.get('option_c')
    option_d = q.get('option_d')
    correct_answer = (q.get('correct_answer') or '').strip().upper()
    label = q.get('label') or 'CTt'
    percentage = q.get('percentage') if q.get('percentage') is not None else 1
    image_url = q.get('image_url') or ''

    if not all([statement, option_a, option_b, option_c, option_d, correct_answer]):
        return False, 'Pregunta incompleta, se omite.'

    # Evita duplicados por statement + label
    exists = QuizCuatro.query.filter_by(statement=statement, label=label).first()
    if exists:
        # Actualiza opciones por si cambian
        exists.option_a = option_a
        exists.option_b = option_b
        exists.option_c = option_c
        exists.option_d = option_d
        exists.correct_answer = correct_answer
        exists.percentage = percentage
        exists.image_url = image_url
        return True, 'actualizada'

    item = QuizCuatro(
        statement=statement,
        option_a=option_a,
        option_b=option_b,
        option_c=option_c,
        option_d=option_d,
        correct_answer=correct_answer,
        label=label,
        percentage=percentage,
        image_url=image_url,
    )
    db.session.add(item)
    return True, 'creada'

def main():
    with app.app_context():
        questions = load_questions()
        created, updated, skipped = 0, 0, 0
        for q in questions:
            ok, status = upsert_question(q)
            if not ok:
                skipped += 1
                continue
            if status == 'creada':
                created += 1
            elif status == 'actualizada':
                updated += 1
        db.session.commit()
        print(f'Preguntas creadas: {created}, actualizadas: {updated}, omitidas: {skipped}')

if __name__ == '__main__':
    main()
