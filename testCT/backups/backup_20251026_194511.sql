--
-- PostgreSQL database dump
--

\restrict PqlMDxGJPOHX3pEEYfNgkoGW6eGvYZdtvJlsgGPxWiX4TV0ANR9lcepIehfVHkS

-- Dumped from database version 17.6 (Debian 17.6-1.pgdg12+1)
-- Dumped by pg_dump version 17.6 (Debian 17.6-2.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: leidy_user
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO leidy_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Users; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public."Users" (
    id integer NOT NULL,
    username character varying(64),
    email character varying(64),
    password bytea
);


ALTER TABLE public."Users" OWNER TO leidy_user;

--
-- Name: Users_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public."Users_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Users_id_seq" OWNER TO leidy_user;

--
-- Name: Users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public."Users_id_seq" OWNED BY public."Users".id;


--
-- Name: actividad_generada; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.actividad_generada (
    id integer NOT NULL,
    user_id integer NOT NULL,
    nombre_profesor character varying(200) NOT NULL,
    grado character varying(50) NOT NULL,
    asignatura character varying(200) NOT NULL,
    tematica character varying(500) NOT NULL,
    cantidad_estudiantes integer NOT NULL,
    tipo_actividad character varying(50) NOT NULL,
    tiempo integer NOT NULL,
    recursos character varying(1000) NOT NULL,
    contenido text NOT NULL,
    fecha_creacion timestamp without time zone NOT NULL,
    fecha_modificacion timestamp without time zone NOT NULL
);


ALTER TABLE public.actividad_generada OWNER TO leidy_user;

--
-- Name: actividad_generada_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.actividad_generada_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.actividad_generada_id_seq OWNER TO leidy_user;

--
-- Name: actividad_generada_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.actividad_generada_id_seq OWNED BY public.actividad_generada.id;


--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO leidy_user;

--
-- Name: answer; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.answer (
    id integer NOT NULL,
    user_id integer NOT NULL,
    question_id integer NOT NULL,
    selected_answer character varying(1) NOT NULL
);


ALTER TABLE public.answer OWNER TO leidy_user;

--
-- Name: answer_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.answer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.answer_id_seq OWNER TO leidy_user;

--
-- Name: answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.answer_id_seq OWNED BY public.answer.id;


--
-- Name: answer_tres; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.answer_tres (
    id integer NOT NULL,
    user_id integer NOT NULL,
    question_id integer NOT NULL,
    selected_answer character varying(500) NOT NULL
);


ALTER TABLE public.answer_tres OWNER TO leidy_user;

--
-- Name: answer_tres_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.answer_tres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.answer_tres_id_seq OWNER TO leidy_user;

--
-- Name: answer_tres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.answer_tres_id_seq OWNED BY public.answer_tres.id;


--
-- Name: asignatura; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.asignatura (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.asignatura OWNER TO leidy_user;

--
-- Name: asignatura_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.asignatura_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.asignatura_id_seq OWNER TO leidy_user;

--
-- Name: asignatura_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.asignatura_id_seq OWNED BY public.asignatura.id;


--
-- Name: colegio; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.colegio (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.colegio OWNER TO leidy_user;

--
-- Name: colegio_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.colegio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.colegio_id_seq OWNER TO leidy_user;

--
-- Name: colegio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.colegio_id_seq OWNED BY public.colegio.id;


--
-- Name: configuracion_notificaciones; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.configuracion_notificaciones (
    id integer NOT NULL,
    notif_login boolean NOT NULL,
    notif_registro boolean NOT NULL,
    notif_test_completado boolean NOT NULL,
    email_destino character varying(120) NOT NULL,
    actualizado_at timestamp without time zone
);


ALTER TABLE public.configuracion_notificaciones OWNER TO leidy_user;

--
-- Name: configuracion_notificaciones_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.configuracion_notificaciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.configuracion_notificaciones_id_seq OWNER TO leidy_user;

--
-- Name: configuracion_notificaciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.configuracion_notificaciones_id_seq OWNED BY public.configuracion_notificaciones.id;


--
-- Name: configuracion_sistema; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.configuracion_sistema (
    id integer NOT NULL,
    clave character varying(100) NOT NULL,
    valor character varying(5000) NOT NULL,
    descripcion character varying(500)
);


ALTER TABLE public.configuracion_sistema OWNER TO leidy_user;

--
-- Name: configuracion_sistema_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.configuracion_sistema_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.configuracion_sistema_id_seq OWNER TO leidy_user;

--
-- Name: configuracion_sistema_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.configuracion_sistema_id_seq OWNED BY public.configuracion_sistema.id;


--
-- Name: curso; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.curso (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.curso OWNER TO leidy_user;

--
-- Name: curso_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.curso_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.curso_id_seq OWNER TO leidy_user;

--
-- Name: curso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.curso_id_seq OWNED BY public.curso.id;


--
-- Name: grado; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.grado (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.grado OWNER TO leidy_user;

--
-- Name: grado_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.grado_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.grado_id_seq OWNER TO leidy_user;

--
-- Name: grado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.grado_id_seq OWNED BY public.grado.id;


--
-- Name: grados_dictados; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.grados_dictados (
    user_id integer NOT NULL,
    grado_id integer NOT NULL
);


ALTER TABLE public.grados_dictados OWNER TO leidy_user;

--
-- Name: habilidad; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.habilidad (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.habilidad OWNER TO leidy_user;

--
-- Name: habilidad_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.habilidad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.habilidad_id_seq OWNER TO leidy_user;

--
-- Name: habilidad_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.habilidad_id_seq OWNED BY public.habilidad.id;


--
-- Name: nivel; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.nivel (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.nivel OWNER TO leidy_user;

--
-- Name: nivel_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.nivel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nivel_id_seq OWNER TO leidy_user;

--
-- Name: nivel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.nivel_id_seq OWNED BY public.nivel.id;


--
-- Name: nivel_por_grados; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.nivel_por_grados (
    user_id integer NOT NULL,
    nivel_id integer NOT NULL
);


ALTER TABLE public.nivel_por_grados OWNER TO leidy_user;

--
-- Name: question; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.question (
    id integer NOT NULL,
    statement text NOT NULL,
    option_a character varying(500) NOT NULL,
    option_b character varying(500) NOT NULL,
    option_c character varying(500) NOT NULL,
    option_d character varying(500) NOT NULL,
    correct_answer character varying(500) NOT NULL,
    label character varying(50) NOT NULL,
    percentage double precision NOT NULL,
    image_url character varying(1000)
);


ALTER TABLE public.question OWNER TO leidy_user;

--
-- Name: question_cuatro; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.question_cuatro (
    id integer NOT NULL,
    statement character varying(1000) NOT NULL,
    option_a character varying(500) NOT NULL,
    option_b character varying(500) NOT NULL,
    option_c character varying(500) NOT NULL,
    option_d character varying(500) NOT NULL,
    correct_answer character varying(1) NOT NULL,
    label character varying(50),
    percentage double precision,
    image_url character varying(200)
);


ALTER TABLE public.question_cuatro OWNER TO leidy_user;

--
-- Name: question_cuatro_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.question_cuatro_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.question_cuatro_id_seq OWNER TO leidy_user;

--
-- Name: question_cuatro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.question_cuatro_id_seq OWNED BY public.question_cuatro.id;


--
-- Name: question_dos; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.question_dos (
    id integer NOT NULL,
    statement character varying(3000) NOT NULL,
    option_a character varying(500) NOT NULL,
    option_b character varying(500) NOT NULL
);


ALTER TABLE public.question_dos OWNER TO leidy_user;

--
-- Name: question_dos_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.question_dos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.question_dos_id_seq OWNER TO leidy_user;

--
-- Name: question_dos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.question_dos_id_seq OWNED BY public.question_dos.id;


--
-- Name: question_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.question_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.question_id_seq OWNER TO leidy_user;

--
-- Name: question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.question_id_seq OWNED BY public.question.id;


--
-- Name: question_tres; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.question_tres (
    id integer NOT NULL,
    statement character varying(3000) NOT NULL,
    option_a character varying(500) NOT NULL,
    option_b character varying(500) NOT NULL,
    option_c character varying(500) NOT NULL,
    option_d character varying(500) NOT NULL,
    option_e character varying(500) NOT NULL
);


ALTER TABLE public.question_tres OWNER TO leidy_user;

--
-- Name: question_tres_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.question_tres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.question_tres_id_seq OWNER TO leidy_user;

--
-- Name: question_tres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.question_tres_id_seq OWNED BY public.question_tres.id;


--
-- Name: quiz_cuatro; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.quiz_cuatro (
    id integer NOT NULL,
    statement character varying(1000) NOT NULL,
    option_a character varying(500) NOT NULL,
    option_b character varying(500) NOT NULL,
    option_c character varying(500) NOT NULL,
    option_d character varying(500) NOT NULL,
    correct_answer character varying(1) NOT NULL,
    label character varying(50),
    percentage double precision,
    image_url character varying(1000)
);


ALTER TABLE public.quiz_cuatro OWNER TO leidy_user;

--
-- Name: quiz_cuatro_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.quiz_cuatro_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quiz_cuatro_id_seq OWNER TO leidy_user;

--
-- Name: quiz_cuatro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.quiz_cuatro_id_seq OWNED BY public.quiz_cuatro.id;


--
-- Name: quiz_result; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.quiz_result (
    id integer NOT NULL,
    user_id integer NOT NULL,
    score bytea NOT NULL
);


ALTER TABLE public.quiz_result OWNER TO leidy_user;

--
-- Name: quiz_result_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.quiz_result_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quiz_result_id_seq OWNER TO leidy_user;

--
-- Name: quiz_result_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.quiz_result_id_seq OWNED BY public.quiz_result.id;


--
-- Name: recurso; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.recurso (
    id integer NOT NULL,
    nombre character varying(200) NOT NULL
);


ALTER TABLE public.recurso OWNER TO leidy_user;

--
-- Name: recurso_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.recurso_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recurso_id_seq OWNER TO leidy_user;

--
-- Name: recurso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.recurso_id_seq OWNED BY public.recurso.id;


--
-- Name: resultado_quiz; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.resultado_quiz (
    id integer NOT NULL,
    user_id integer NOT NULL,
    abstraccion double precision NOT NULL,
    descomposicion double precision NOT NULL,
    pensamiento_algoritmico double precision NOT NULL,
    respuestas_correctas integer NOT NULL,
    respuestas_incorrectas integer NOT NULL
);


ALTER TABLE public.resultado_quiz OWNER TO leidy_user;

--
-- Name: resultado_quiz_cuatro; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.resultado_quiz_cuatro (
    id integer NOT NULL,
    user_id integer NOT NULL,
    score integer NOT NULL,
    abstraccion double precision,
    descomposicion double precision,
    pensamiento_algoritmico double precision,
    respuestas_correctas integer,
    respuestas_incorrectas integer
);


ALTER TABLE public.resultado_quiz_cuatro OWNER TO leidy_user;

--
-- Name: resultado_quiz_cuatro_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.resultado_quiz_cuatro_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.resultado_quiz_cuatro_id_seq OWNER TO leidy_user;

--
-- Name: resultado_quiz_cuatro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.resultado_quiz_cuatro_id_seq OWNED BY public.resultado_quiz_cuatro.id;


--
-- Name: resultado_quiz_dos; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.resultado_quiz_dos (
    id integer NOT NULL,
    user_id integer NOT NULL,
    sensorial_intuitivo json NOT NULL,
    visual_verbal json NOT NULL,
    activo_reflexivo json NOT NULL,
    secuencial_global json NOT NULL
);


ALTER TABLE public.resultado_quiz_dos OWNER TO leidy_user;

--
-- Name: resultado_quiz_dos_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.resultado_quiz_dos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.resultado_quiz_dos_id_seq OWNER TO leidy_user;

--
-- Name: resultado_quiz_dos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.resultado_quiz_dos_id_seq OWNED BY public.resultado_quiz_dos.id;


--
-- Name: resultado_quiz_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.resultado_quiz_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.resultado_quiz_id_seq OWNER TO leidy_user;

--
-- Name: resultado_quiz_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.resultado_quiz_id_seq OWNED BY public.resultado_quiz.id;


--
-- Name: resultado_quiz_tres; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.resultado_quiz_tres (
    id integer NOT NULL,
    user_id integer NOT NULL,
    filantropo double precision NOT NULL,
    socializador double precision NOT NULL,
    triunfador double precision NOT NULL,
    jugador double precision NOT NULL,
    espiritu_libre double precision NOT NULL,
    disruptor double precision NOT NULL
);


ALTER TABLE public.resultado_quiz_tres OWNER TO leidy_user;

--
-- Name: resultado_quiz_tres_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.resultado_quiz_tres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.resultado_quiz_tres_id_seq OWNER TO leidy_user;

--
-- Name: resultado_quiz_tres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.resultado_quiz_tres_id_seq OWNED BY public.resultado_quiz_tres.id;


--
-- Name: tematica; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.tematica (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.tematica OWNER TO leidy_user;

--
-- Name: tematica_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.tematica_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tematica_id_seq OWNER TO leidy_user;

--
-- Name: tematica_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.tematica_id_seq OWNED BY public.tematica.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    nombres character varying(100) NOT NULL,
    correo character varying(120) NOT NULL,
    edad integer NOT NULL,
    colegio_id integer,
    nivel_grados_id integer,
    nivel_educativo character varying(50) NOT NULL,
    rol character varying(100),
    anios_experiencia integer NOT NULL,
    username character varying(80) NOT NULL,
    password character varying(200) NOT NULL,
    institucion character varying(120),
    cedula character varying(20),
    created_at timestamp without time zone DEFAULT now(),
    last_login timestamp without time zone
);


ALTER TABLE public."user" OWNER TO leidy_user;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: leidy_user
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO leidy_user;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: leidy_user
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: usuarios_cursos; Type: TABLE; Schema: public; Owner: leidy_user
--

CREATE TABLE public.usuarios_cursos (
    user_id integer NOT NULL,
    curso_id integer NOT NULL
);


ALTER TABLE public.usuarios_cursos OWNER TO leidy_user;

--
-- Name: Users id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public."Users" ALTER COLUMN id SET DEFAULT nextval('public."Users_id_seq"'::regclass);


--
-- Name: actividad_generada id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.actividad_generada ALTER COLUMN id SET DEFAULT nextval('public.actividad_generada_id_seq'::regclass);


--
-- Name: answer id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.answer ALTER COLUMN id SET DEFAULT nextval('public.answer_id_seq'::regclass);


--
-- Name: answer_tres id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.answer_tres ALTER COLUMN id SET DEFAULT nextval('public.answer_tres_id_seq'::regclass);


--
-- Name: asignatura id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.asignatura ALTER COLUMN id SET DEFAULT nextval('public.asignatura_id_seq'::regclass);


--
-- Name: colegio id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.colegio ALTER COLUMN id SET DEFAULT nextval('public.colegio_id_seq'::regclass);


--
-- Name: configuracion_notificaciones id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.configuracion_notificaciones ALTER COLUMN id SET DEFAULT nextval('public.configuracion_notificaciones_id_seq'::regclass);


--
-- Name: configuracion_sistema id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.configuracion_sistema ALTER COLUMN id SET DEFAULT nextval('public.configuracion_sistema_id_seq'::regclass);


--
-- Name: curso id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.curso ALTER COLUMN id SET DEFAULT nextval('public.curso_id_seq'::regclass);


--
-- Name: grado id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.grado ALTER COLUMN id SET DEFAULT nextval('public.grado_id_seq'::regclass);


--
-- Name: habilidad id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.habilidad ALTER COLUMN id SET DEFAULT nextval('public.habilidad_id_seq'::regclass);


--
-- Name: nivel id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.nivel ALTER COLUMN id SET DEFAULT nextval('public.nivel_id_seq'::regclass);


--
-- Name: question id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.question ALTER COLUMN id SET DEFAULT nextval('public.question_id_seq'::regclass);


--
-- Name: question_cuatro id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.question_cuatro ALTER COLUMN id SET DEFAULT nextval('public.question_cuatro_id_seq'::regclass);


--
-- Name: question_dos id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.question_dos ALTER COLUMN id SET DEFAULT nextval('public.question_dos_id_seq'::regclass);


--
-- Name: question_tres id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.question_tres ALTER COLUMN id SET DEFAULT nextval('public.question_tres_id_seq'::regclass);


--
-- Name: quiz_cuatro id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.quiz_cuatro ALTER COLUMN id SET DEFAULT nextval('public.quiz_cuatro_id_seq'::regclass);


--
-- Name: quiz_result id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.quiz_result ALTER COLUMN id SET DEFAULT nextval('public.quiz_result_id_seq'::regclass);


--
-- Name: recurso id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.recurso ALTER COLUMN id SET DEFAULT nextval('public.recurso_id_seq'::regclass);


--
-- Name: resultado_quiz id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.resultado_quiz ALTER COLUMN id SET DEFAULT nextval('public.resultado_quiz_id_seq'::regclass);


--
-- Name: resultado_quiz_cuatro id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.resultado_quiz_cuatro ALTER COLUMN id SET DEFAULT nextval('public.resultado_quiz_cuatro_id_seq'::regclass);


--
-- Name: resultado_quiz_dos id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.resultado_quiz_dos ALTER COLUMN id SET DEFAULT nextval('public.resultado_quiz_dos_id_seq'::regclass);


--
-- Name: resultado_quiz_tres id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.resultado_quiz_tres ALTER COLUMN id SET DEFAULT nextval('public.resultado_quiz_tres_id_seq'::regclass);


--
-- Name: tematica id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.tematica ALTER COLUMN id SET DEFAULT nextval('public.tematica_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public."Users" (id, username, email, password) FROM stdin;
\.


--
-- Data for Name: actividad_generada; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.actividad_generada (id, user_id, nombre_profesor, grado, asignatura, tematica, cantidad_estudiantes, tipo_actividad, tiempo, recursos, contenido, fecha_creacion, fecha_modificacion) FROM stdin;
2	18	Carlos GIovanny Hidalgo Suarez	6° Grado	Matematicas	sumas	40	Colaborativo	34	cuaderno y lampicero	## Taller: **Sumas Colaborativas: Construyendo Números Juntos**\n\n### Objetivos de Aprendizaje\n\n1. **Desarrollar la habilidad de descomposición numérica** para realizar sumas más complejas.\n2. **Fomentar el trabajo en equipo** y la colaboración entre compañeros para resolver problemas matemáticos.\n3. **Estimular la abstracción** de conceptos matemáticos a través de la práctica de sumas.\n4. **Mejorar la comunicación** y la argumentación matemática al explicar los procedimientos utilizados en las sumas.\n\n### Introducción Motivadora\n\n¡Bienvenidos, estudiantes! Hoy vamos a convertirnos en verdaderos *constructores de números*. Imaginemos que cada número es un ladrillo y que, al sumarlos, estamos construyendo una increíble torre de matemáticas. Cada uno de ustedes jugará un papel importante en este proyecto colaborativo. ¿Están listos para trabajar en equipo y descubrir el poder de las sumas? ¡Vamos a empezar!\n\n### Desarrollo de la Actividad\n\n#### Paso a Paso:\n\n1. **Formación de Equipos:**\n   - Dividir la clase en **8 grupos** de **5 estudiantes** cada uno. Esto fomentará la colaboración y el intercambio de ideas.\n\n2. **Introducción a la Descomposición:**\n   - Explicar brevemente qué es la descomposición numérica y cómo se relaciona con la suma.\n   - Proporcionar ejemplos simples en la pizarra.\n\n3. **Presentación de Desafío:**\n   - Cada grupo recibirá un conjunto de problemas de suma que deberán resolver colaborativamente. Estos problemas estarán diseñados para ser descompuestos en partes más pequeñas.\n\n4. **Distribución de Recursos:**\n   - Proporcionar a cada estudiante un cuaderno y un lampicero para que puedan trabajar en sus soluciones.\n\n5. **Resolución Colaborativa:**\n   - Los grupos trabajarán juntos para resolver los problemas, utilizando la descomposición. Cada grupo debe elegir un **portavoz** que explique su método al resto de la clase.\n\n### Actividades Prácticas Específicas\n\n- **Ejercicio 1: Sumas Simples descompuestas**\n  - Problema: 58 + 27\n  - Descomponer los números en decenas y unidades y sumar cada parte por separado.\n\n- **Ejercicio 2: Problema de la Torre**\n  - Cada grupo debe crear un problema de suma utilizando un conjunto de números que ellos elijan, y luego compartirlo con otro grupo para que lo resuelvan.\n\n- **Ejercicio 3: Justificación del Método**\n  - Cada grupo debe escribir brevemente en su cuaderno cómo descompusieron los números y por qué eligieron ese método.\n\n### Evaluación o Cierre\n\n- **Presentación de Resultados:**\n  - Cada grupo tendrá **3 minutos** para presentar su solución al resto de la clase, explicando su método y el razonamiento detrás de él.\n  \n- **Reflexión Final:**\n  - Preguntar a los estudiantes cómo se sintieron trabajando en equipo y qué aprendieron sobre la suma y la descomposición.\n\n### Recursos Necesarios\n\n- **Cuadernos** para cada estudiante.\n- **Lampiceros** para escribir.\n- **Problemas de suma** impresos o escritos en la pizarra para que los grupos los resuelvan.\n- **Cronómetro** para controlar el tiempo de las presentaciones.\n\n---\n\nEste taller no solo desarrollará las habilidades matemáticas de los estudiantes, sino que también fortalecerá su capacidad de trabajar en equipo y comunicarse efectivamente. ¡Que empiece la aventura matemática!	2025-10-25 16:08:14.004354	2025-10-25 16:08:14.004359
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.alembic_version (version_num) FROM stdin;
base
624fdffbc687
beae1797a1b1
\.


--
-- Data for Name: answer; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.answer (id, user_id, question_id, selected_answer) FROM stdin;
\.


--
-- Data for Name: answer_tres; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.answer_tres (id, user_id, question_id, selected_answer) FROM stdin;
\.


--
-- Data for Name: asignatura; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.asignatura (id, nombre) FROM stdin;
1	Programación
2	Matemáticas
3	Tecnologia
4	Ciencias
5	Otra
\.


--
-- Data for Name: colegio; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.colegio (id, nombre) FROM stdin;
1	UnivalleThink
2	Univalle
3	MMVLab
4	SIPECO
5	Curso de PC
6	Unicamacho
\.


--
-- Data for Name: configuracion_notificaciones; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.configuracion_notificaciones (id, notif_login, notif_registro, notif_test_completado, email_destino, actualizado_at) FROM stdin;
1	t	t	t	cgiohidalgo@gmail.com	2025-10-24 04:40:08.370692
\.


--
-- Data for Name: configuracion_sistema; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.configuracion_sistema (id, clave, valor, descripcion) FROM stdin;
1	quiz1_activo	true	Activar/Desactivar Quiz 1 (ADAT)
3	quiz3_activo	true	Activar/Desactivar Quiz 3 (Jugador)
4	quiz4_activo	true	Activar/Desactivar Quiz 4 (Pensamiento)
6	permitir_registro	true	Permitir nuevos registros
11	perfil_activo	true	Activar/Desactivar vista de Perfil del usuario
2	quiz2_activo	true	Activar/Desactivar Quiz 2 (Estilos)
10	resultados_activo	false	Activar/Desactivar vista de Resultados del usuario
7	tiempo_quiz1	60	Tiempo límite Quiz 1 (minutos)
8	tiempo_quiz4	60	Tiempo límite Quiz 4 (minutos)
5	mensaje_bienvenida	Bienvenido a la plataforma AKILA	Mensaje de bienvenida
9	generador_actividades_activo	false	Activar/Desactivar Generador de Actividades y Mis Actividades
\.


--
-- Data for Name: curso; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.curso (id, nombre) FROM stdin;
1	Pensamiento computacional
2	Matemáticas 
3	Tecnologia
4	Ciencias
5	Programación
6	Otro
\.


--
-- Data for Name: grado; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.grado (id, nombre) FROM stdin;
1	Primero
2	Segundo
3	Tercero
4	Cuarto
5	Quinto
6	Sexto
7	Septimo
8	Octavo
9	Noveno
10	Decimo
11	Once
12	Educación Superior
13	Otro
14	No aplica
\.


--
-- Data for Name: grados_dictados; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.grados_dictados (user_id, grado_id) FROM stdin;
120	1
121	10
19	10
19	11
20	8
20	9
20	10
20	6
20	11
20	7
21	8
21	9
21	6
21	7
22	10
22	9
24	10
24	7
24	8
24	9
29	10
29	11
29	9
30	7
30	10
30	3
30	5
30	4
30	9
30	11
30	6
30	8
32	6
45	7
45	6
49	10
49	9
49	12
51	6
51	7
53	6
57	10
57	11
58	6
58	9
58	7
59	6
59	7
59	9
61	9
61	10
61	6
61	7
61	8
63	9
63	6
63	8
63	7
64	9
64	8
64	7
64	6
65	10
65	9
67	3
67	5
67	6
67	2
67	4
67	1
67	7
69	6
69	10
69	7
69	9
69	8
72	9
72	10
72	11
72	6
72	7
72	8
75	7
75	6
75	9
76	9
76	11
76	10
76	8
77	13
77	7
77	10
77	8
80	8
80	9
83	8
83	6
83	7
83	9
86	10
86	11
90	11
90	10
90	9
92	11
92	10
93	8
93	9
93	6
93	11
93	10
93	7
95	10
95	11
121	9
101	7
101	8
102	3
103	7
105	7
105	6
105	9
105	8
106	11
106	10
106	9
111	7
111	13
111	8
111	9
111	10
111	6
111	11
115	10
115	9
121	8
121	11
121	7
121	6
122	10
\.


--
-- Data for Name: habilidad; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.habilidad (id, nombre) FROM stdin;
1	Abstracción
2	Descomposición
3	Pensamiento Algorítmico
\.


--
-- Data for Name: nivel; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.nivel (id, nombre) FROM stdin;
1	Preescolar
2	Primaria
3	Secundaria
4	Educación Superior
\.


--
-- Data for Name: nivel_por_grados; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.nivel_por_grados (user_id, nivel_id) FROM stdin;
19	3
20	3
21	3
22	3
24	3
29	3
30	2
30	3
32	3
45	3
49	4
51	3
53	3
57	3
58	4
59	3
61	3
63	3
64	3
65	3
67	1
67	2
69	4
69	3
72	3
75	3
76	3
77	3
80	3
83	3
86	3
90	4
92	4
93	3
93	2
95	3
101	3
102	2
103	3
105	3
106	3
111	3
115	3
115	2
115	1
115	4
120	3
121	3
122	3
\.


--
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.question (id, statement, option_a, option_b, option_c, option_d, correct_answer, label, percentage, image_url) FROM stdin;
10	10. Una princesa tiene una pulsera mágica, la pulsera es como se muestra en la figura. Cuando la guarda en su joyero, las abre y quedan así. ¿Cuál de las cuatro pulseras que hay en el cajón es la mágica?	A	B	C	D	B	Descomposición	4	https://leidyjohanna.pythonanywhere.com/static/images/P10.png
2	2. ¿Qué instrucciones toma el “Pacman” (B6) al “Fantasma” (B4) usando el camino marcado?	A	B	C	D	A	Pensamiento Algorítmico	4	https://leidyjohanna.pythonanywhere.com/static/images/P2.png
1	1. Considerando situaciones como planear una fiesta sorpresa, reparar un pinchazo en una bicicleta o diseñar un paracaídas para proteger un huevo al caer, puedo averiguar los pasos necesarios para resolver un problema.	Totalmente de acuerdo	De acuerdo	Indeciso	En desacuerdo	Totalmente de acuerdo	Descomposición	2	\N
3	3. Un automóvil arranca en la posición (A2) y con dirección como se muestra por la flecha blanca en el techo de este. El automóvil nunca puede pasar a través de una roca o compartir la misma posición que una roca. ¿Qué instrucciones llevan correctamente el automóvil al cuadrado estampado con rayas naranja (B1)?	A	B	C	D	C	Abstracción	12	https://leidyjohanna.pythonanywhere.com/static/images/P3.png
12	12. Durante una reunión de los padres de familia de grado 11° se discute sobre la cantidad de estudiantes que podrían perder el año, para ello se observan estadísticas de los años anteriores que se presentan en la tabla.\n\nUn padre de familia afirma que el 100% de los estudiantes no llegara a graduarse este año, dado que en el 2017 1 de cada 10 estudiantes perdió el año y se sabe que se agruparon los estudiantes en 6 grupos iguales. Por su parte la rectora indica que para el primer periodo un 20% de los alumnos de grado 11° van perdiendo el año, si se sabe que la cantidad de alumnos de grado 11° de 2018 es igual que la cantidad de alumnos de grado 11° de 2017, ¿Qué número de alumnos conforman el grado 11° de 2018 y cuantos van perdiendo el año?	Son 55 y van perdiendo 15	Son 60 y van perdiendo 6	Son 50 y van perdiendo 10	Son 60 y van perdiendo 12	Son 60 y van perdiendo 12	Descomposición	4	https://leidyjohanna.pythonanywhere.com/static/images/P12.png
4	4. Un automóvil arranca en la posición (F1) y con dirección a la izquierda, como se muestra por la flecha blanca en el techo de este. El automóvil nunca puede pasar a través de una roca o compartir la misma posición que una roca. ¿Qué instrucciones llevan correctamente el automóvil al cuadrado estampado con rayas naranja (F7) por el camino verde marcado?	A	B	C	D	B	Abstracción	8	https://leidyjohanna.pythonanywhere.com/static/images/P4.png
5	5. ¿Qué órdenes debe seguir el artista para dibujar el cuadrado? Cada lado del cuadrado mide 100 píxeles.	A	B	C	D	D	Pensamiento Algorítmico	4	https://leidyjohanna.pythonanywhere.com/static/images/P5.png
6	6. ¿Cuántas veces deben repetirse las órdenes que hay en el rectángulo gris, para llevar a al "Pacman" hasta el "Fantasma", por el camino señalado?	A	B	C	D	D	Pensamiento Algorítmico	6	https://leidyjohanna.pythonanywhere.com/static/images/P6.png
7	7. ¿Qué órdenes llevan al "Pacman" por el camino señalado y le van indicando que se coma el número de fresas correspondiente que hay en cada casilla?	A	B	C	D	C	Abstracción	8	https://leidyjohanna.pythonanywhere.com/static/images/P7.png
8	8. ¿Qué bloque falta en la siguiente secuencia, para que el "Pacman" avance por el camino señalado comiéndose el número de fresas indicadas? El símbolo de interrogación (?) junto a la fresa, significa que no sabemos cuántas fresas puede haber en esa casilla.	A	B	C	D	C	Pensamiento Algorítmico	6	https://leidyjohanna.pythonanywhere.com/static/images/P8.png
9	9. ¿Qué falta en la serie de órdenes del lado derecho (¿ ?) para llevar al "Pacman" hasta el "Fantasma" por el camino señalado?	A	B	C	D	C	Abstracción	6	https://leidyjohanna.pythonanywhere.com/static/images/P9.png
11	11. Se está volteando una baraja de cartas siguiendo esta regla simple: gira una carta. Si la carta es un corazón, se descarta un número de cartas igual al número total de cartas de corazón que ya has volteado (sin mirar). Se continúa repitiendo este paso hasta quedar sin cartas. ¿Cuál de los siguientes pasos implementa la regla?	A	B	C	D	A	Pensamiento Algorítmico	12	https://leidyjohanna.pythonanywhere.com/static/images/P11.png
13	13. Hay dos ciudades cercanas. En la ciudad más grande, nacen alrededor de cuarenta y cinco (45) bebés cada día. En la ciudad más pequeña, nacen alrededor de quince (15) bebés cada día. De los niños que nacen cada día, alrededor del 50% son niñas. Sin embargo, el porcentaje exacto de niñas varía de un día a otro. A veces puede ser superior al 50%, a veces inferior. Durante un año, cada ciudad registró los días en que más del 60% de los bebés nacidos ese día eran niñas. (a) ¿Qué ciudad crees que registró más días así?	La ciudad más grande	La ciudad más pequeña	Aproximadamente lo mismo (dentro del 5% de cada uno)	No es posible saberlo con la información dada	La ciudad más pequeña	Abstracción	12	\N
15	15. Durante la última década en la ciudad de Pamplona se han registrado fuertes lluvias, los entes de control del municipio se encuentran alarmados dado que los valores registrados indican que año a año las lluvias van en aumento, y en el año anterior se presentaron emergencias por derrumbes e inundaciones a lo largo de todo el municipio. A continuación se relaciona en la tabla los valores obtenidos durante los últimos 10 años de lluvias en pamplona. \r\nDe acuerdo a la información de la tabla los entes municipales se proponen una solución radical para mitigar el impacto de las lluvias en el municipio, entre varias propuestas se escoge la de crear un domo desplegable que cubra el municipio, de esta manera cuando la lluvia sea demasiada o muy fuerte con solo cerrar el domo se evitará el exceso de agua que provenga de la lluvia. Se abre una convocatoria con el fin de recibir propuestas para el desarrollo de dicho proyecto, ¿En qué fases se debe descomponer un proyecto de tanta magnitud?	Comprar los materiales, contratar la mano de obra, crear el domo, hacer los estudios correspondientes.	Realizar los estudios correspondientes, tramitar los permisos necesarios, realizar presupuestos, compra de maquinaria, materiales y contratación de mano de obra, construir el domo.	Conseguir todo lo necesario para la construcción del domo, gestionar todos los permisos necesarios, construir el domo.	Ninguna de las anteriores	B	Descomposición	4	https://leidyjohanna.pythonanywhere.com/static/images/P15.png
14	14. Durante una excursión usted se pierde en el bosque y se encuentra completamente solo, dado que antes de dicha excursión usted no había informado a nadie de sus planes, no tiene esperanzas de ser rescatado debido a que nadie conoce su ubicación.  Pero usted es un experto en supervivencia y posee la siguiente información sobre el bosque donde se encuentra perdido: \r\nTemperatura: Muy caliente \r\nHumedad: Alta \r\nTipo de vegetación: mayormente árboles grandes y frondosos, variedad de frutas silvestres. \r\nTipo de fauna: Gran variedad de animales aptos para consumo humano, alta tasa de encuentro con animales peligrosos. Disponibilidad de agua: baja, el rio más cercano esta a 3 días de camino, y lo aleja 2 días más de la civilización. \r\nLejanía de la civilización: el pueblo más cercano está a 7 días de camino. \r\nLuego de revisar sus anotaciones usted decide realizar una lista en la cual establece sus necesidades y cómo las puede suplir con sus habilidades.\r\n\r\nPor último usted realiza una lista de todas las cosas que puede hacer con el fin de definir una agenda a seguir. \r\n1. Construir choza que le tome 1 día \r\n2. Construir choza que le tome 3 días \r\n3. Prender el fuego \r\n4. Capturar un animal con arco y flecha \r\n5. Caminar hasta el río \r\n6. Recoger frutas \r\n7. Pescar con mosca \r\n8. Caminar hasta la civilización \r\n\r\nDado que usted posee agua para 4 días de viaje y usted se perdió en la mañana, ¿Cuál es el itinerario a seguir para lograr sobrevivir?	8, 5, 3, 7, 2	5, 4, 6, 2, 8	3, 1, 6, 5, 8	7, 5, 6, 2, 8	C	Descomposición	8	https://leidyjohanna.pythonanywhere.com/static/images/P14.png
\.


--
-- Data for Name: question_cuatro; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.question_cuatro (id, statement, option_a, option_b, option_c, option_d, correct_answer, label, percentage, image_url) FROM stdin;
\.


--
-- Data for Name: question_dos; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.question_dos (id, statement, option_a, option_b) FROM stdin;
1	1. Entiendo mejor algo cuando:	Lo practico constantemente	Solo pienso sobre ello constantemente
2	2. Me considero:	Realista: Intentas buscar situaciones a partir de lo que puedes visualizar	Innovador: Pensando en las distintas soluciones que podrías llegar a generar para solucionar el problema
4	3. Cuando piensas acerca de lo que hiciste ayer, es más probable que lo hagas basándote en:	Una imagen de lo que sucedió	Palabras o relatos de lo que sucedió
5	4. En el instante en que entiendes algo lo haces:	Entendiendo los detalles de un tema pero no viendo claramente su estructura completa	Entendiendo la estructura completa pero no viendo claramente los detalles
6	5. Cuando intentas aprender algo nuevo, te ayuda: 	Hablar de ello con otras personas	Pensar en ello y reflexionar sobre el tema
7	6.  Como profesor,  prefieres dar un curso:	Que trate sobre hechos y situaciones reales de la vida	Que trate con ideas y teorías
8	7. Prefiero obtener información nueva de:	Imágenes, diagramas, gráficas o mapas	Instrucciones escritas o información verbal
9	8. De qué manera logras entender mejor un tema:	Comprendo primero cada una de sus partes y luego su totalidad	Comprendo el total del tema y luego como encajan sus partes
10	9. En un grupo de estudio que trabaja con un material difícil, es más probable que:	Participe y contribuya con ideas para llegar a una solución	No participe y solo escuche para aclarar mis ideas
11	10. Se me facilita más aprender mediante:	Hechos, acciones y prácticas	Conceptos y teorías
12	11. En un libro con muchas imágenes y gráficas es más probable que:	Revise cuidadosamente las imágenes y las gráficas	Me concentre en leer todo el texto y el contenido escrito
13	12. Cuando resuelvo problemas de matemáticas: 	Generalmente llego a soluciones paso por pasa	Frecuentemente llego a las soluciones rápidamente, pero luego tengo dificultad para averiguar los pasos que me llevaron a las soluciones
14	13. En las clases que he tomado	Por lo general he llegado a conocer a muchos de los estudiantes	Raramente he llegado a conocer a muchos de los estudiantes
15	14. Cuando leo temas que no son de ficción, prefiero:	Algo que me enseñe nuevos hechos o me diga como hacer algo	Algo que me dé nuevas ideas en que pensar
16	15. Me gusta más cuando un maestro:	Utiliza muchos esquemas en el tablero para explicar el tema	Toma mucho tiempo para explicar, dialogando acerca del tema
17	16. Cuando estoy analizando un cuento o una novela, sucede que:	Pienso en los incidentes y trato de acomodarlos para estructuras los temas	Me doy cuenta de cuáles son los temas cuando termino de leer y luego tengo que regresar y encontrar los incidentes que los demuestran
18	17. Cuando comienzo a resolver un problema dentro de alguna tarea, es más probable que:	Comience a trabajar en su solución inmediatamente	Primero trate de entender completamente el problema
19	18. Prefiero las ideas basadas en:	La certeza	La teoría
20	19. Recuerdo mejor:	Las cosas que veo	Las cosas que oigo
21	20. Lo más importante para mí de un docente/tutor es que:	Exponga el material en pasos secuenciales claros	Me dé un panorama general y relacione el material con otros temas
22	21. Prefiero estudiar de manera:	Grupal (en un grupo de estudio)	Individual (apartado, solo)
23	22. Me considero:	Cuidados@ en los detalles de mi trabajo	Creativ@ en la forma en la que realizo mi trabajo
24	23. Cuando alguien me da direcciones de nuevos lugares, prefiero hacer uso de:	Un mapa ó diagrama	Instrucciones escritas
25	24. Aprendo de manera:	Constante, si estudio con empeño consigo lo que deseo	Con pausas y reinicios, me llego a confundir y pero de un momento a otro lo entiendo
26	25. Ante una tarea, prefiero primero:	Hacer algo y ver que sucede luego	Pensar como voy a hacer algo antes de actuar
27	26. Cuando leo por diversión, me gustan más los escritores que:	Dicen claramente los que desean dar a entender	Dicen las cosas en forma creativa e interesante
28	27. Cuando veo un esquema, mapa, dibujo o bosquejo para la explicación de un tema en clase, es más probable que de él recuerde:	Las imágenes	Lo que el profesor dijo acerca del mismo
29	28. Cuando intento aprender un nuevo tema:	Me concentro en los detalles y paso por alto la estructura total de la temática	Trato de entender el todo antes de concentrarme en los detalles de la temática
30	29. Recuerdo más fácilmente:	Las cosas que hago	Las cosas en las que he pensado mucho
31	30. Cuando tengo que hacer un trabajo o tarea, prefiero:	Intentar dominar una forma de hacerlo	Intentar nuevas formas de hacerlo
32	31. Cuando alguien me muestra datos, prefiero:	Gráficas, esquemas o dibujos	Resúmenes con texto
33	32. Cuando escribo un trabajo, es más probable que:	Lo haga (piense o escriba) desde el principio y avance	Lo haga (piense o escriba) en diferentes partes y luego las ordene
34	33. Cuando tengo que trabajar en un proyecto grupal, primero quiero:	Realizar una "lluvia de ideas" donde cada integrante aporte con ideas	Realizar una "lluvia de ideas" de forma individual y luego juntarme con el grupo para comparar las ideas
35	34. Considero que es más agradable ser:	Una persona sensible	Una persona innovadora
36	35. Cuando conozco gente en una fiesta, es más probable que recuerde:	Cómo es su apariencia	Lo que dicen de sí mismos
37	36. Cuando estoy aprendiendo un tema, prefiero:	Mantenerme concentrado en ese tema, aprendiendo lo más que pueda de él	Hacer conexiones entre ese tema y temas relacionados
38	37. Me considero un ser:	Abierto con mis ideas y sentimientos	Reservado con mis ideas y sentimientos
39	38. Prefiero cursos, materias o áreas que dan más importancia a:	Material y contenido concreto (hechos, datos)	Material y contenido abstracto (conceptos, teorías)
40	39. Para divertirme, prefiero:	Ver televisión, ver videos o series	Leer un libro, texto, historietas, comics u otro tipo de contenido escrito
41	40. Algunos profesores inician sus clases haciendo una lista, bosquejos o esquemas de lo que enseñarán. Este contenido puede ser:	Algo útil para mí	Algo muy útil para mí
42	41. La idea de hacer una tarea grupal con una sola calificación para todos	Me parece justa	No me parece injusta
43	42. Cuando realizo cálculos grandes, trabajos complejos o largos:	Tiendo a repetir todos mis pasos y revisar cuidadosamente mi trabajo	Me cansa hacer su revisión y tengo que esforzarme para hacerlo
44	43. Tiendo a recordar lugares en los que he estado:	Fácilmente y con bastante exactitud	Con dificultad y sin mucho detalle
45	44. Cuando resuelvo problemas en grupo, es más probable que yo:	Piense en los pasos para la solución de los problemas	Piense en las posibles consecuencias o aplicaciones de la solución general para el problema y cómo aplicarlo en otras ocasiones
\.


--
-- Data for Name: question_tres; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.question_tres (id, statement, option_a, option_b, option_c, option_d, option_e) FROM stdin;
120	12. No me gusta seguir las reglas	Totalmente de acuerdo	De acuerdo	Me es indiferente	En desacuerdo	Totalmente en desacuerdo
110	11. Me describo a mí mism@ como un rebelde	Totalmente de acuerdo	De acuerdo	Me es indiferente	En desacuerdo	Totalmente en desacuerdo
100	10. Ser independiente es importante para mí	Totalmente de acuerdo	De acuerdo	Me es indiferente	En desacuerdo	Totalmente en desacuerdo
90	9. Seguir mi propio camino es importante para mí	Totalmente de acuerdo	De acuerdo	Me es indiferente	En desacuerdo	Totalmente en desacuerdo
80	8. Pienso que las recompensas son una excelente manera de motivarme	Totalmente de acuerdo	De acuerdo	Me es indiferente	En desacuerdo	Totalmente en desacuerdo
70	7. Si la recompensa es suficiente, pondré el esfuerzo necesario	Totalmente de acuerdo	De acuerdo	Me es indiferente	En desacuerdo	Totalmente en desacuerdo
60	6. Disfruto salir victorioso de circunstancias difíciles	Totalmente de acuerdo	De acuerdo	Me es indiferente	En desacuerdo	Totalmente en desacuerdo
50	5. Me gusta dominar tareas difíciles	Totalmente de acuerdo	De acuerdo	Me es indiferente	En desacuerdo	Totalmente en desacuerdo
40	4. Disfruto participando en actividades grupales	Totalmente de acuerdo	De acuerdo	Me es indiferente	En desacuerdo	Totalmente en desacuerdo
30	3. Me gusta formar parte de un equipo	Totalmente de acuerdo	De acuerdo	Me es indiferente	En desacuerdo	Totalmente en desacuerdo
20	2. El bienestar de los demás es importante para mí	Totalmente de acuerdo	De acuerdo	Me es indiferente	En desacuerdo	Totalmente en desacuerdo
10	1. Me siento feliz siendo capaz de ayudar a los demás	Totalmente de acuerdo	De acuerdo	Me es indiferente	En desacuerdo	Totalmente en desacuerdo
\.


--
-- Data for Name: quiz_cuatro; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.quiz_cuatro (id, statement, option_a, option_b, option_c, option_d, correct_answer, label, percentage, image_url) FROM stdin;
5	¿Qué órdenes debe ejecutar el artista para dibujar el cuadrado? Cada uno de los lados del cuadrado mide 100 píxeles	A	B	C	D	D	CTt	3.125	/static/uploads/quiz4/1_1761093014.jpg
8	Para que el artista dibuje una vez el siguiente rectángulo (50 píxeles de ancho y 100 píxeles de alto), ¿en qué paso de la siguiente secuencia de órdenes hay un error?	A	B	C	D	A	CTt	3.125	/static/uploads/quiz4/8_1761095576.jpg
4	Para llevar a ‘Pac-Man’ hasta el fantasma por el camino señalado, ¿en qué paso de la siguiente secuencia de órdenes hay un error?	A	B	C	D	D	CTt	3.125	/static/uploads/quiz4/4_1761095548.jpg
6	¿Qué órdenes llevan a ‘Pac-Man’ hasta el fantasma por el camino señalado?	A	B	C	D	C	CTt	3.125	/static/uploads/quiz4/2_1761093027.jpg
7	¿Cuántas veces se debe repetir la secuencia para llevar a ‘Pac-Man’ hasta el fantasma por el camino señalado?	A	B	C	D	D	CTt	3.125	/static/uploads/quiz4/2_1761093065.jpg
3	¿Qué orden falta en la secuencia para llevar a ‘Pac-Man’ hasta el fantasma por el camino señalado?	A	B	C	D	C	CTt	3.125	/static/uploads/quiz4/3_1761095151.jpg
9	¿Qué órdenes llevan a ‘Pac-Man’ hasta el fantasma por el camino señalado?	A	B	C	D	B	CTt	3.125	/static/uploads/quiz4/9_1761095623.jpg
10	¿Qué órdenes llevan a ‘Pac-Man’ hasta el fantasma por el camino señalado?	A	B	C	D	D	CTt	3.125	/static/uploads/quiz4/10_1761095636.jpg
11	¿Qué bloque falta en la siguiente secuencia de órdenes para que ‘Pac-Man’ llegue hasta el fantasma por el camino señalado?	A	B	C	D	C	CTt	3.125	/static/uploads/quiz4/11_1761095650.jpg
12	Para que ‘Pac-Man’ llegue hasta el fantasma por el camino señalado, ¿en qué paso de la siguiente secuencia de órdenes hay un error?	A	B	C	D	B	CTt	3.125	/static/uploads/quiz4/12_1761095662.jpg
13	¿Qué secuencia de órdenes debe ejecutar el artista para dibujar la escalera que llegue hasta la flor? Cada peldaño sube 30 píxeles	A	B	C	D	A	CTt	3.125	/static/uploads/quiz4/13_1761095676.jpg
14	¿Qué órdenes llevan a ‘Pac-Man’ hasta el fantasma por el camino señalado?	A	B	C	D	B	CTt	3.125	/static/uploads/quiz4/14_1761095689.jpg
15	¿Qué órdenes llevan a ‘Pac-Man’ hasta el fantasma por el camino señalado?	A	B	C	D	A	CTt	3.125	/static/uploads/quiz4/15_1761095702.jpg
16	¿Qué falta en la siguiente secuencia de órdenes para llevar a ‘Pac-Man’ hasta el fantasma por el camino señalado?	A	B	C	D	D	CTt	3.125	/static/uploads/quiz4/16_1761095716.jpg
17	Para que ‘Pac-Man’ llegue hasta el fantasma por el camino señalado, ¿en qué paso de la siguiente secuencia de órdenes hay un error?	A	B	C	D	D	CTt	3.125	/static/uploads/quiz4/17_1761095730.jpg
18	¿Qué órdenes llevan a ‘Pac-Man’ hasta el fantasma por el camino señalado?	A	B	C	D	B	CTt	3.125	/static/uploads/quiz4/18_1761095742.jpg
19	¿Qué órdenes llevan a ‘Pac-Man’ hasta el fantasma por el camino señalado?	A	B	C	D	A	CTt	3.125	/static/uploads/quiz4/19_1761095755.jpg
20	Para que ‘Pac-Man’ llegue hasta el fantasma por el camino señalado, ¿en qué paso de la siguiente secuencia de órdenes hay un error?	A	B	C	D	B	CTt	3.125	/static/uploads/quiz4/20_1761095769.jpg
21	¿Qué bloque falta en la siguiente secuencia de órdenes para que ‘Pac-Man’ llegue hasta el fantasma por el camino señalado?	A	B	C	D	C	CTt	3.125	/static/uploads/quiz4/21_1761095781.jpg
24	¿Qué falta en la siguiente secuencia de órdenes para que ‘Pac-Man’ avance por el camino señalado comiendo el número de fresas indicadas?	A	B	C	D	A	CTt	3.125	/static/uploads/quiz4/24_1761095849.jpg
23	¿Qué órdenes van llevando a ‘Pac-Man’ por el camino señalado e indicándole que se coma el número de fresas correspondiente?	A	B	C	D	B	CTt	3.125	/static/uploads/quiz4/23_1761095822.jpg
22	¿Qué órdenes llevan a ‘Pac-Man’ por el camino señalado hasta las fresas e indican a ‘Pac-Man' que se coma el número de fresas indicado?	A	B	C	D	A	CTt	3.125	/static/uploads/quiz4/22_1761095836.jpg
25	¿Qué bloque falta en la siguiente secuencia de órdenes para que ‘Pac-Man’ avance por el camino señalado comiendo el número de fresas indicadas (número desconocido)?	A	B	C	D	C	CTt	3.125	/static/uploads/quiz4/25_1761095864.jpg
26	¿Qué secuencia debe ejecutar el artista para dibujar el siguiente diseño? Cada uno de los lados de cada cuadrado mide 100 píxeles	A	B	C	D	B	CTt	3.125	/static/uploads/quiz4/26_1761095876.jpg
27	¿Qué le falta a la siguiente secuencia para que el artista dibuje el siguiente diseño? Cada uno de los lados de cada triángulo mide 50 píxeles	A	B	C	D	B	CTt	3.125	/static/uploads/quiz4/27_1761095889.jpg
28	¿Qué órdenes van llevando a ‘Pac-Man’ por el camino señalado e indicándole que se coma el número de fresas correspondiente?	A	B	C	D	A	CTt	3.125	/static/uploads/quiz4/28_1761095903.jpg
2	¿Qué órdenes llevan a ‘Pac-Man’ hasta el fantasma por el camino señalado?	A	B	C	D	B	CTt	3.125	/static/uploads/quiz4/2_1761095918.jpg
29	¿Qué falta en la siguiente secuencia para llevar a ‘Pac-Man’ por el camino señalado hasta las fresas, comiendo el número de fresas indicado?	A	B	C	D	C	CTt	3.125	/static/uploads/quiz4/29_1761095932.jpg
33	¿Qué le falta a la siguiente secuencia para que el artista dibuje el siguiente diseño? El lado más corto mide 20 píxeles y el lado más largo mide 200 píxeles	A	B	C	D	B	CTt	3.125	https://drive.google.com/file/d/18BfnOyVbezHNN0gYxv3a4PXKYn2RLBUR/view?usp=sharing
32	¿Qué secuencia debe ejecutar el artista para dibujar el siguiente diseño? El lado del cuadrado más pequeño es 30 píxeles, y el lado del cuadrado más grande es 150 píxeles.	A	B	C	D	B	CTt	3.125	/static/uploads/quiz4/32_1761095610.jpg
30	¿Qué órdenes llevan a ‘Pac-Man’ por el camino señalado y hacen que ‘Pac-Man’ se coma el número de fresas indicado? En las casillas con fresas puede haber 1, 2 ó 3 fresas	A	B	C	D	D	CTt	3.125	/static/uploads/quiz4/30_1761095949.jpg
31	¿Qué falta en la siguiente secuencia para llevar a ‘Pac-Man’ por el camino señalado comiendo el número de fresas indicado? En las casillas con fresas puede haber 1, 2 ó 3 fresas.	A	B	C	D	A	CTt	3.125	/static/uploads/quiz4/31_1761095964.jpg
\.


--
-- Data for Name: quiz_result; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.quiz_result (id, user_id, score) FROM stdin;
\.


--
-- Data for Name: recurso; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.recurso (id, nombre) FROM stdin;
\.


--
-- Data for Name: resultado_quiz; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.resultado_quiz (id, user_id, abstraccion, descomposicion, pensamiento_algoritmico, respuestas_correctas, respuestas_incorrectas) FROM stdin;
7	10	8	0	22	4	11
9	13	12	4	22	5	10
10	12	14	4	32	8	7
11	15	14	4	28	7	8
13	29	18	4	16	6	8
14	64	18	4	20	7	8
15	49	12	0	0	1	14
16	67	0	12	26	6	9
17	22	8	4	4	3	12
18	32	0	0	12	2	13
19	77	8	12	0	3	12
20	61	12	0	10	3	12
21	57	0	12	14	5	10
22	90	26	12	32	10	5
23	24	20	4	20	7	7
24	51	0	12	14	5	10
25	30	8	4	32	7	8
26	72	28	8	0	4	11
27	83	12	8	6	3	12
28	21	0	12	24	5	10
29	69	12	4	10	4	11
30	76	12	12	20	7	8
31	45	16	4	16	6	6
33	102	0	8	0	2	13
34	111	18	16	28	9	6
35	20	0	16	28	7	8
36	75	20	8	20	8	7
37	105	8	12	12	5	10
38	18	8	12	6	4	10
39	121	20	4	6	4	10
40	120	34	16	26	11	4
42	116	6	0	4	2	13
\.


--
-- Data for Name: resultado_quiz_cuatro; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.resultado_quiz_cuatro (id, user_id, score, abstraccion, descomposicion, pensamiento_algoritmico, respuestas_correctas, respuestas_incorrectas) FROM stdin;
5	120	21	\N	\N	\N	7	22
8	18	25	\N	\N	\N	8	24
\.


--
-- Data for Name: resultado_quiz_dos; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.resultado_quiz_dos (id, user_id, sensorial_intuitivo, visual_verbal, activo_reflexivo, secuencial_global) FROM stdin;
2	12	{"estado": "Intuitivo", "valor": "Apropiado", "total": 8}	{"estado": "Visual", "valor": "Apropiado", "total": 6}	{"estado": "Activo", "valor": "Moderado", "total": 8}	{"estado": "Secuencial", "valor": "Apropiado", "total": 6}
3	15	{"estado": "Sensorial", "valor": "Apropiado", "total": 6}	{"estado": "Visual", "valor": "Apropiado", "total": 7}	{"estado": "Reflexivo", "valor": "Apropiado", "total": 8}	{"estado": "Secuencial", "valor": "Apropiado", "total": 6}
5	76	{"estado": "Sensorial", "valor": "Moderado", "total": 8}	{"estado": "Visual", "valor": "Moderado", "total": 8}	{"estado": "Activo", "valor": "Moderado", "total": 8}	{"estado": "Secuencial", "valor": "Moderado", "total": 9}
6	45	{"estado": "Sensorial", "valor": "Moderado", "total": 8}	{"estado": "Visual", "valor": "Moderado", "total": 8}	{"estado": "Activo", "valor": "Moderado", "total": 8}	{"estado": "Secuencial", "valor": "Moderado", "total": 9}
7	69	{"estado": "Intuitivo", "valor": "Apropiado", "total": 9}	{"estado": "Visual", "valor": "Apropiado", "total": 6}	{"estado": "Reflexivo", "valor": "Apropiado", "total": 9}	{"estado": "Secuencial", "valor": "Apropiado", "total": 7}
8	102	{"estado": "Sensorial", "valor": "Apropiado", "total": 6}	{"estado": "Visual", "valor": "Apropiado", "total": 6}	{"estado": "Activo", "valor": "Apropiado", "total": 7}	{"estado": "Global", "valor": "Apropiado", "total": 8}
9	111	{"estado": "Intuitivo", "valor": "Apropiado", "total": 9}	{"estado": "Visual", "valor": "Moderado", "total": 8}	{"estado": "Activo", "valor": "Moderado", "total": 8}	{"estado": "Secuencial", "valor": "Fuerte", "total": 11}
10	20	{"estado": "Intuitivo", "valor": "Apropiado", "total": 6}	{"estado": "Verbal", "valor": "Apropiado", "total": 5}	{"estado": "Reflexivo", "valor": "Apropiado", "total": 7}	{"estado": "Global", "valor": "Apropiado", "total": 8}
11	105	{"estado": "Sensorial", "valor": "Apropiado", "total": 6}	{"estado": "Visual", "valor": "Apropiado", "total": 7}	{"estado": "Activo", "valor": "Apropiado", "total": 7}	{"estado": "Secuencial", "valor": "Moderado", "total": 9}
12	18	{"estado": "Sensorial", "valor": "Moderado", "total": 9}	{"estado": "Visual", "valor": "Apropiado", "total": 7}	{"estado": "Activo", "valor": "Fuerte", "total": 10}	{"estado": "Secuencial", "valor": "Moderado", "total": 9}
14	120	{"estado": "Sensorial", "valor": "Moderado", "total": 9}	{"estado": "Visual", "valor": "Moderado", "total": 9}	{"estado": "Activo", "valor": "Moderado", "total": 8}	{"estado": "Secuencial", "valor": "Fuerte", "total": 10}
\.


--
-- Data for Name: resultado_quiz_tres; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.resultado_quiz_tres (id, user_id, filantropo, socializador, triunfador, jugador, espiritu_libre, disruptor) FROM stdin;
2	12	0	0	0	0	7.84	0
3	15	0	0	0	0	8.89	0
5	45	0	0	0	0	10.87	0
6	105	0	0	0	0	9.62	0
7	18	0	0	0	0	9.62	0
8	120	0	0	0	0	10.2	0
9	116	0	0	0	0	10.2	0
\.


--
-- Data for Name: tematica; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.tematica (id, nombre) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public."user" (id, nombres, correo, edad, colegio_id, nivel_grados_id, nivel_educativo, rol, anios_experiencia, username, password, institucion, cedula, created_at, last_login) FROM stdin;
15	Jose Luis	hublol58@gmail.com	22	3	\N	Básica	estudiante	1	Jlvallejo	pbkdf2:sha256:600000$ZzefUmlKaK3F08yd$b1ffeed41b3d48be40587dee88044cf86554e96f3d23bf6470d759734d0a70a7	Universidad Antonio Jose Camacho	\N	2025-10-25 15:35:22.045631	2025-10-21 18:54:11.994194
19	James Mauricio Nunez	d.eus.james.nunez@cali.edu.co	49	5	\N	pregrado	docente	15	94487253	pbkdf2:sha256:1000000$LjWwMEriKYjtBe2P$8227e0a01364fed9e0b40acfb31e3d8b04ad27043893cfb634c5936ed9bcb67e	I.E. Eustaquio Palacios	\N	2025-10-25 15:35:22.045631	2025-10-23 01:09:11.994125
20	Ángel David Silva Polo	d.pam.angel.silva@cali.edu.co	32	1	\N	posgrado	docente	8	angeld36	pbkdf2:sha256:1000000$RXFxE0r1SgkgE01B$78afae25dff8b27a88c36431b27fb1b779bd243bae9a4800141d40df2f33aea0	Pedro Antonio Molina	\N	2025-10-25 15:35:22.045631	2025-10-24 06:35:11.994022
21	Indhira Valdés Salazar 	D.cht.indhira.valdes@cali.edu.co	49	1	\N	pregrado	docente	24	Indy	pbkdf2:sha256:1000000$YHErdjTOoPLYoZjP$a04f6481cccec4351e68fca62496f7d7037e7da3e339cd202d8f69ec8786a063	Carlos Holmes Trujillo 	\N	2025-10-25 15:35:22.045631	2025-10-23 13:26:11.993973
22	Jorge Baquero 	investigo@hotmail.com	62	1	\N	secundaria	docente	21	Baquero	pbkdf2:sha256:1000000$0OFu510TCLHWCX58$edd2078c39e96af7383fbf4e4466a70f9674431b9d5bd8272c986ec3698d0517	Nuevo Latir 	\N	2025-10-25 15:35:22.045631	2025-10-21 16:03:11.994092
24	Jhonathan Andrés Belalcázar Zapata	d.pam.jhonathan.belalcazar@cali.edu.co	26	5	\N	secundaria	docente	5	JhonathanB	pbkdf2:sha256:1000000$c79QPMtockATQXeZ$bd0db21c0e39062de6b6b8d471469571d77ed95fa3d95817ce5fa7e5d2ce73e2	IETI Pedro Antonio Molina	\N	2025-10-25 15:35:22.045631	2025-10-24 06:44:11.994059
29	Yadira Ortega	jpto1011@gmail.com	60	5	\N	posgrado	docente	21	yadiraortega	pbkdf2:sha256:1000000$OCdqfxyNmt9j63KN$fae26e6abe2e94ad2c63c8de0fa8c98e75fc378205fba050a52f9957c491c6e0	Eustaquio Palacios	\N	2025-10-25 15:35:22.045631	2025-10-22 23:53:11.994158
120	Yeison Fernando 	gonzalezyeison209@gmail.com	18	5	\N	primaria	docente	1	Yeison Fernando 	pbkdf2:sha256:1000000$q6yrPlh2FftgjYzA$ba2a88848863d33ae6937febeb3927c9cf394eef2bfb3c567024207feb70bf3e	Rafael Navia Varon 	1110367951	2025-10-25 16:49:43.11567	2025-10-25 00:14:11.993937
121	Jhon Alexander Martinez Serrano 	jdecimo2010@gmail.com	54	5	\N	secundaria	docente	28	jdecimo2010	pbkdf2:sha256:1000000$ynfsEwFaOw2WSlZH$dd72f63af54bf41a7f0a07b84e8d150b30d91a31ea9dea0d187eee55035c65b9	La Esperanza 	16790721	2025-10-25 16:56:25.466698	2025-10-23 02:22:11.993725
18	Leidy Administrador	leidy3743@gmail.com	32	\N	\N	Universitaria	admin	9	leidy_admin	pbkdf2:sha256:1000000$LqTLF5emU0OGjd0y$58cdc33e2b7a29b32056172f992655a26dc3d0aab67519e37ffdc8c87bf8e294	Universidad del Valle	1085281803	2025-10-25 15:35:22.045631	2025-10-26 23:52:59.240861
30	Diana Lucia Andrade Ardila	dianalucia3817@gmail.com	46	1	\N	posgrado	docente	14	Di3817	pbkdf2:sha256:1000000$Gsiq7o2sU8nupGth$1a46c11298aeae78bdfc7cbec03a6f67c604fa0ae7c0c815672812daca516d72	IE CIUDAD CORDOBA	\N	2025-10-25 15:35:22.045631	\N
32	María Cirley Ladino Montoya	d.eus.maria.ladino@cali.edu.co	58	1	\N	posgrado	docente	30	Maria	pbkdf2:sha256:1000000$lfoN9wXT0wVb0AEG$c22b703fcb19cc84d2fedd0dcda8289c809ec1966611c3e0385fc2a9fb4e9a76	Eustaquio Palacios	\N	2025-10-25 15:35:22.045631	\N
45	Lucero Stella López Martínez 	d.sfe.lucero.lopez@cali.edu.co	60	1	\N	secundaria	docente	30	lucelo072	pbkdf2:sha256:1000000$DbLYMBMfk6rZwhQH$ffbd022148141eebb0d136304524d9c166529407bebf7fff18526f68b979d813	Santafe	\N	2025-10-25 15:35:22.045631	\N
12	Emerson	emersonalbornozalvarez@gmail.com	21	3	\N	Básica	estudiante	1	Emerson	pbkdf2:sha256:600000$AIaUfReZabps1WW6$ba37cdc41e4160d452c0242142d2b0c35cf23cc01b19e8212c6ec82a0b89b501	Universidad Antonio Jose Camacho	\N	2025-10-25 15:35:22.045631	\N
13	Oscar estiven	ovalle@estudiante.uniajc.edu.co	21	3	\N	Básica	estudiante	1	Oscar Valle	pbkdf2:sha256:600000$WbP1kAE7dzzPubQ8$b9eb3febf23d25c504f6d338edc76e36732c7feb09bfbd633a46584620580033	Universidad Antonio Jose Camacho	\N	2025-10-25 15:35:22.045631	\N
14	HARRY GONGORA	harrigta@gmail.com	21	3	\N	Básica	estudiante	1	hgongora	pbkdf2:sha256:600000$I29Eibpc17OO9bpu$b4906a1da6b40f049d03431f739dd5c033acfae6cd5a8e0379f71c515fc53f1a	Universidad Antonio Jose Camacho	\N	2025-10-25 15:35:22.045631	\N
10	Pedro Amador R	Pedro.amador@correounivalle.edu.co	36	2	\N	Básica	estudiante	1	Pedro	pbkdf2:sha256:600000$7DyQU5DK4cqbpTeD$49a5ad8b4f4bd013f8e857155c13a5dcfdfe1db3c709d8777a2a2875955237b7	Universidad del Valle	\N	2025-10-25 15:35:22.045631	\N
122	Faber Sarmiento Florez 	d.sto.faber.sarmiento@cali.edu.co	62	5	\N	posgrado	docente	15	16270115	pbkdf2:sha256:1000000$bgyw29vuxPfuPkKj$7a168d1be61c80d0326045971cb199af2bea19db7bef5fd509bd3823cd63d9df	I. E Santo Tomás CASD 	16270115	2025-10-26 16:46:52.78425	\N
49	Lenis Eloisa Montaño Ocoro	leniss2528@gmail.com	47	1	\N	secundaria	docente	23	lenis montaño ocoro	pbkdf2:sha256:1000000$UTdwuELqLSQTvLVj$eaaf254186fbd1aa010cb1936542124d796e48ce65650283613a795fec18812c	I.E.Sagrada Familia	\N	2025-10-25 15:35:22.045631	\N
51	Martha Soto	d.pmc.martha.soto@cali.edu.co	48	1	\N	posgrado	docente	20	MarthaLSotoLL	pbkdf2:sha256:1000000$v8ZY40jbvqIOjtHf$785b9676bcfb6f53c3df74e524d4891d90b6fdebf43b8fd7df4ea20219141588	Politécnico Municipal de Cali	\N	2025-10-25 15:35:22.045631	\N
53	Cristian Olivia	d.eus.cristhian.rojas@cali.edu.co	67	1	\N	secundaria	docente	33	41668886	pbkdf2:sha256:1000000$9lez3dXKV5J428UM$872dcbe905c754618c662dde24f315bb3fe61c233780c738688ddc2a1a0e9415	Eustaquio Palacios	\N	2025-10-25 15:35:22.045631	\N
59	JUAN FELIPE TELLO	juan.tello@correounivalle.edu.co	30	1	\N	secundaria	docente	4	juan.tello	pbkdf2:sha256:1000000$6NoMIsnKuLOLjiYz$c4cf0186d404f1b626b9189dfac2a913781b1f9bc186f8f4a32330b7f9ae2144	IETI PEDRO ANTONIO MOLINA	\N	2025-10-25 15:35:22.045631	\N
57	Fabián Aranzazu Giraldo 	d.pmc.fabian.aranzazu@cali.edu.co	46	1	\N	posgrado	docente	15	Fabián	pbkdf2:sha256:1000000$3rlD9MuZjFeFLyIC$1d6c293be62f041635ba84baca71a54cb334e4f172d724ce99b76642ecf21354	Politécnico Municipal de Cali 	\N	2025-10-25 15:35:22.045631	\N
58	Alejandro García Mejía 	ing.agm.1a@gmail.com	46	1	\N	secundaria	docente	10	94527725	pbkdf2:sha256:1000000$nIqsFoByO3aDmd0j$2bdb81db87a2eca30f55a7c1c269ed4f8552c5abafabd588690523049d5ce9cb	Montebello 	\N	2025-10-25 15:35:22.045631	\N
61	Yenni Mina	Yenni.mina@correounivalle.edu.co	46	1	\N	posgrado	docente	17	Yennimina	pbkdf2:sha256:1000000$50sWoV5u8R3uufR4$bfc45ea645c76416223a73ebb3a69d9b0e177b2194b4824bb24d9cf19ffc6975	I.E. Juan Ignacio	\N	2025-10-25 15:35:22.045631	\N
63	Maritza Machado Mosquera	d.sto.maritza.machado@cali.edu.co	18	5	\N	posgrado	docente	22	maritzamachado	pbkdf2:sha256:1000000$HByYQVe6Jsbvd1DB$4428f8a8a2e26316cbfdcd35e299213fadc73f9b69418b52219f104fd7a0ef16	SANTO TOMÁS	\N	2025-10-25 15:35:22.045631	\N
64	Carolina Villamil 	cvillamil@unal.edu.co	47	1	\N	posgrado	docente	47	Cvillamil78	pbkdf2:sha256:1000000$IuTRFf63kYCCyiGc$bdc7b322a0b4f7493cffdfe29127a04385715f23996e80f3adfc2554a57506e7	Gabriel García Márquez 	\N	2025-10-25 15:35:22.045631	\N
65	Jorge Baquero 	d.nla.jorge.baquero@cali.edu.co	62	1	\N	primaria	docente	21	Baquero 	pbkdf2:sha256:1000000$N1gHiNoLbpCdnTaG$f583b1ded79c00280994c0f562fae00b89ee55ba34849e84c1a2882e28cb28f7	Nuevo Latir 	\N	2025-10-25 15:35:22.045631	\N
67	Omar uzuriaga 	Andresuzuriagaocoro@gmail.com	33	1	\N	pregrado	docente	5	Andresuzuriagaocoro@gmail.com	pbkdf2:sha256:1000000$jNYhKZgWLhi2NMnf$493585d7e97df08fbdfcf53a8e916b98fc82a3f0551c12486459bf3721afa908	Colegio Americano 	\N	2025-10-25 15:35:22.045631	\N
69	Anyela Andrea Lasso Petevi	anyiandrealasso@gmail.com	44	1	\N	secundaria	docente	18	29671165	pbkdf2:sha256:1000000$kWKvJ0sSEtKtj9j9$17a6902d65d6b349d8cdaeb246fd14a63f21addb1bcb8031b91ee7280ffc98fb	Eustaquio Palacio	\N	2025-10-25 15:35:22.045631	\N
72	Isabel Alvear	isaacademico21@gmail.com	53	2	\N	posgrado	docente	15	isalba13  	pbkdf2:sha256:1000000$hWUqAeNqF6b2SCLY$256b6fcc04f483372ba48a326de07f874b1a9bb8ab1e72007d4fd7a80b73c3eb	I.E. Juan Ignacio	\N	2025-10-25 15:35:22.045631	\N
75	Alejandro García Mejía 	D.eus.alejandro.garcia@cali.edu.co	46	1	\N	posgrado	docente	10	Ing_Agm	pbkdf2:sha256:1000000$q0P3YA6rx3b2jRA9$3bae05533a0f0b16271ca6d2e7b39b0d92225e70eaa15a201bd6c60b592bc293	Montebello 	\N	2025-10-25 15:35:22.045631	\N
76	Martha Cecilia Motta Garcia	marthamotta.maestra@ietirafaelnaviavaron.edu.co	63	1	\N	posgrado	docente	45	marthacemotta24	pbkdf2:sha256:1000000$dhubcb1en6agJvba$f5c64110868424475d916d9fe25517b26496c46053627c3315f80643ef05ded7	IE Rafael Navia Varón	\N	2025-10-25 15:35:22.045631	\N
77	Johny Romero Prieto 	d.nla.johny.romero@cali.edu.co	59	1	\N	posgrado	docente	17	johnyrom	pbkdf2:sha256:1000000$sFuvCrDCQRhRD3w3$689cecc4338971fd97c8a4e79209d4461ec3fe7b6b6e58c89440c7008cd23617	Nuevo latir sede Isaías Duarte Cancino 	\N	2025-10-25 15:35:22.045631	\N
80	CLARENA COBO VERGARA	d.blg.clarena.cobo@cali.edu.co	52	1	\N	posgrado	docente	26	66853088	pbkdf2:sha256:1000000$jylm1MliCjVcN2RP$60d0e96794fe8fb804e9a7198319fbe83876e80d028c6acf1e6bfc9afa44f24a	Bartolome Loboguerrero	\N	2025-10-25 15:35:22.045631	\N
83	Maritza Machado Mosquera	marymariposa0417@gmail.com	20	5	\N	posgrado	docente	1	marymariposa0417@gmail.com	pbkdf2:sha256:1000000$LVHM4yEAvjxlp2eY$1ed8019bc379efdfff6f45c958b46a68450b2325e70b88dac142d682f87421c1	SANTO TOMÁS	\N	2025-10-25 15:35:22.045631	\N
86	JULIO CESAR VILLAMOR GUTIERREZ	juliocesarvillamor@gmail.com	63	5	\N	secundaria	docente	18	Villamor	pbkdf2:sha256:1000000$DWnEhtAgXOUv2s8i$bd53e55f8a131c6de7241a59d02155aa52ea3f03c03d2a4f07ce9cf7ba867bcf	LAS AMÉRICAS	\N	2025-10-25 15:35:22.045631	\N
90	Zulma Bernarda Pabon Pipicano	zulmapabon.maestra@ietirafaelnaviavaron.edu.co	18	1	\N	secundaria	docente	14	zpabon	pbkdf2:sha256:1000000$KdhljwjguoMmeXRl$6d4f9c92f803521993db463feb8d3a94e0de758739615d68586de0add9387b78	Rafael Navia Varón	\N	2025-10-25 15:35:22.045631	\N
92	Tulia betty barona	Bettycontadora2011@gmail.com	64	1	\N	secundaria	docente	25	Bettyna 	pbkdf2:sha256:1000000$HJmdikFUOJyBMv3a$31bb9545f63493c663853d0212d585e2c1a9c5248423fd92d8b8aedcd4342db3	I.E.T.C LAS AMERICAS	\N	2025-10-25 15:35:22.045631	\N
93	Leonardo 	leonardo.duque.carvajal@gmail.com	48	5	\N	pregrado	docente	5	MatemáticoLDC	pbkdf2:sha256:1000000$CHUXB1C3kKNHrPhh$c662a195fbcf09907a444f397474b4cdc25dde3b2bb243d7f5bccdb99c26dfbe	Univalle	\N	2025-10-25 15:35:22.045631	\N
95	Betty Barona	Bettybarona@ielasamericas.edu.co	65	1	\N	secundaria	docente	25	Bettyna	pbkdf2:sha256:1000000$utNbC9tOtlAxPDwp$a642aa7b45ce39b7c45e82510f38edc9ad55c4e3dbad330e0508626d9bec6eb8	I.E.T.C LAS AMERICAS	\N	2025-10-25 15:35:22.045631	\N
101	Lazarine Rico Ortega	d.nla.lazarine.rico@cali.edu.co	44	5	\N	posgrado	docente	18	lazarinerico	pbkdf2:sha256:1000000$bw5FD48rbCCfKbfz$333930d3506687104af8edef4cb04ee531fee973c1486fc8f84d605ab890b3dc	Nuevo Latir	\N	2025-10-25 15:35:22.045631	\N
102	Gloria Esperanza Nieto Ramirez	gloriaesperanzanietoramirez@gmail.com	57	1	\N	posgrado	docente	19	Glorica	pbkdf2:sha256:1000000$6I1dLRUlIQ6gXUYR$8fe1cf5d329a8cc1f24b8f1f4346720634f2af06a351bcf8c5580c01b4e4f64a	Isaias Gamboa	\N	2025-10-25 15:35:22.045631	\N
103	ANA MILENA RIVAS	d.alv.ana.rivas@cali.edu.co	54	1	\N	secundaria	docente	3	DAVAMI	pbkdf2:sha256:1000000$WFvCTwIny9A8tmM4$67a2cadccccc22606a8093a70dacaa976dfe09bf3e1d75ce7eeb43b776d135e5	ALVARO ECHEVERRY PEREA	\N	2025-10-25 15:35:22.045631	\N
105	Leidy Gómez	leidy-0522@hotmail.com	33	1	\N	secundaria	docente	8	1144053783	pbkdf2:sha256:1000000$jhTcy00OdTvD2WRG$977cd555fbacffcc64d049a87823cd207c584a30fcce9f9436267abc183dd486	IE ALFREDO BONILLA MONTAÑO	\N	2025-10-25 15:35:22.045631	\N
106	John Duran	d.pam.john.duran@cali.edu.co	43	1	\N	secundaria	docente	15	johnferduran	pbkdf2:sha256:1000000$mhZF0zd0KihPaaEN$cff007f43cbeecec617ba6abb3ec176156839f4d6503d6738871d8101699f35b	IETI Pedro Antonio Molina	\N	2025-10-25 15:35:22.045631	\N
111	Wilton Sánchez Hincapié	wilton.sanchez@correounivalle.edu.co	49	5	\N	pregrado	docente	10	94323981	pbkdf2:sha256:1000000$oSJVp5tJGtHhsLoI$45210a45cc87bc1518bdbb79442a8bd653d3cb0dda0466efbba5aadc65e650d0	Fundación Hechos de Vida por ti	\N	2025-10-25 15:35:22.045631	\N
115	PEDRO ANTONIO	d.eus.pedro.bonilla@cali.edu.co	54	1	\N	secundaria	docente	20	16499409	pbkdf2:sha256:1000000$nT528OoufACmR8B4$278a26f6e9d851125349bedff3eb79a46cb187c4b785558c41cd3d8bd751c55e	EUSTAQUIO PALACIOS	\N	2025-10-25 15:35:22.045631	\N
116	pruebas	cgiohidalgo@gmail.com	34	\N	\N	Posgrado	docente	10	pruebas	pbkdf2:sha256:1000000$JkAC9jQ25CE1Q5ww$66a8c3b25e3dae9f23046d4f177147f426d03db51744a5c2c34ccb75fe47569d	prueba	12324234	2025-10-25 15:35:22.045631	2025-10-25 21:36:32.528367
\.


--
-- Data for Name: usuarios_cursos; Type: TABLE DATA; Schema: public; Owner: leidy_user
--

COPY public.usuarios_cursos (user_id, curso_id) FROM stdin;
19	3
19	6
19	5
20	6
21	2
22	6
24	2
29	6
29	3
30	1
30	3
32	1
45	3
49	4
51	3
53	4
57	6
58	2
58	3
59	2
61	2
63	6
64	4
65	6
67	1
67	6
69	1
72	4
75	3
75	2
76	6
77	6
80	1
83	6
86	2
90	1
92	3
93	4
93	2
95	3
101	2
102	4
103	1
105	6
106	4
106	2
111	3
111	2
111	6
115	3
120	1
121	6
122	3
122	6
122	2
\.


--
-- Name: Users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public."Users_id_seq"', 1, false);


--
-- Name: actividad_generada_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.actividad_generada_id_seq', 1, true);


--
-- Name: answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.answer_id_seq', 1, false);


--
-- Name: answer_tres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.answer_tres_id_seq', 1, false);


--
-- Name: asignatura_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.asignatura_id_seq', 5, true);


--
-- Name: colegio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.colegio_id_seq', 6, true);


--
-- Name: configuracion_notificaciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.configuracion_notificaciones_id_seq', 1, true);


--
-- Name: configuracion_sistema_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.configuracion_sistema_id_seq', 11, true);


--
-- Name: curso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.curso_id_seq', 6, true);


--
-- Name: grado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.grado_id_seq', 14, true);


--
-- Name: habilidad_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.habilidad_id_seq', 3, true);


--
-- Name: nivel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.nivel_id_seq', 4, true);


--
-- Name: question_cuatro_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.question_cuatro_id_seq', 1, false);


--
-- Name: question_dos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.question_dos_id_seq', 45, true);


--
-- Name: question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.question_id_seq', 15, true);


--
-- Name: question_tres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.question_tres_id_seq', 12, true);


--
-- Name: quiz_cuatro_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.quiz_cuatro_id_seq', 33, true);


--
-- Name: quiz_result_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.quiz_result_id_seq', 1, false);


--
-- Name: recurso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.recurso_id_seq', 1, false);


--
-- Name: resultado_quiz_cuatro_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.resultado_quiz_cuatro_id_seq', 8, true);


--
-- Name: resultado_quiz_dos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.resultado_quiz_dos_id_seq', 14, true);


--
-- Name: resultado_quiz_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.resultado_quiz_id_seq', 42, true);


--
-- Name: resultado_quiz_tres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.resultado_quiz_tres_id_seq', 9, true);


--
-- Name: tematica_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.tematica_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: leidy_user
--

SELECT pg_catalog.setval('public.user_id_seq', 122, true);


--
-- Name: Users Users_email_key; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key" UNIQUE (email);


--
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);


--
-- Name: Users Users_username_key; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_username_key" UNIQUE (username);


--
-- Name: actividad_generada actividad_generada_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.actividad_generada
    ADD CONSTRAINT actividad_generada_pkey PRIMARY KEY (id);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: answer answer_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_pkey PRIMARY KEY (id);


--
-- Name: answer_tres answer_tres_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.answer_tres
    ADD CONSTRAINT answer_tres_pkey PRIMARY KEY (id);


--
-- Name: asignatura asignatura_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.asignatura
    ADD CONSTRAINT asignatura_pkey PRIMARY KEY (id);


--
-- Name: colegio colegio_nombre_key; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.colegio
    ADD CONSTRAINT colegio_nombre_key UNIQUE (nombre);


--
-- Name: colegio colegio_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.colegio
    ADD CONSTRAINT colegio_pkey PRIMARY KEY (id);


--
-- Name: configuracion_notificaciones configuracion_notificaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.configuracion_notificaciones
    ADD CONSTRAINT configuracion_notificaciones_pkey PRIMARY KEY (id);


--
-- Name: configuracion_sistema configuracion_sistema_clave_key; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.configuracion_sistema
    ADD CONSTRAINT configuracion_sistema_clave_key UNIQUE (clave);


--
-- Name: configuracion_sistema configuracion_sistema_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.configuracion_sistema
    ADD CONSTRAINT configuracion_sistema_pkey PRIMARY KEY (id);


--
-- Name: curso curso_nombre_key; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_nombre_key UNIQUE (nombre);


--
-- Name: curso curso_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.curso
    ADD CONSTRAINT curso_pkey PRIMARY KEY (id);


--
-- Name: grado grado_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.grado
    ADD CONSTRAINT grado_pkey PRIMARY KEY (id);


--
-- Name: grados_dictados grados_dictados_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.grados_dictados
    ADD CONSTRAINT grados_dictados_pkey PRIMARY KEY (user_id, grado_id);


--
-- Name: habilidad habilidad_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.habilidad
    ADD CONSTRAINT habilidad_pkey PRIMARY KEY (id);


--
-- Name: nivel nivel_nombre_key; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.nivel
    ADD CONSTRAINT nivel_nombre_key UNIQUE (nombre);


--
-- Name: nivel nivel_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.nivel
    ADD CONSTRAINT nivel_pkey PRIMARY KEY (id);


--
-- Name: nivel_por_grados nivel_por_grados_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.nivel_por_grados
    ADD CONSTRAINT nivel_por_grados_pkey PRIMARY KEY (user_id, nivel_id);


--
-- Name: question_cuatro question_cuatro_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.question_cuatro
    ADD CONSTRAINT question_cuatro_pkey PRIMARY KEY (id);


--
-- Name: question_dos question_dos_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.question_dos
    ADD CONSTRAINT question_dos_pkey PRIMARY KEY (id);


--
-- Name: question question_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT question_pkey PRIMARY KEY (id);


--
-- Name: question_tres question_tres_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.question_tres
    ADD CONSTRAINT question_tres_pkey PRIMARY KEY (id);


--
-- Name: quiz_cuatro quiz_cuatro_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.quiz_cuatro
    ADD CONSTRAINT quiz_cuatro_pkey PRIMARY KEY (id);


--
-- Name: quiz_result quiz_result_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.quiz_result
    ADD CONSTRAINT quiz_result_pkey PRIMARY KEY (id);


--
-- Name: recurso recurso_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.recurso
    ADD CONSTRAINT recurso_pkey PRIMARY KEY (id);


--
-- Name: resultado_quiz_cuatro resultado_quiz_cuatro_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.resultado_quiz_cuatro
    ADD CONSTRAINT resultado_quiz_cuatro_pkey PRIMARY KEY (id);


--
-- Name: resultado_quiz_cuatro resultado_quiz_cuatro_user_id_key; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.resultado_quiz_cuatro
    ADD CONSTRAINT resultado_quiz_cuatro_user_id_key UNIQUE (user_id);


--
-- Name: resultado_quiz_dos resultado_quiz_dos_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.resultado_quiz_dos
    ADD CONSTRAINT resultado_quiz_dos_pkey PRIMARY KEY (id);


--
-- Name: resultado_quiz_dos resultado_quiz_dos_user_id_key; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.resultado_quiz_dos
    ADD CONSTRAINT resultado_quiz_dos_user_id_key UNIQUE (user_id);


--
-- Name: resultado_quiz resultado_quiz_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.resultado_quiz
    ADD CONSTRAINT resultado_quiz_pkey PRIMARY KEY (id);


--
-- Name: resultado_quiz_tres resultado_quiz_tres_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.resultado_quiz_tres
    ADD CONSTRAINT resultado_quiz_tres_pkey PRIMARY KEY (id);


--
-- Name: resultado_quiz_tres resultado_quiz_tres_user_id_key; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.resultado_quiz_tres
    ADD CONSTRAINT resultado_quiz_tres_user_id_key UNIQUE (user_id);


--
-- Name: resultado_quiz resultado_quiz_user_id_key; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.resultado_quiz
    ADD CONSTRAINT resultado_quiz_user_id_key UNIQUE (user_id);


--
-- Name: tematica tematica_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.tematica
    ADD CONSTRAINT tematica_pkey PRIMARY KEY (id);


--
-- Name: user user_correo_key; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_correo_key UNIQUE (correo);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user user_username_key; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- Name: usuarios_cursos usuarios_cursos_pkey; Type: CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.usuarios_cursos
    ADD CONSTRAINT usuarios_cursos_pkey PRIMARY KEY (user_id, curso_id);


--
-- Name: idx_actividad_user; Type: INDEX; Schema: public; Owner: leidy_user
--

CREATE INDEX idx_actividad_user ON public.actividad_generada USING btree (user_id);


--
-- Name: idx_actividad_user_id; Type: INDEX; Schema: public; Owner: leidy_user
--

CREATE INDEX idx_actividad_user_id ON public.actividad_generada USING btree (user_id);


--
-- Name: idx_answer_question; Type: INDEX; Schema: public; Owner: leidy_user
--

CREATE INDEX idx_answer_question ON public.answer USING btree (question_id);


--
-- Name: idx_answer_user; Type: INDEX; Schema: public; Owner: leidy_user
--

CREATE INDEX idx_answer_user ON public.answer USING btree (user_id);


--
-- Name: idx_answer_user_question; Type: INDEX; Schema: public; Owner: leidy_user
--

CREATE INDEX idx_answer_user_question ON public.answer USING btree (user_id, question_id);


--
-- Name: idx_resultado_quiz_cuatro_user; Type: INDEX; Schema: public; Owner: leidy_user
--

CREATE INDEX idx_resultado_quiz_cuatro_user ON public.resultado_quiz_cuatro USING btree (user_id);


--
-- Name: idx_resultado_quiz_dos_user; Type: INDEX; Schema: public; Owner: leidy_user
--

CREATE INDEX idx_resultado_quiz_dos_user ON public.resultado_quiz_dos USING btree (user_id);


--
-- Name: idx_resultado_quiz_tres_user; Type: INDEX; Schema: public; Owner: leidy_user
--

CREATE INDEX idx_resultado_quiz_tres_user ON public.resultado_quiz_tres USING btree (user_id);


--
-- Name: idx_resultado_quiz_user; Type: INDEX; Schema: public; Owner: leidy_user
--

CREATE INDEX idx_resultado_quiz_user ON public.resultado_quiz USING btree (user_id);


--
-- Name: idx_user_colegio; Type: INDEX; Schema: public; Owner: leidy_user
--

CREATE INDEX idx_user_colegio ON public."user" USING btree (colegio_id);


--
-- Name: idx_user_correo; Type: INDEX; Schema: public; Owner: leidy_user
--

CREATE INDEX idx_user_correo ON public."user" USING btree (correo);


--
-- Name: idx_user_rol; Type: INDEX; Schema: public; Owner: leidy_user
--

CREATE INDEX idx_user_rol ON public."user" USING btree (rol);


--
-- Name: idx_user_rol_colegio; Type: INDEX; Schema: public; Owner: leidy_user
--

CREATE INDEX idx_user_rol_colegio ON public."user" USING btree (rol, colegio_id);


--
-- Name: idx_user_username; Type: INDEX; Schema: public; Owner: leidy_user
--

CREATE INDEX idx_user_username ON public."user" USING btree (username);


--
-- Name: actividad_generada actividad_generada_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.actividad_generada
    ADD CONSTRAINT actividad_generada_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: answer answer_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.question(id);


--
-- Name: answer_tres answer_tres_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.answer_tres
    ADD CONSTRAINT answer_tres_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.question(id);


--
-- Name: answer_tres answer_tres_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.answer_tres
    ADD CONSTRAINT answer_tres_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: answer answer_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: grados_dictados grados_dictados_grado_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.grados_dictados
    ADD CONSTRAINT grados_dictados_grado_id_fkey FOREIGN KEY (grado_id) REFERENCES public.grado(id);


--
-- Name: grados_dictados grados_dictados_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.grados_dictados
    ADD CONSTRAINT grados_dictados_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: nivel_por_grados nivel_por_grados_nivel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.nivel_por_grados
    ADD CONSTRAINT nivel_por_grados_nivel_id_fkey FOREIGN KEY (nivel_id) REFERENCES public.nivel(id);


--
-- Name: nivel_por_grados nivel_por_grados_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.nivel_por_grados
    ADD CONSTRAINT nivel_por_grados_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: quiz_result quiz_result_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.quiz_result
    ADD CONSTRAINT quiz_result_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: resultado_quiz_cuatro resultado_quiz_cuatro_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.resultado_quiz_cuatro
    ADD CONSTRAINT resultado_quiz_cuatro_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: resultado_quiz_dos resultado_quiz_dos_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.resultado_quiz_dos
    ADD CONSTRAINT resultado_quiz_dos_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: resultado_quiz_tres resultado_quiz_tres_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.resultado_quiz_tres
    ADD CONSTRAINT resultado_quiz_tres_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: resultado_quiz resultado_quiz_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.resultado_quiz
    ADD CONSTRAINT resultado_quiz_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: user user_colegio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_colegio_id_fkey FOREIGN KEY (colegio_id) REFERENCES public.colegio(id);


--
-- Name: user user_nivel_grados_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_nivel_grados_id_fkey FOREIGN KEY (nivel_grados_id) REFERENCES public.nivel(id);


--
-- Name: usuarios_cursos usuarios_cursos_curso_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.usuarios_cursos
    ADD CONSTRAINT usuarios_cursos_curso_id_fkey FOREIGN KEY (curso_id) REFERENCES public.curso(id);


--
-- Name: usuarios_cursos usuarios_cursos_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: leidy_user
--

ALTER TABLE ONLY public.usuarios_cursos
    ADD CONSTRAINT usuarios_cursos_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON SEQUENCES TO leidy_user;


--
-- Name: DEFAULT PRIVILEGES FOR TYPES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TYPES TO leidy_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON FUNCTIONS TO leidy_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES TO leidy_user;


--
-- PostgreSQL database dump complete
--

\unrestrict PqlMDxGJPOHX3pEEYfNgkoGW6eGvYZdtvJlsgGPxWiX4TV0ANR9lcepIehfVHkS

