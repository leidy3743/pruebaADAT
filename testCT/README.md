# Plataforma ADAT — Guía de uso y administración

Plataforma web en Flask para evaluación de perfiles (ADAT, Estilos de Aprendizaje, Tipo de Jugador, Pensamiento Computacional), generación de actividades con IA, y administración completa de usuarios, tests, resultados y configuración del sistema.


## Características principales

- Autenticación de usuarios con roles (usuario, admin)
- 4 tests integrados:
  - ADAT (Quiz 1)
  - Estilos de Aprendizaje (Quiz 2)
  - Tipo de Jugador (Quiz 3)
  - Pensamiento Computacional (Quiz 4)
- Resultados por usuario con página de resumen “Mis Resultados”
- Generador de actividades con IA (OpenAI), con:
  - Formulario guiado (docente, grado, asignatura, temática, recursos, etc.)
  - Competencias (Abstracción, Descomposición, Pensamiento Algorítmico)
  - Renderizado bonito en web y exportación a Word (formato profesional)
- Persistencia de actividades generadas por usuario (CRUD completo + exportación)
- Exportación a Excel (OpenXML) de usuarios y resultados de tests
- Panel de administración con:
  - Gestión de usuarios (listar, crear, editar, eliminar)
  - Gestión de tests (listar/editar/eliminar preguntas por quiz)
  - Estadísticas (completitud por test, top, demografía, recientes) + exportaciones
  - Configuración del sistema (activar/desactivar módulos, tiempos de tests, registro, mensajes)


## Requisitos

- Python 3.9+
- Clave de API de OpenAI (para el Generador de Actividades)
- Base de datos:
  - Por defecto: SQLite local (`instance/dev.db`)
  - Producción: PostgreSQL (ej. Render) vía `DATABASE_URL`

Dependencias principales (ver `requirements.txt`): Flask, Flask-Login, SQLAlchemy, Flask-Migrate, openai, openpyxl, python-docx, markdown, gunicorn, etc.


## Variables de entorno (.env)

Usa `.env` (no se versiona). Hay un `.env.example` de referencia. Claves relevantes:

- `DATABASE_URL` — URL de conexión a BD
  - Ejemplo Postgres: `postgresql+psycopg://user:password@host:5432/dbname`
  - Desarrollo local (SQLite): `sqlite:///instance/dev.db`
- `OPENAI_API_KEY` — Requerida para el generador con IA
- `SECRET_KEY` — Clave de Flask para sesiones (en producción, cambia el valor)


## Puesta en marcha con Docker (recomendado)

1) Copia `.env.example` a `.env` y rellena valores (al menos `OPENAI_API_KEY`, `DATABASE_URL` si usarás Postgres).

2) Levanta el contenedor:

```sh
docker compose up --build
```

- La app expone el puerto 5002 (http://localhost:5002)
- Se monta `./instance` para persistir la BD SQLite en desarrollo

3) Parar:

```sh
docker compose down
```


## Ejecución local (sin Docker)

1) Crea y activa un entorno virtual e instala dependencias:

```sh
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

2) Configura `.env` (ver sección Variables de Entorno). Si no defines `DATABASE_URL`, se usará SQLite local.

3) Ejecuta:

```sh
python app.py
# o gunicorn (opcional)
# gunicorn -w 2 -k gthread --threads 8 -b 0.0.0.0:5002 app:app
```


## Navegación principal

- Inicio/Dashboard: `/dashboard`
- Tests:
  - ADAT: `/quiz1`
  - Estilos de aprendizaje: `/quiz2`
  - Tipo de jugador: `/quiz3`
  - Pensamiento computacional: `/quiz4`
- Mis Resultados: `/mis_resultados`
- Generador de Actividades: `/select_activities`
- Mis Actividades: `/mis_actividades`
- Perfil: `/profile`


## Módulo: Generador de Actividades (IA)

- Formulario: nombre docente, asignatura, grado, estudiantes, tiempo, recursos, tipo (individual/colaborativo) y competencias.
- Resultado en pantalla con formato (markdown→HTML), exportación a Word.
- Persistencia: toda actividad generada se guarda y puede editarse, verse, eliminarse y exportarse más tarde.

Rutas:
- Generar/ver resultado: `/select_activities` (GET/POST)
- Listado: `/mis_actividades`
- Ver: `/ver_actividad/<id>`
- Editar: `/editar_actividad/<id>`
- Eliminar: `/eliminar_actividad/<id>` (POST)
- Exportar Word (última o por ID): `/exportar_actividad_word[/<id>]`


## Panel de Administración

Acceso desde el menú lateral (solo rol `admin`). Funcionalidades clave:

### Gestión de Usuarios
- Listar: `/gestion_usuarios`
- Crear: `/gestion_usuarios/crear`
- Editar: `/gestion_usuarios/editar/<user_id>`
- Eliminar: `/gestion_usuarios/eliminar/<user_id>` (POST)
- Nota: no se permite que un admin elimine su propio usuario.

### Gestión de Tests
Panel: `/gestion_tests` (resumen de conteos) y vistas por test:
- Quiz 1 (ADAT): `/gestion_tests/quiz1` (editar/eliminar preguntas)
- Quiz 2 (Estilos): `/gestion_tests/quiz2`
- Quiz 3 (Tipo de jugador): `/gestion_tests/quiz3`
- Quiz 4 (Pensamiento): `/gestion_tests/quiz4`

### Estadísticas y Exportaciones
- Vista principal: `/admin/estadisticas` — usuarios totales, completitud por test, top, demografía y recientes.
- Exportar usuarios: `/admin/exportar/usuarios` (Excel)
- Exportar resultados por test: `/admin/exportar/resultados/<quiz>` (Excel)
  - `<quiz>` ∈ {`quiz1`, `quiz2`, `quiz3`, `quiz4`}

### Configuración del Sistema
- Ruta: `/admin/configuracion`
- Cambios se aplican al guardar y afectan UI y acceso para usuarios no admin (admins siempre ven/entran).

Controles disponibles:
- Activar/Desactivar Tests:
  - `quiz1_activo` (ADAT)
  - `quiz2_activo` (Estilos)
  - `quiz3_activo` (Tipo de jugador)
  - `quiz4_activo` (Pensamiento Computacional)
- Tiempos de Tests (min): `tiempo_quiz1`, `tiempo_quiz4`
- Configuración General:
  - `permitir_registro` — permitir nuevos registros
  - `mensaje_bienvenida` — texto de bienvenida
  - `generador_actividades_activo` — controla “Generador de Actividades” y “Mis Actividades”
  - `resultados_activo` — controla “Mis Resultados”
  - `perfil_activo` — controla “Perfil”

Efectos de desactivar un módulo (usuarios no admin):
- El elemento desaparece del menú lateral
- Acceso directo por URL redirige al dashboard con aviso
- Los administradores siempre conservan acceso


## Modelos y persistencia

- Base de datos SQLAlchemy con soporte PostgreSQL/SQLite.
- Tabla `actividad_generada` se autocrea en el arranque si no existe (más un índice por `user_id`).
- El resto de tablas provienen del modelo principal; si inicias un entorno vacío, considera aplicar migraciones (Alembic) según tu flujo.


## Roles y permisos

- Usuario (por defecto): puede realizar los tests, ver sus resultados, generar y gestionar sus propias actividades, editar su perfil.
- Admin: acceso a todas las vistas, panel de administración completo, exportaciones, configuración del sistema, y acceso sin restricciones aunque módulos estén desactivados para el resto.


## Notas de despliegue

- El contenedor usa Gunicorn con 2 workers y 8 threads por worker, timeout 120s (ver `Dockerfile`).
- Pool de SQLAlchemy ajustado para producción en `app.py` (pre-ping, recycle), y timeouts/reintentos para el cliente de OpenAI.
- Para mayor concurrencia, ajusta workers/threads según tu infraestructura.


## Solución de problemas

- “No se ve el botón X en el menú” — Revisa `/admin/configuracion`; probablemente el flag del módulo está desactivado.
- “Acceso denegado a X por URL” — Igual que arriba; los usuarios no admin respetan flags. Admin siempre accede.
- Generador falla — Revisa `OPENAI_API_KEY`. Si la respuesta se demora, el cliente tiene timeout y un reintento.
- Exportar a Word/Excel — Las librerías `python-docx` y `openpyxl` están en `requirements.txt`. En Docker se instalan automáticamente.
- Base de datos — Si no defines `DATABASE_URL`, se usará SQLite local en `instance/dev.db`. En producción, usa Postgres.


## Seguridad y buenas prácticas

- No subas `.env` al repositorio. Usa `.env.example` como plantilla.
- Cambia `SECRET_KEY` en producción.
- Si usas el script `create_admin.py`, revisa/actualiza la URL de BD; está pensada como utilidad puntual y no para producción.


## Licencia

Este proyecto integra Material Dashboard Flask (ver `material-dashboard-flask-master/` y su licencia). Revisa los archivos de licencia incluidos para detalles.
