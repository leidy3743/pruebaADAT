from flask import Flask, render_template, redirect, url_for, flash, request
from flask_wtf import FlaskForm
from flask_wtf.file import FileField, FileAllowed
from wtforms import StringField, RadioField, SubmitField, TextAreaField, PasswordField, IntegerField, SelectField, FloatField, BooleanField, FieldList, FormField, SelectMultipleField
from wtforms.validators import DataRequired, Length, Email, URL, Optional, ValidationError
from wtforms_sqlalchemy.fields import QuerySelectMultipleField
from wtforms.widgets import ListWidget, CheckboxInput
from models import Curso, Grado

class CursoGradoForm(FlaskForm):
    grado_id = BooleanField()  # Checkbox para seleccionar el grado

class MultiCheckboxQuerySelectField(QuerySelectMultipleField):
    widget = ListWidget(prefix_label=False)
    option_widget = CheckboxInput()

class RegistrationForm(FlaskForm):
    nombres = StringField('Nombre', validators=[DataRequired(), Length(min=2, max=50)])
    correo = StringField('Correo', validators=[DataRequired(), Email()])
    edad = SelectField('Edad', choices=[(str(i), str(i)) for i in range(18, 101)], validators=[DataRequired()])
    colegio = SelectField('Grupo', coerce=int, validators=[DataRequired()])
    institucion = StringField('Institución', validators=[Optional(), Length(max=120)])
    rol = SelectField('Tipo', choices=[('estudiante', 'Estudiante'), ('docente', 'Docente'), ('coordinador', 'Coordinador')], validators=[DataRequired()])

    anios_experiencia = SelectField('Años de Experiencia Docente', choices=[(str(i), str(i)) for i in range(1, 81)], validators=[Optional()])
    nivel_educativo = SelectField('Nivel Educativo', choices=[('primaria', 'Primaria'), ('secundaria', 'Secundaria'), ('pregrado', 'Pregrado'), ('posgrado', 'Posgrado')], validators=[Optional()])
    # Campo de selección múltiple
    cursos = MultiCheckboxQuerySelectField('Cursos Dictados', query_factory=lambda: Curso.query.all(), get_pk=lambda c: c.id, get_label='nombre')

    nivel_grados = MultiCheckboxQuerySelectField('Nivel de Educación Dictada', get_label='nombre')
    grados = MultiCheckboxQuerySelectField('Grados en los que enseña',query_factory=lambda: Grado.query.all(),
        get_pk=lambda g: g.id,  # Asegura que devuelve IDs en lugar de objetos
        get_label='nombre'
    )

    username = StringField('Usuario', validators=[DataRequired(), Length(min=4, max=80)])
    password = PasswordField('Contraseña', validators=[DataRequired(), Length(min=6, max=200)])
    submit = SubmitField('Registrar')

    def validate(self, extra_validators=None):
        rv = super().validate(extra_validators)
        if not rv:
            return False

        # Validaciones condicionales para Docente
        if self.rol.data == 'docente':
            ok = True
            if not self.anios_experiencia.data:
                self.anios_experiencia.errors.append('Requerido para Docente.')
                ok = False
            if not self.nivel_grados.data:
                self.nivel_grados.errors.append('Selecciona al menos un nivel.')
                ok = False
            if not self.cursos.data:
                self.cursos.errors.append('Selecciona al menos un curso.')
                ok = False
            if not self.grados.data:
                self.grados.errors.append('Selecciona al menos un grado.')
                ok = False
            return ok

        return True

class LoginForm(FlaskForm):
    username = StringField('Usuario', validators=[DataRequired(), Length(min=4, max=80)])
    password = PasswordField('Contraseña', validators=[DataRequired(), Length(min=6, max=200)])
    submit = SubmitField('Iniciar sesión')

class QuizForm(FlaskForm):
    # Aquí puedes agregar campos para las preguntas del cuestionario
    # Ejemplo:
    statement = TextAreaField('Enunciado', validators=[DataRequired()])
    option_a = StringField('Opción A', validators=[DataRequired(), Length(max=500)])
    option_b = StringField('Opción B', validators=[DataRequired(), Length(max=500)])
    option_c = StringField('Opción C', validators=[DataRequired(), Length(max=500)])
    option_d = StringField('Opción D', validators=[DataRequired(), Length(max=500)])
    correct_answer = RadioField('Respuesta Correcta', choices=[('A', 'A'), ('B', 'B'), ('C', 'C'), ('D', 'D')], validators=[DataRequired()])
    label = StringField('Etiqueta', validators=[DataRequired(), Length(max=50)])
    percentage = FloatField('Porcentaje', validators=[DataRequired()])
    image_url = StringField('URL de la Imagen (opcional)', validators=[Optional(), URL(), Length(max=1000)])
    submit = SubmitField('Registrar Pregunta')

class AdminForm(FlaskForm):
    text = StringField('Texto de la Pregunta', validators=[DataRequired()])
    type = RadioField('Tipo de Pregunta', choices=[('text', 'Texto'), ('choice', 'Opción Múltiple')], validators=[DataRequired()])
    choices = TextAreaField('Opciones (separadas por comas, si aplica)')
    tag = StringField('Etiqueta')
    weight = StringField('Peso (en porcentaje)')
    image = StringField('Nombre de la Imagen (si aplica)')
    submit = SubmitField('Agregar Pregunta')

class QuizFormDos(FlaskForm):
    # Aquí puedes agregar campos para las preguntas del cuestionario
    # Ejemplo:
    statement = TextAreaField('Enunciado', validators=[DataRequired()])
    option_a = StringField('Opción A', validators=[DataRequired(), Length(max=500)])
    option_b = StringField('Opción B', validators=[DataRequired(), Length(max=500)])
    option_c = StringField('Opción C', validators=[DataRequired(), Length(max=500)])
    option_d = StringField('Opción D', validators=[DataRequired(), Length(max=500)])
    correct_answer = RadioField('Respuesta Correcta', choices=[('A','A'),('B','B'),('C','C'),('D','D')], validators=[DataRequired()])
    label = StringField('Etiqueta', validators=[DataRequired(), Length(max=50)])
    percentage = FloatField('Porcentaje', validators=[DataRequired()])
    image_url = StringField('URL de la Imagen (opcional)', validators=[Optional(), URL(), Length(max=1000)])
    submit = SubmitField('Registrar Pregunta')

class QuizFormTres(FlaskForm):
    # Aquí puedes agregar campos para las preguntas del cuestionario
    # Ejemplo:
    statement = TextAreaField('Enunciado', validators=[DataRequired()])
    option_a = StringField('Opción A', validators=[DataRequired(), Length(max=500)])
    option_b = StringField('Opción B', validators=[DataRequired(), Length(max=500)])
    option_c = StringField('Opción C', validators=[DataRequired(), Length(max=500)])
    option_d = StringField('Opción D', validators=[DataRequired(), Length(max=500)])
    option_e = StringField('Opción E', validators=[DataRequired(), Length(max=500)])
    correct_answer = RadioField('Respuesta Correcta', choices=[('A','A'),('B','B'),('C','C'),('D','D'),('E','E')], validators=[DataRequired()])
    label = StringField('Etiqueta', validators=[DataRequired(), Length(max=50)])
    percentage = FloatField('Porcentaje', validators=[DataRequired()])
    image_url = StringField('URL de la Imagen (opcional)', validators=[Optional(), URL(), Length(max=1000)])
    submit = SubmitField('Registrar Pregunta')


class QuizFormCuatro(FlaskForm):
    # Aquí puedes agregar campos para las preguntas del cuestionario
    # Ejemplo:
    statement = TextAreaField('Enunciado', validators=[DataRequired()])
    option_a = StringField('Opción A', validators=[DataRequired(), Length(max=500)])
    option_b = StringField('Opción B', validators=[DataRequired(), Length(max=500)])
    option_c = StringField('Opción C', validators=[DataRequired(), Length(max=500)])
    option_d = StringField('Opción D', validators=[DataRequired(), Length(max=500)])
    correct_answer = RadioField('Respuesta Correcta', choices=[('A','A'),('B','B'),('C','C'),('D','D')], validators=[DataRequired()])
    label = StringField('Etiqueta', validators=[Optional(), Length(max=50)])
    percentage = FloatField('Porcentaje', validators=[Optional()])
    image_url = StringField('URL de la Imagen (opcional)', validators=[Optional(), URL(), Length(max=1000)])
    image_file = FileField('Subir imagen (opcional)', validators=[Optional(), FileAllowed(['jpg','jpeg','png','gif'], 'Solo imágenes JPG/PNG/GIF')])
    submit = SubmitField('Registrar Pregunta')