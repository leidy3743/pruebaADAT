import json
import openai
import traceback
from flask import Flask, render_template, redirect, url_for, flash, request
from flask_login import LoginManager, login_user, login_required, logout_user, UserMixin, current_user
from werkzeug.security import generate_password_hash, check_password_hash
from forms import RegistrationForm, QuizForm, LoginForm, QuizFormDos, QuizFormTres, CursoGradoForm
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from models import Curso, Colegio, User, Question, QuestionDos, QuestionTres, ResultadoQuiz, ResultadoQuizDos, ResultadoQuizTres  # Asegúrate de que tienes tus modelos configurados
from datetime import datetime
from rich import print
from sqlalchemy.exc import IntegrityError

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:lady@localhost/ayuda'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = 'mi_secreto'
app.jinja_env.filters['zip'] = zip
db = SQLAlchemy(app)
migrate = Migrate(app, db)

# Configuración de API key de OpenAI
openai.api_key = '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'

login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'

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
        return f'<Nivel {self.nombre}>'

class Curso(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), unique=True, nullable=False)

    def __repr__(self):
        return f'<Curso {self.nombre}>'

class Colegio(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), unique=True, nullable=False)


class User(UserMixin, db.Model):
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
    
    def __repr__(self):
        return f'<User {self.username}>' 
    
    def set_password(self, password):
        self.password = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password, password)

    
    @login_manager.user_loader
    def load_user(user_id):
        return User.query.get(int(user_id))


class Question(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    statement = db.Column(db.String(3000), nullable=False)
    option_a = db.Column(db.String(500), nullable=False)
    option_b = db.Column(db.String(500), nullable=False)
    option_c = db.Column(db.String(500), nullable=False)
    option_d = db.Column(db.String(500), nullable=False)
    correct_answer = db.Column(db.String(500), nullable=False)
    label = db.Column(db.String(50), nullable=False)
    percentage = db.Column(db.Float, nullable=False)
    image_url = db.Column(db.String(200))


class Answer(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    question_id = db.Column(db.Integer, db.ForeignKey('question.id'), nullable=False)
    selected_answer = db.Column(db.String(1), nullable=False)


class QuizResult(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    score = db.Column(db.PickleType, nullable=False)  # Para almacenar un diccionario con los puntajes por etiqueta


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


class AnswerTres(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    question_id = db.Column(db.Integer, db.ForeignKey('question.id'), nullable=False)
    selected_answer = db.Column(db.String(500), nullable=False)


class Grado(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(50), nullable=False)


class Asignatura(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)


class Tematica(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)


class Habilidad(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)


class Recurso(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(200), nullable=False)


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
    usuario = db.relationship('User', backref=db.backref('resultados_quiz_dos', uselist=False))


class ResultadoQuizTres(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False, unique=True)
    filantropo = db.Column(db.Float, nullable=False)
    socializador = db.Column(db.Float, nullable=False)
    triunfador = db.Column(db.Float, nullable=False)
    jugador = db.Column(db.Float, nullable=False)
    espiritu_libre = db.Column(db.Float, nullable=False)
    disruptor = db.Column(db.Float, nullable=False)
    usuario = db.relationship('User', backref=db.backref('resultado_quiz_tres', uselist=False))



@app.route('/', methods=['GET'])
def home():
    return render_template('home.html')  # Redirige a la ruta de registro


@app.route('/dashboard')
@login_required
def dashboard():
    return render_template('dashboard.html')


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


@app.route('/register', methods=['GET', 'POST'])
def register():
    print("Método de la solicitud:", request.method)
    form = RegistrationForm()

    form.colegio.choices = [(c.id, c.nombre) for c in Colegio.query.all()]
    form.cursos.query_factory = lambda: Curso.query.all()
    form.nivel_grados.query_factory = lambda: Nivel.query.all()
    form.grados.query_factory = lambda: Grado.query.all()


    if request.method == "POST":
        print("Datos recibidos:", request.form)
        colegio=form.colegio.data,
        cursos_ids = [g.id if isinstance(g, Curso) else g for g in form.cursos.data]
        grados_ids = [g.id if isinstance(g, Grado) else g for g in form.grados.data]
        nivel_ids = [g.id if isinstance(g, Nivel) else g for g in form.nivel_grados.data]

        if form.validate():
            try:
                print("El formulario fue enviado y validado correctamente")
                nuevo_usuario = User(
                    nombres=form.nombres.data,
                    correo=form.correo.data,
                    edad=form.edad.data,
                    colegio_id=int(form.colegio.data),
                    nivel_grados=[db.session.get(Nivel, c_id) for c_id in nivel_ids],  # Guardamos el ID en lugar del objeto
                    grados=[db.session.get(Grado, g_id) for g_id in grados_ids],  # Lista de objetos Grado
                    cursos=[db.session.get(Curso, c_id) for c_id in cursos_ids],
                    anios_experiencia=form.anios_experiencia.data,
                    nivel_educativo=form.nivel_educativo.data,
                    username=form.username.data,
                    password=generate_password_hash(request.form['password'], method='pbkdf2:sha256'),  # Asegúrate de hashear la contraseña
                    rol=form.rol.data
                    #nivel_grados=db.session.get(Nivel, form.nivel_grados.data),  
                    #grados=[db.session.get(Grado, g_id) for g_id in form.grados.data],  
                    #cursos=[db.session.get(Curso, c_id) for c_id in form.cursos.data]  
                )

            # Verifica si los datos son listas o valores únicos
                if isinstance(form.nivel_grados.data, list):
                    nuevo_usuario.nivel_grados.extend(Nivel.query.filter(Nivel.id.in_(form.nivel_grados.data)).all())
                else:
                    nuevo_usuario.nivel_grados = db.session.get(Nivel, form.nivel_grados.data)

                if isinstance(form.grados.data, list):
                    nuevo_usuario.grados.extend(Grado.query.filter(Grado.id.in_(form.grados.data)).all())
                else:
                    nuevo_usuario.grados = [db.session.get(Grado, form.grados.data)]

                if isinstance(form.cursos.data, list):
                    nuevo_usuario.cursos.extend(Curso.query.filter(Curso.id.in_(form.cursos.data)).all())
                else:
                    nuevo_usuario.cursos = [db.session.get(Curso, form.cursos.data)]

                db.session.add(nuevo_usuario)
                db.session.commit()

                flash('¡Registro exitoso! Ahora puedes iniciar sesión.', 'success')
                return redirect(url_for('login'))

            except IntegrityError as e:
                db.session.rollback()  # Revertir cambios en caso de error

                if "Key (correo)" in str(e.orig):  # Detecta el error de correo duplicado
                    flash('El correo ya está registrado. Usa otro correo.', 'danger')
                else:
                    flash('Error al registrar usuario. Intenta nuevamente.', 'danger')

                print("Error de integridad en la base de datos:", str(e))
                traceback.print_exc()

            except Exception as e:
                db.session.rollback()
                print("Error al registrar usuario:", str(e))
                traceback.print_exc()
                flash(f'Error al registrar usuario: {str(e)}', 'danger')

        else:
            print("Errores en el formulario:", form.errors)
            for field, errors in form.errors.items():
                for error in errors:
                    flash(f'Error en {field}: {error}', 'danger')

    return render_template('register.html', form=form)


@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if request.method == 'POST':
        print("POST REQUEST")
        username = request.form['username']
        password = request.form['password']
        print(f"Usuario: {username}, Password: {password}")
        # Buscar usuario en la base de datos por email
        user = User.query.filter_by(username=username).first()
        
        if user and check_password_hash(user.password, password):
            # Si el usuario existe y la contraseña es correcta
            print("user autenticado")
            login_user(user)
            return redirect(url_for('dashboard'))  # Redirige a la página principal después de iniciar sesión
        else:
            # Si el usuario no existe o la contraseña es incorrecta
            print("autenticacion fallo")
            flash('Usuario o contraseña incorrectos', 'danger')
    return render_template('login.html', form=form)


@app.route('/register_quiz1_question', methods=['GET', 'POST'])
def register_quiz1_question():
    form = QuizForm()
    if form.validate_on_submit():
        question = Question(
            statement=form.statement.data,
            option_a=form.option_a.data,
            option_b=form.option_b.data,
            option_c=form.option_c.data,
            option_d=form.option_d.data,
            correct_answer=form.correct_answer.data,
            label=form.label.data,
            percentage=form.percentage.data,
            image_url=form.image_url.data
        )
        db.session.add(question)
        db.session.commit()
        flash('Pregunta registrada con éxito', 'success')
        return redirect(url_for('register_quiz1_question'))
    return render_template('register_quiz1_question.html', form=form)


@app.route('/results', methods=['GET'])
def results():
    # Aquí deberías calcular los resultados basados en las respuestas del usuario
    results_data = [
        {'label': 'Etiqueta 1', 'percentage': 75},
        {'label': 'Etiqueta 2', 'percentage': 50},
        {'label': 'Etiqueta 3', 'percentage': 90},
    ]

    user_responses = {
        "¿Cuál es tu color favorito?": "Azul",
        "¿Te gusta la programación?": "Sí",
    }

    return render_template('results.html', results_data=results_data, user_responses=user_responses)


@app.route('/quiz1', methods=['GET', 'POST'])
@login_required
def quiz1():
    resultado = ResultadoQuiz.query.filter_by(user_id=current_user.id).first()

    if resultado:
        flash("Ya has completado este cuestionario. Aquí están tus resultados.", "success")
        return redirect(url_for('quiz_results', result_id=resultado.id))

    page = request.args.get('page', 1, type=int)  # Obtener el número de página
    questions_per_page = 15  # Número de preguntas por página
    # Obtén todas las preguntas del quiz 1
    questions = Question.query.order_by(Question.id).all()
    total_questions = len(questions)
    
    # Calcular las preguntas para la página actual
    start = (page - 1) * questions_per_page
    end = start + questions_per_page
    questions_to_display = questions[start:end]

    if request.method == 'POST':
        # Aquí puedes procesar las respuestas del formulario
        # Por ejemplo, puedes guardar los resultados en la base de datos
        user_answers = request.form  # Recoge las respuestas del usuario

        # Procesa las respuestas, verifica y guarda los resultados...

        return redirect(url_for('results'))  # Redirige a la página de resultados

    return render_template('quiz1.html', questions=questions_to_display, page=page, total_questions=total_questions, questions_per_page=questions_per_page)


@app.route('/submit_quiz', methods=['POST'])
@login_required
def submit_quiz():
    user_responses = request.form.to_dict()
    resultado = ResultadoQuiz.query.filter_by(user_id=current_user.id).first()
    print("Respuestas del usuario:", user_responses)

    if resultado:
        flash("Ya has completado este cuestionario. Aquí están tus resultados.", "warning")
        return redirect(url_for('quiz_results', result_id=resultado.id))

    correct_count = 0
    incorrect_count = 0
    etiqueta_scores = {
        'Abstracción': 0,
        'Descomposición': 0,
        'Pensamiento Algoritmico': 0,
    }

    for question_id, user_answer in user_responses.items():
        # Aquí debes obtener la pregunta desde la base de datos
        question = Question.query.get(int(question_id))
        if question is not None:
            # Comprobar si la respuesta del usuario es correcta
            if question.correct_answer == user_answer:
                correct_count += 1
                etiqueta_scores[question.label] = etiqueta_scores.get(question.label, 0) + question.percentage
            else:
                incorrect_count += 1
        else:
            print(f"Pregunta con ID {question_id} no encontrada en la base de datos.")

    # Serializa etiqueta_scores para pasarlo como argumento en la URL
    etiqueta_scores_json = json.dumps({k: float(v) for k, v in etiqueta_scores.items()})
    #etiqueta_scores_json = json.dumps({k: float(v) if v is not None else 0 for k, v in etiqueta_scores.items()})


    # Guardar en la base de datos
    resultado = ResultadoQuiz(
        user_id=current_user.id,
        abstraccion=etiqueta_scores.get('Abstracción', 0),
        descomposicion=etiqueta_scores.get('Descomposición', 0),
        pensamiento_algoritmico=etiqueta_scores.get('Pensamiento Algorítmico', 0),
        respuestas_correctas=correct_count,
        respuestas_incorrectas=incorrect_count,
    )
    db.session.add(resultado)
    db.session.commit()


    return redirect(url_for('quiz_results', result_id=resultado.id))


@app.route('/quiz_results/<int:result_id>')
def quiz_results(result_id):
    resultado = ResultadoQuiz.query.get_or_404(result_id)

    correct_count = request.args.get('correct_count', type=int)
    incorrect_count = request.args.get('incorrect_count', type=int)
    etiqueta_scores = {
        "Abstracción": resultado.abstraccion,
        "Descomposición": resultado.descomposicion,
        "Pensamiento Algorítmico": resultado.pensamiento_algoritmico
    }
    
    # Convertir el string de etiqueta_scores a un diccionario
    etiqueta_scores_json = json.dumps({k: float(v) for k, v in etiqueta_scores.items()})

    # Calcular el porcentaje total para cada etiqueta
    total_percentage = sum(etiqueta_scores.values())
    if total_percentage > 0:
        for label in etiqueta_scores:
            etiqueta_scores[label] = round((etiqueta_scores[label] / total_percentage) * 100, 2)

    # Diccionario con descripciones de cada etiqueta
    etiqueta_descriptions = {
        'Abstracción': 'Entender el problema.',
        'Descomposición': 'Dividir problemas complejos en partes más simples.',
        'Pensamiento Algoritmico': 'Proporcionar soluciones paso a paso a un problema.',
    }

    
    return render_template('quiz_results.html', 
                           resultado=resultado, 
                           etiqueta_scores=etiqueta_scores, etiqueta_descriptions=etiqueta_descriptions )



@app.route('/register_quiz2_question', methods=['GET', 'POST'])
def register_quiz2_question():
    form = QuizFormDos()
    if form.validate_on_submit():
        question = QuestionDos(
            statement=form.statement.data,
            option_a=form.option_a.data,
            option_b=form.option_b.data,
        )
        db.session.add(question)
        db.session.commit()
        flash('Pregunta registrada con éxito', 'success')
        return redirect(url_for('register_quiz2_question'))
    return render_template('register_quiz2_question.html', form=form)


@app.route('/quiz2', methods=['GET', 'POST'])
@login_required
def quiz2():
    resultado = ResultadoQuizDos.query.filter_by(user_id=current_user.id).first()

    if resultado:
        flash("Ya has completado este cuestionario. Aquí están tus resultados.", "success")
        return redirect(url_for('quiz_resultsDos', result_id=resultado.id))

    page = request.args.get('page', 1, type=int)  # Obtener el número de página
    questions_per_page = 45  # Número de preguntas por página
    # Obtén todas las preguntas del quiz 2
    questions = QuestionDos.query.order_by(QuestionDos.id).all()
    total_questions = len(questions)
    
    # Calcular las preguntas para la página actual
    start = (page - 1) * questions_per_page
    end = start + questions_per_page
    questions_to_display = questions[start:end]

    if request.method == 'POST':
        # Aquí puedes procesar las respuestas del formulario
        # Por ejemplo, puedes guardar los resultados en la base de datos
        user_answers = request.form  # Recoge las respuestas del usuario

        # Procesa las respuestas, verifica y guarda los resultados...

        return redirect(url_for('results2'))  # Redirige a la página de resultados

    return render_template('quiz2.html', questions=questions_to_display, page=page, total_questions=total_questions, questions_per_page=questions_per_page)


@app.route('/submit_quizDos', methods=['POST'])
@login_required
def submit_quizDos():
    user_responses = request.form.to_dict()
    resultado = ResultadoQuizDos.query.filter_by(user_id=current_user.id).first()

    if resultado:
        flash("Ya has completado este cuestionario. Aquí están tus resultados.", "warning")
        return redirect(url_for('quiz_resultsDos', result_id=resultado.id))

    print("Respuestas del usuario:", user_responses)
    etiquetas = {
        'Sensorial-Intuitivo': {'A': 0, 'B': 0},
        'Visual-Verbal': {'A': 0, 'B': 0},
        'Activo-Reflexivo': {'A': 0, 'B': 0},
        'Secuencial-Global': {'A': 0, 'B': 0},
    }

    pregunta_a_etiqueta = {
        1: 'Activo-Reflexivo',
        2: 'Sensorial-Intuitivo',
        3: 'Visual-Verbal',
        4: 'Secuencial-Global',
        5: 'Activo-Reflexivo',
        6: 'Sensorial-Intuitivo',
        7: 'Visual-Verbal',
        8: 'Secuencial-Global',
        9: 'Activo-Reflexivo',
        10: 'Sensorial-Intuitivo',
        11: 'Visual-Verbal',
        12: 'Secuencial-Global',
        13: 'Activo-Reflexivo',
        14: 'Sensorial-Intuitivo',
        15: 'Visual-Verbal',
        16: 'Secuencial-Global',
        17: 'Activo-Reflexivo',
        18: 'Sensorial-Intuitivo',
        19: 'Visual-Verbal',
        20: 'Secuencial-Global',
        21: 'Activo-Reflexivo',
        22: 'Sensorial-Intuitivo',
        23: 'Visual-Verbal',
        24: 'Secuencial-Global',
        25: 'Activo-Reflexivo',
        26: 'Sensorial-Intuitivo',
        27: 'Visual-Verbal',
        28: 'Secuencial-Global',
        29: 'Activo-Reflexivo',
        30: 'Sensorial-Intuitivo',
        31: 'Visual-Verbal',
        32: 'Secuencial-Global',
        33: 'Activo-Reflexivo',
        34: 'Sensorial-Intuitivo',
        35: 'Visual-Verbal',
        36: 'Secuencial-Global',
        37: 'Activo-Reflexivo',
        38: 'Sensorial-Intuitivo',
        39: 'Visual-Verbal',
        40: 'Secuencial-Global',
        41: 'Activo-Reflexivo',
        42: 'Sensorial-Intuitivo',
        43: 'Visual-Verbal',
        44: 'Secuencial-Global',

    }


    for question_id_str, user_answer in user_responses.items():
        question_id = int(question_id_str)
        etiqueta = pregunta_a_etiqueta.get(question_id)

        if etiqueta:
            etiquetas[etiqueta][user_answer] += 1  # Simplificado

    # Calcular el resultado final para cada etiqueta
    etiqueta_resultados = {}
    for etiqueta, conteo in etiquetas.items():
        diferencia = conteo['A'] - conteo['B']

        # Determinar el estado y valor basado en la diferencia
        if diferencia >= 9:
            valor = 'Fuerte'
        elif 5 <= diferencia <= 8:
            valor = 'Moderado'
        else:
            valor = 'Apropiado'

        if conteo['A'] > conteo['B']:
            estado = etiqueta.split('-')[0]  # Ejemplo: 'Sensorial'
            total = conteo['A']
        else:
            estado = etiqueta.split('-')[1]  # Ejemplo: 'Intuitivo'
            total = conteo['B']

        etiqueta_resultados[etiqueta] = {
            'estado': estado,
            'valor': valor,
            'total': total
        }

    print("Resultados de etiquetas:", etiqueta_resultados)

    resultado = ResultadoQuizDos(
        user_id=current_user.id,
        sensorial_intuitivo=etiqueta_resultados['Sensorial-Intuitivo'],
        visual_verbal=etiqueta_resultados['Visual-Verbal'],
        activo_reflexivo=etiqueta_resultados['Activo-Reflexivo'],
        secuencial_global=etiqueta_resultados['Secuencial-Global'],
    )

    db.session.add(resultado)
    db.session.commit()

    # Redirigir a la página de resultados con los resultados como argumento
    return redirect(url_for('quiz_resultsDos', result_id=resultado.id))


@app.route('/quiz_resultsDos/<int:result_id>')
def quiz_resultsDos(result_id):
    result = ResultadoQuizDos.query.get_or_404(result_id)

    etiqueta_resultados = {
        'Sensitivo-Intuitivo': result.sensorial_intuitivo,
        'Visual-Verbal': result.visual_verbal,
        'Activo-Reflexivo': result.activo_reflexivo,
        'Secuencial-Global': result.secuencial_global,
    }

    # Diccionario con descripciones de cada etiqueta
    etiqueta_descriptions = {
        'Sensitivo-Intuitivo': 'Como perciben la información. Los sensitivos son concretos, prácticos, orientados hacia hechos y procedimientos; les gusta resolver problemas siguiendo procedimientos muy bien establecidos. Los intuitivos son conceptuales, innovadores, orientados hacia las teorías y los significados; les gusta innovar y odian la repetición.',
        'Visual-Verbal': 'En que canal perciben mejor la información. Los visuales prefieren representaciones visuales, diagramas de flujo, imagenes, etc. Los verbales prefieren obtener la información en forma escrita o hablada; recuerdan mejor lo que leen o lo que oyen.',
        'Activo-Reflexivo': 'Como procesan la información. Los activos tienden a retener y comprender mejor nueva información cuando hacen algo activo con ella (discutiéndola, aplicándola, explicándosela a otros). Los reflexivos tienden a retener y comprender nueva información pensando y reflexionando sobre ella, prefieren aprender meditando, pensando y trabajando solos.',
        'Secuencial-Global': 'Como progresa el estudiante en su aprendizaje. Los secuenciales aprenden en pequeños pasos incrementales cuando el siguiente paso está siempre lógicamente relacionado con el anterior; ordenados y lineales. Los globales aprenden grandes saltos, aprendiendo nuevo material casi al azar y visualizando la totalidad; pueden resolver problemas complejos. Pueden tener dificultades, sin embargo, en explicar cómo lo hicieron.',

        }
    etiqueta_resultados = dict(sorted(etiqueta_resultados.items(), key=lambda x: x[1]['total'], reverse=True))

    return render_template('quiz_resultsDos.html', etiqueta_resultados=etiqueta_resultados, etiqueta_descriptions=etiqueta_descriptions)


@app.route('/register_quiz3_question', methods=['GET', 'POST'])
def register_quiz3_question():
    form = QuizFormTres()
    if form.validate_on_submit():
        question = QuestionTres(
            statement=form.statement.data,
            option_a=form.option_a.data,
            option_b=form.option_b.data,
            option_c=form.option_c.data,
            option_d=form.option_d.data,
            option_e=form.option_e.data,

        )
        db.session.add(question)
        db.session.commit()
        flash('Pregunta registrada con éxito', 'success')
        return redirect(url_for('register_quiz3_question'))
    return render_template('register_quiz3_question.html', form=form)


@app.route('/quiz3', methods=['GET', 'POST'])
@login_required
def quiz3():
    resultado = ResultadoQuizTres.query.filter_by(user_id=current_user.id).first()

    if resultado:
        flash("Ya has completado este cuestionario. Aquí están tus resultados.", "success")
        return redirect(url_for('quiz_resultsTres', result_id=resultado.id))

    page = request.args.get('page', 1, type=int)  # Obtener el número de página
    questions_per_page = 12  # Número de preguntas por página
    # Obtén todas las preguntas del quiz 3
    questions = QuestionTres.query.order_by(QuestionTres.id).all()
    total_questions = len(questions)
    
    # Calcular las preguntas para la página actual
    start = (page - 1) * questions_per_page
    end = start + questions_per_page
    questions_to_display = questions[start:end]

    if request.method == 'POST':
        # Aquí puedes procesar las respuestas del formulario
        # Por ejemplo, puedes guardar los resultados en la base de datos
        user_answers = request.form.to_dict()  # Recoge las respuestas del usuario
        print("RespuestasX", user_answers)
        # Procesa las respuestas, verifica y guarda los resultados...


        return redirect(url_for('results3'))  # Redirige a la página de resultados

    return render_template('quiz3.html', questions=questions_to_display, page=page, total_questions=total_questions, questions_per_page=questions_per_page)


@app.route('/submit_quizTres', methods=['POST'])
@login_required
def submit_quizTres():
    user_answers = request.form.to_dict()
    resultado = ResultadoQuizTres.query.filter_by(user_id=current_user.id).first()

    if resultado:
        flash("Ya has completado este cuestionario. Aquí están tus resultados.", "warning")
        return redirect(url_for('quiz_resultsTres', result_id=resultado.id))


    etiquetas = {
        'Filántropo': 0,
        'Socializador': 0,
        'Triunfador': 0,
        'Jugador': 0,
        'Espíritu Libre': 0,
        'Disruptor': 0
        }
    total = 0

     # Asociación de preguntas con etiquetas
    pregunta_a_etiqueta = {
        1: 'Filántropo',
        2: 'Filántropo',
        3: 'Socializador',
        4: 'Socializador',
        5: 'Triunfador',
        6: 'Triunfador',
        7: 'Jugador',
        8: 'Jugador',
        9: 'Espíritu Libre',
        10: 'Espíritu Libre',
        11: 'Disruptor',
        12: 'Disruptor'
    }

    for question_id_str, user_answer in user_answers.items():
        # Aquí debes obtener la pregunta desde la base de datos
        #question = QuestionTres.query.get(int(question_id))
        question_id = (int(question_id_str))
        valor = 0

        if user_answer == 'A':
            valor = 5
        elif user_answer == "B":
            valor = 4
        elif user_answer == "C":
            valor = 3
        elif user_answer == "D":
            valor = 2
        elif user_answer == "E":
            valor = 1
        
        print(f"Pregunta ID: {question_id}, Valor: {valor}")  # Agregar esta línea para ver el valor asignado

        etiqueta = pregunta_a_etiqueta.get(question_id)
        print(f"Pregunta ID: {question_id}, Valor: {valor}, Etiqueta: {etiqueta}")

        if etiqueta:
            etiquetas[etiqueta] += valor
            
        total += valor
        

    # Calcular el porcentaje para cada etiqueta
    etiqueta_percentages = {etiqueta: round((score / total) * 100, 2) if total > 0 else 0 
                            for etiqueta, score in etiquetas.items()}

    # Guardar los resultados en la base de datos
    # (aquí deberías añadir la lógica para guardar en la base de datos si es necesario)

    #return render_template('quiz_resultsTres.html', etiqueta_percentages=etiqueta_percentages)
     # Guardar en la base de datos
    resultado = ResultadoQuizTres(
        user_id=current_user.id,
        filantropo=etiqueta_percentages['Filántropo'],
        socializador=etiqueta_percentages['Socializador'],
        triunfador=etiqueta_percentages['Triunfador'],
        jugador=etiqueta_percentages['Jugador'],
        espiritu_libre=etiqueta_percentages['Espíritu Libre'],
        disruptor=etiqueta_percentages['Disruptor']
    )

    db.session.add(resultado)
    db.session.commit()

    return redirect(url_for('quiz_resultsTres', result_id=resultado.id))



@app.route('/quiz_resultsTres/<int:result_id>')
def quiz_resultsTres(result_id):
    result = ResultadoQuizTres.query.get_or_404(result_id)
    
    etiqueta_percentages = {
        'Filántropo': result.filantropo,
        'Socializador': result.socializador,
        'Triunfador': result.triunfador,
        'Jugador': result.jugador,
        'Espíritu Libre': result.espiritu_libre,
        'Disruptor': result.disruptor
    }

    # Diccionario con descripciones de cada etiqueta
    etiqueta_descriptions = {
        'Filántropo': 'Impulsado por un propósito en particular. No necesitan ninguna recompensa, con obtener la sensación de aportar un valor social ya es suficiente.',
        'Socializador': 'Impulsado por las relaciones interpersonales y motivados por la interacción con otros jugadores.',
        'Triunfador': 'Motivados por la competencia y la maestría. Busca desafíos, metas y recompensas para demostrar su habilidad y esfuerzo.',
        'Jugador': 'Impulsado por las recompensas. Se involucra a través de la competencia y disfruta ganar en distintos escenarios.',
        'Espíritu Libre': 'Impulsado por la autonomía y la libertad. Valora la creatividad y la exploración.',
        'Disruptor': 'Impulsado por el cambio. Le gusta desafiar lo establecido, experimentar y generar cambios innovadores.',
    }
    # Recupera los porcentajes de las etiquetas desde los argumentos de la URL
    #etiqueta_percentages_str = request.args.get('etiqueta_percentages')
    
    # Ordenar las etiquetas de mayor a menor porcentaje
    etiqueta_percentages = dict(sorted(etiqueta_percentages.items(), key=lambda x: x[1], reverse=True))

    return render_template('quiz_resultsTres.html', etiqueta_percentages=etiqueta_percentages, etiqueta_descriptions=etiqueta_descriptions)


@app.route('/get_form_data', methods=['GET'])
def get_form_data():
    grados = Grado.query.all()
    asignaturas = Asignatura.query.all()
    tematicas = Tematica.query.all()
    habilidades = Habilidad.query.all()
    
    form_data = {
        'grados': [{'id': g.id, 'nombre': g.nombre} for g in grados],
        'asignaturas': [{'id': a.id, 'nombre': a.nombre} for a in asignaturas],
        'tematicas': [{'id': t.id, 'nombre': t.nombre} for t in tematicas],
        'habilidades': [{'id': h.id, 'nombre': h.nombre} for h in habilidades]
    }
    
    return jsonify(form_data)


# Ruta para el autocompletar de recursos
@app.route('/autocomplete_recursos', methods=['GET'])
def autocomplete_recursos():
    search_term = request.args.get('q', '')
    recursos = Recurso.query.filter(Recurso.nombre.ilike(f'%{search_term}%')).all()
    
    return jsonify([{'id': r.id, 'nombre': r.nombre} for r in recursos])

# Función para generar actividades dinámicas usando ChatGPT
def generate_activity(grade, subject, topic, skill, students, time, resources):
    prompt = f"""
    Genera una actividad de clase para {students} estudiantes de {grade} grado sobre la temática de {topic} en la asignatura {subject}.
    La actividad debe desarrollar la habilidad de {skill} y durar {time} minutos. Además, se deben usar los siguientes recursos: {resources}.
    Proporcióname una actividad creativa que un docente pueda realizar en clase.
    """
    
    # Llamada a la API de OpenAI para generar el texto
    response = openai.Completion.create(
        engine="gpt-3.5-turbo",
        prompt=prompt,
        max_tokens=200  # Ajusta los tokens según la longitud que desees
    )
    
    return response.choices[0].text.strip()


@app.route('/crear_actividad', methods=['GET', 'POST'])
def crear_actividad():
    grados = Grado.query.all()  # Consulta todos los grados
    asignaturas = Asignatura.query.all()  # Consulta todas las asignaturas
    habilidades = Habilidad.query.all()  # Consulta todas las habilidades

    # Imprimir para verificar los datos
    print("Grados:", grados)
    print("Asignaturas:", asignaturas)
    print("Habilidades:", habilidades)

    if request.method == 'POST':
        grado = request.form.get('grado')
        asignatura = request.form.get('asignatura')
        tematica = request.form.get('tematica')
        habilidad = request.form.getlist('habilidad')
        cantidad_estudiantes = request.form.get('cantidad_estudiantes')
        cantidad_tiempo = request.form.get('cantidad_tiempo')
        recursos = request.form.get('recursos')

        # Genera actividades utilizando el modelo GPT de OpenAI
        prompt = f"Genera actividades para el grado {grado}, en la asignatura {asignatura}, con la temática {tematica}, enfocadas en las habilidades {', '.join(habilidad)} para {cantidad_estudiantes} estudiantes en un tiempo de {cantidad_tiempo} minutos. Recursos disponibles: {recursos}."

        try:
            # Uso de la nueva API de OpenAI
            response = openai.completions.create(
                model="gpt-3.5-turbo",  # Puedes usar gpt-4 si tienes acceso
                prompt=prompt,
                max_tokens=150,
                n=1,
                stop=None,
                temperature=0.7
            )

            actividades_generadas = response['choices'][0]['text'].strip()
            return render_template('select_activities.html', actividades=actividades_generadas)

        except Exception as e:
            return f"Error al generar actividades: {e}"

    grados = Grado.query.all()
    asignaturas = Asignatura.query.all()
    habilidades = Habilidad.query.all()

    return render_template('select_activities.html', grados=grados, asignaturas=asignaturas, habilidades=habilidades)


@app.route('/select_activities', methods=['GET', 'POST'])
def select_activities():
    if request.method == 'POST':
        grade = request.form.get('grade')
        subject = request.form.get('subject')
        topic = request.form.get('topic')
        skill = request.form.get('skill')
        students = request.form.get('students')
        time = request.form.get('time')
        resources = request.form.get('resources')

        # Llamada a la función que genera las actividades usando ChatGPT
        activity = generate_activity(grade, subject, topic, skill, students, time, resources)
        activities = [{"activity": activity, "skill": skill, "subject": subject, "topic": topic, "students": students, "time": time, "resources": resources}]
        
        return render_template('activities.html', activities=activities)

    return render_template('select_activities.html')


if __name__ == '__main__':
    app.run(debug=True)
