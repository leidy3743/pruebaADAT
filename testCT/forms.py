from flask import Flask, render_template, redirect, url_for, flash, request
from flask_wtf import FlaskForm
from wtforms import StringField, RadioField, SubmitField, TextAreaField, PasswordField, IntegerField, SelectField, FloatField, BooleanField, FieldList, FormField, SelectMultipleField
from wtforms.validators import DataRequired, Length, Email, URL, Optional
from wtforms_sqlalchemy.fields import QuerySelectMultipleField

class CursoGradoForm(FlaskForm):
    grado_id = BooleanField()  # Checkbox para seleccionar el grado

class RegistrationForm(FlaskForm):
    nombres = StringField('Nombre', validators=[DataRequired(), Length(min=2, max=50)])
    correo = StringField('Correo', validators=[DataRequired(), Email()])
    edad = SelectField('Edad', choices=[(str(i), str(i)) for i in range(18, 101)], validators=[DataRequired()])
    colegio = SelectField('Institución Educativa', coerce=int, validators=[DataRequired()])
    rol = SelectField('Tipo', choices=[('estudiante', 'Estudiante'), ('docente', 'Docente'), ('coordinador', 'Coordinador')], validators=[DataRequired()])

    anios_experiencia = SelectField('Años de Experiencia Docente', choices=[(str(i), str(i)) for i in range(1, 81)], validators=[Optional()])
    nivel_educativo = SelectField('Nivel Educativo', choices=[('primaria', 'Primaria'), ('secundaria', 'Secundaria'), ('pregrado', 'Pregrado'), ('posgrado', 'Posgrado')], validators=[Optional()])
    # Campo de selección múltiple
    cursos = QuerySelectMultipleField('Cursos Dictados', query_factory=lambda: Curso.query.all(), get_pk=lambda c: c.id, get_label='nombre')

    nivel_grados = QuerySelectMultipleField('Nivel de Educación Dictada', get_label='nombre')
    grados = QuerySelectMultipleField('Grados en los que enseña',query_factory=lambda: Grado.query.all(),
        get_pk=lambda g: g.id,  # Asegura que devuelve IDs en lugar de objetos
        get_label='nombre'
    )

    username = StringField('Usuario', validators=[DataRequired(), Length(min=4, max=80)])
    password = PasswordField('Contraseña', validators=[DataRequired(), Length(min=6, max=200)])
    submit = SubmitField('Registrar')

class LoginForm(FlaskForm):
    username = StringField('Usuario', validators=[DataRequired(), Length(min=4, max=80)])
    password = PasswordField('Contraseña', validators=[DataRequired(), Length(min=6, max=200)])
    submit = SubmitField('Iniciar sesión')

class QuizForm(FlaskForm):
    # Aquí puedes agregar campos para las preguntas del cuestionario
    # Ejemplo:
    statement = TextAreaField('Enunciado', validators=[DataRequired()])
    option_a = StringField('Opción A', validators=[DataRequired(), Length(max=100)])
    option_b = StringField('Opción B', validators=[DataRequired(), Length(max=100)])
    option_c = StringField('Opción C', validators=[DataRequired(), Length(max=100)])
    option_d = StringField('Opción D', validators=[DataRequired(), Length(max=100)])
    correct_answer = RadioField('Respuesta Correcta', choices=[('A', 'A'), ('B', 'B'), ('C', 'C'), ('D', 'D')], validators=[DataRequired()])
    label = StringField('Etiqueta', validators=[DataRequired(), Length(max=50)])
    percentage = FloatField('Porcentaje', validators=[DataRequired()])
    image_url = StringField('URL de la Imagen (opcional)', validators=[URL(), Length(max=200)])
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
    option_a = StringField('Opción A', validators=[DataRequired(), Length(max=100)])
    option_b = StringField('Opción B', validators=[DataRequired(), Length(max=100)])
    submit = SubmitField('Registrar Pregunta')

class QuizFormTres(FlaskForm):
    # Aquí puedes agregar campos para las preguntas del cuestionario
    # Ejemplo:
    statement = TextAreaField('Enunciado', validators=[DataRequired()])
    option_a = StringField('Opción A', validators=[DataRequired(), Length(max=100)])
    option_b = StringField('Opción B', validators=[DataRequired(), Length(max=100)])
    option_c = StringField('Opción C', validators=[DataRequired(), Length(max=100)])
    option_d = StringField('Opción D', validators=[DataRequired(), Length(max=100)])
    option_e = StringField('Opción E', validators=[DataRequired(), Length(max=100)])
    submit = SubmitField('Registrar Pregunta')