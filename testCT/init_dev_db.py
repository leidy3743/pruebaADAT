from app import app, db, User, QuizCuatro
from werkzeug.security import generate_password_hash

DUMMY_QUESTIONS = [
    {
        "statement": "CTt Pregunta de prueba 1",
        "option_a": "A1",
        "option_b": "B1",
        "option_c": "C1",
        "option_d": "D1",
        "correct_answer": "A",
        "label": "CTt",
        "percentage": 1,
        "image_url": "",
    },
    {
        "statement": "CTt Pregunta de prueba 2",
        "option_a": "A2",
        "option_b": "B2",
        "option_c": "C2",
        "option_d": "D2",
        "correct_answer": "B",
        "label": "CTt",
        "percentage": 1,
        "image_url": "",
    },
]


def ensure_user(username="user1", password="pass1"):
    u = User.query.filter_by(username=username).first()
    if u:
        return u
    user = User(
        nombres="Usuario Prueba",
        correo=f"{username}@example.com",
        edad=30,
        colegio_id=None,
        nivel_educativo="Secundaria",
        rol="docente",
        anios_experiencia=1,
        username=username,
        password=generate_password_hash(password),
    )
    db.session.add(user)
    db.session.commit()
    return user


def ensure_questions():
    if QuizCuatro.query.count() >= 2:
        return
    for q in DUMMY_QUESTIONS:
        item = QuizCuatro(**q)
        db.session.add(item)
    db.session.commit()


if __name__ == "__main__":
    with app.app_context():
        # Si usas SQLite para pruebas, crea tablas
        db.create_all()
        ensure_user()
        ensure_questions()
        print("DB de desarrollo lista: usuario user1/pass1 y preguntas CTt dummy creadas.")
