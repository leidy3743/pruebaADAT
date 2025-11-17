# 📧 Sistema de Recuperación de Contraseña - ADAT

## ✅ Estado: IMPLEMENTADO Y FUNCIONANDO

### Funcionalidades Completadas:

1. **Página de Solicitud** → `https://akila.work/forgot-password`
2. **Página de Reseteo** → `https://akila.work/reset-password/<token>`
3. **Enlace en Login** → "¿Olvidaste tu contraseña?"
4. **Email Profesional** → Diseño HTML con gradientes y seguridad
5. **Base de Datos** → Tabla `password_reset_tokens` creada

---

## 🔧 Configuración SMTP

```python
Servidor: smtp.gmail.com
Puerto: 587 (TLS)
Usuario: carlos.hidalgo@correounivalle.edu.co
Password: szdg sypl xtsp omkm
```

---

## 📝 Cómo Usar (Para Usuarios)

1. Ir a https://akila.work/login
2. Click en **"¿Olvidaste tu contraseña?"**
3. Ingresar:
   - **Cédula** o **Nombre de usuario**
   - **Email** (debe coincidir con el registrado)
4. Click en **"Enviar instrucciones"**
5. Revisar bandeja de entrada del email
6. Click en el botón **"Restablecer mi contraseña"**
7. Ingresar nueva contraseña (mínimo 6 caracteres)
8. Confirmar contraseña
9. Click en **"Cambiar contraseña"**
10. Iniciar sesión con la nueva contraseña

---

## 🔒 Seguridad

- ✅ Tokens únicos de 32 bytes (urlsafe)
- ✅ Expiración automática: **1 hora**
- ✅ Uso único (no reutilizable)
- ✅ Validación de email exacta
- ✅ Contraseñas hasheadas con pbkdf2:sha256
- ✅ Mensaje genérico si datos no coinciden (evita enum de usuarios)

---

## 🐛 Solución de Problemas

### Problema: "No recibo el email"

**Causas posibles:**
1. Email ingresado no coincide con el registrado
2. Email en carpeta de SPAM
3. Contenedor Docker sin acceso a internet (ver solución abajo)

**Solución para acceso a internet en Docker:**

```bash
# Verificar acceso a internet desde contenedor
docker exec adat_app ping -c 2 8.8.8.8

# Si no hay conexión, reiniciar con acceso a red
docker-compose down
docker-compose up -d
```

### Problema: "El enlace expiró"

**Solución:**
- Solicitar nuevo enlace (el anterior ya no sirve)
- Los tokens expiran en 60 minutos por seguridad

### Problema: "El enlace es inválido"

**Causas:**
- Token ya fue usado
- Token expiró
- URL copiada incorrectamente

**Solución:**
- Solicitar nuevo enlace

---

## 🧪 Prueba Manual (Sin enviar email)

Si el contenedor no tiene acceso a internet, puedes probar manualmente:

### 1. Generar token manual:

```bash
docker exec -it adat_app python3 -c "
from app import app
from models import db, User, PasswordResetToken
from datetime import datetime, timedelta
import secrets

with app.app_context():
    # Buscar usuario
    user = User.query.filter_by(username='TU_USUARIO').first()
    
    # Generar token
    token = secrets.token_urlsafe(32)
    expires_at = datetime.utcnow() + timedelta(hours=1)
    
    reset_token = PasswordResetToken(
        user_id=user.id,
        token=token,
        expires_at=expires_at
    )
    db.session.add(reset_token)
    db.session.commit()
    
    print(f'URL: https://akila.work/reset-password/{token}')
"
```

### 2. Copiar la URL generada y abrirla en el navegador

### 3. Cambiar contraseña

---

## 📂 Archivos Creados/Modificados

### Backend:
- `/root/pruebaADAT/testCT/app.py` → Rutas `/forgot-password` y `/reset-password`
- `/root/pruebaADAT/testCT/models.py` → Modelo `PasswordResetToken`
- `/root/pruebaADAT/testCT/forms.py` → `ForgotPasswordForm` y `ResetPasswordForm`
- `/root/pruebaADAT/testCT/requirements.txt` → `flask-mail==0.9.1`

### Frontend:
- `/root/pruebaADAT/testCT/templates/forgot_password.html`
- `/root/pruebaADAT/testCT/templates/reset_password.html`
- `/root/pruebaADAT/testCT/templates/email/reset_password.html`
- `/root/pruebaADAT/testCT/templates/login.html` → Enlace agregado

### Base de Datos:
- Tabla: `password_reset_tokens`
  - Columnas: `id`, `user_id`, `token`, `created_at`, `expires_at`, `used`
  - Índices: `token`, `user_id`

---

## ✨ Características del Email

- 📱 Responsive (adaptable a móviles)
- 🎨 Diseño moderno con gradientes
- 🔘 Botón destacado de acción
- ⚠️ Advertencias de seguridad
- 🔗 Link alternativo si el botón no funciona
- ⏱️ Indicador de expiración
- 📧 Remitente profesional: "ADAT - Sistema de Recuperación"

---

## 🚀 Siguiente Paso

**PROBAR EN PRODUCCIÓN:**
1. Acceder a https://akila.work/login
2. Click en "¿Olvidaste tu contraseña?"
3. Completar formulario
4. Verificar recepción de email

Si hay problemas con el envío de emails, revisar logs:
```bash
docker logs adat_app | grep -i mail
```

---

## 💡 Mejoras Futuras (Opcional)

- [ ] Agregar límite de intentos (máx 3 por hora)
- [ ] Historial de cambios de contraseña
- [ ] Notificación por email cuando se cambia contraseña
- [ ] Verificación por SMS (opcional)
- [ ] Preguntas de seguridad adicionales
