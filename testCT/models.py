from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

db = SQLAlchemy()

usuarios_cursos = db.Table('usuarios_cursos',
    db.Column('user_id', db.Integer, db.ForeignKey('user.id'), primary_key=True),
    db.Column('curso_id', db.Integer, db.ForeignKey('curso.id'), primary_key=True)
)

nivel_por_grados = db.Table('nivel_por_grados',
    db.Column('user_id', db.Integer, db.ForeignKey('user.id'), primary_key=True),
    db.Column('nivel_id', db.Integer, db.ForeignKey('nivel.id'), primary_key=True)
)
grados_dictados = db.Table('grados_dictados',
    db.Column('user_id', db.Integer, db.ForeignKey('user.id'), primary_key=True),
    db.Column('grado_id', db.Integer, db.ForeignKey('grado.id'), primary_key=True)
)

"""usuarios_cursos_grados = db.Table('usuarios_cursos_grados',
    db.Column('usuario_id', db.Integer, db.ForeignKey('user.id'), primary_key=True),
    db.Column('curso_id', db.Integer, db.ForeignKey('curso.id'), primary_key=True),
    db.Column('grado_id', db.Integer, db.ForeignKey('grado.id'), primary_key=True)
)"""

class Nivel(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), unique=True, nullable=False)

    def __repr__(self):
        return f'<Colegio {self.nombre}>'

class Curso(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), unique=True, nullable=False)

    def __repr__(self):
        return f'<Colegio {self.nombre}>'

class Colegio(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), unique=True, nullable=False)

    def __repr__(self):
        return f'<Colegio {self.nombre}>'


class User(db.Model):
    __tablename__='user'
    id = db.Column(db.Integer, primary_key=True)
    nombres = db.Column(db.String(100), nullable=False)
    correo = db.Column(db.String(120), unique=True, nullable=False)
    edad = db.Column(db.Integer, nullable=False)
    colegio_id = db.Column(db.Integer, db.ForeignKey('colegio.id'), nullable=True)
    colegio = db.relationship('Colegio', backref='usuarios', lazy="select")
    nivel_grados_id = db.Column(db.Integer, db.ForeignKey('nivel.id'), nullable=True)
    nivel_educativo = db.Column(db.String(50), nullable=False)
    rol = db.Column(db.String(100), nullable=True)
    anios_experiencia = db.Column(db.Integer, nullable=False)
    cursos = db.relationship('Curso', secondary=usuarios_cursos, backref=db.backref('usuarios', lazy='dynamic'))
    nivel_grados = db.relationship('Nivel', secondary=nivel_por_grados, backref=db.backref('usuarios', lazy='dynamic'))
    grados = db.relationship('Grado', secondary=grados_dictados, backref=db.backref('usuario_grados', lazy='dynamic'))   
    username = db.Column(db.String(80), unique=True, nullable=False)
    password = db.Column(db.String(200), nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    def __repr__(self):
        return f'<User {self.username}>'


class Question(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    statement = db.Column(db.String(500), nullable=False)
    option_a = db.Column(db.String(100), nullable=False)
    option_b = db.Column(db.String(100), nullable=False)
    option_c = db.Column(db.String(100), nullable=False)
    option_d = db.Column(db.String(100), nullable=False)
    correct_answer = db.Column(db.String(1), nullable=False)
    label = db.Column(db.String(50), nullable=False)
    percentage = db.Column(db.Float, nullable=False)
    image_url = db.Column(db.String(200))


class QuestionDos(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    statement = db.Column(db.String(3000), nullable=False)
    option_a = db.Column(db.String(500), nullable=False)
    option_b = db.Column(db.String(500), nullable=False)


class QuestionTres(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    statement = db.Column(db.String(3000), nullable=False)
    option_a = db.Column(db.String(500), nullable=False)
    option_b = db.Column(db.String(500), nullable=False)
    option_c = db.Column(db.String(500), nullable=False)
    option_d = db.Column(db.String(500), nullable=False)
    option_e = db.Column(db.String(500), nullable=False)


class Answer(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    question_id = db.Column(db.Integer, db.ForeignKey('quiz1_question.id'), nullable=False)
    selected_answer = db.Column(db.String(1), nullable=False)


class ResultadoQuiz(db.Model):
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False, unique=True)
    abstraccion = db.Column(db.Float, nullable=False)
    descomposicion = db.Column(db.Float, nullable=False)
    pensamiento_algoritmico = db.Column(db.Float, nullable=False)
    respuestas_correctas = db.Column(db.Integer, nullable=False)
    respuestas_incorrectas =db.Column(db.Integer, nullable=False)
    usuario = db.relationship('User', backref=db.backref('resultado_quiz', uselist=False))


class ResultadoQuizDos(db.Model):
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False, unique=True)
    sensorial_intuitivo = db.Column(db.JSON, nullable=False)
    visual_verbal = db.Column(db.JSON, nullable=False)
    activo_reflexivo = db.Column(db.JSON, nullable=False)
    secuencial_global = db.Column(db.JSON, nullable=False)
    usuario = db.relationship('User', backref=db.backref('resultado_quiz_dos', uselist=False))


class ResultadoQuizTres(db.Model):
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False, unique=True)
    filantropo = db.Column(db.Float, nullable=False)
    socializador = db.Column(db.Float, nullable=False)
    triunfador = db.Column(db.Float, nullable=False)
    jugador = db.Column(db.Float, nullable=False)
    espiritu_libre = db.Column(db.Float, nullable=False)
    disruptor = db.Column(db.Float, nullable=False)
    usuario = db.relationship('User', backref=db.backref('resultados_quiz_tres', uselist=False))


class Grado(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(50), nullable=False)
