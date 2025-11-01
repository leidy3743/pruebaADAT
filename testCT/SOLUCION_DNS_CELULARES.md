# 🔧 Solución: ERR_NAME_NOT_RESOLVED en Celulares Android/Chrome

## 🔍 Diagnóstico
El error `ERR_NAME_NOT_RESOLVED` indica que el celular no puede resolver el dominio `akila.work` a una dirección IP.

**Estado del servidor:**
- ✅ DNS funciona correctamente (Google DNS: 8.8.8.8)
- ✅ DNS funciona correctamente (Cloudflare DNS: 1.1.1.1)
- ✅ IP del servidor: 161.22.44.243
- ✅ Dominio: akila.work

---

## 🚀 Soluciones para Usuarios (Celulares)

### Solución 1: Limpiar Caché de Chrome (Más Común)

**En el celular afectado:**

1. Abre Chrome
2. Menú (⋮) → **Configuración**
3. **Privacidad y seguridad**
4. **Borrar datos de navegación**
5. Selecciona:
   - ✅ Cookies y datos de sitios
   - ✅ Imágenes y archivos en caché
6. Rango de tiempo: **Desde siempre**
7. Toca **Borrar datos**
8. Cierra Chrome completamente
9. Vuelve a abrir e intenta acceder a https://akila.work

---

### Solución 2: Configurar DNS Manual en el Celular

**Para Android:**

#### Opción A: DNS sobre WiFi

1. Ve a **Ajustes** → **Wi-Fi**
2. Mantén presionada tu red WiFi → **Modificar red**
3. **Opciones avanzadas** → Mostrar
4. **Configuración IP**: Cambiar a **Estática**
5. En **DNS 1**: `8.8.8.8`
6. En **DNS 2**: `8.8.4.4`
7. Guardar y reconectar

#### Opción B: DNS Privado (Android 9+)

1. Ve a **Ajustes** → **Red e Internet**
2. **DNS privado**
3. Selecciona **Nombre de host del proveedor de DNS privado**
4. Escribe: `dns.google`
5. Guardar
6. Reinicia Chrome

#### Opción C: Datos Móviles

Si estás usando datos móviles:
1. Ve a **Ajustes** → **Conexiones** → **Redes móviles**
2. **Nombres de punto de acceso (APN)**
3. Selecciona tu APN actual
4. En **Servidor DNS**: `8.8.8.8,8.8.4.4`
5. Guardar

---

### Solución 3: Modo Incógnito (Prueba Rápida)

1. Abre Chrome
2. Menú (⋮) → **Nueva pestaña de incógnito**
3. Intenta acceder a https://akila.work

Si funciona en incógnito, el problema es caché o cookies.

---

### Solución 4: Usar la IP Directamente (Temporal)

**Como alternativa temporal:**

Accede directamente por IP: `https://161.22.44.243`

⚠️ **Nota**: El navegador mostrará una advertencia de certificado (porque el certificado SSL es para akila.work, no para la IP). Es seguro continuar para esta prueba.

---

### Solución 5: Cambiar Servidor DNS del Celular con App

**Usando App 1.1.1.1 (Cloudflare):**

1. Instala **1.1.1.1** desde Google Play Store
2. Abre la app
3. Activa el interruptor
4. Intenta acceder a https://akila.work

---

## 🔧 Para el Administrador del Sitio

### Verificar Propagación DNS Global

Verifica que el DNS esté propagado mundialmente:

```bash
# Verificar propagación DNS
curl -s "https://dns.google/resolve?name=akila.work&type=A" | python3 -m json.tool

# O visitar:
# https://www.whatsmydns.net/#A/akila.work
```

### Agregar Registro IPv6 (Opcional)

Si el servidor tiene IPv6, agregar registro AAAA puede ayudar:

```bash
# Verificar si el servidor tiene IPv6
ip -6 addr show | grep inet6 | grep -v "::1\|fe80"
```

### Aumentar TTL del DNS (Si se cambian frecuentemente)

Un TTL muy bajo puede causar problemas de caché:
- Recomendado: 3600 (1 hora) o más
- Verificar TTL actual: `dig akila.work | grep "^akila.work"`

---

## 📊 Diagnóstico Avanzado

### Desde el Celular (Chrome)

1. En Chrome, ir a: `chrome://net-internals/#dns`
2. Click en **Clear host cache**
3. Ir a: `chrome://net-internals/#sockets`
4. Click en **Flush socket pools**
5. Reiniciar Chrome

### Test desde Otro Dispositivo

Para confirmar que no es problema del servidor:
- ✅ Prueba desde otro celular
- ✅ Prueba desde PC
- ✅ Prueba con datos móviles vs WiFi

---

## 🌐 Proveedores de Internet Móvil Problemáticos

Algunos proveedores móviles en Colombia tienen DNS lentos o con problemas:

| Operador | Problema Común | Solución |
|----------|----------------|----------|
| Claro | DNS lento | Usar DNS manual (8.8.8.8) |
| Movistar | Caché DNS antigua | Esperar 24h o cambiar DNS |
| Tigo | Bloqueo de puertos | Verificar puerto 443 |
| WOM | DNS incompleto | Usar Cloudflare DNS |

---

## ✅ Verificación Final

Después de aplicar soluciones, verifica:

1. **Test de Conectividad:**
   - Abre Chrome en el celular
   - Ve a: https://akila.work
   - Debe cargar la página principal

2. **Test de Certificado:**
   - Click en el candado 🔒 en la barra de direcciones
   - Debe mostrar "Conexión segura"
   - Certificado emitido por: Let's Encrypt

3. **Test de Velocidad:**
   - La página debe cargar en menos de 3 segundos
   - Sin errores de recursos bloqueados

---

## 📞 Si Nada Funciona

**Reporte para el usuario:**

Por favor reporta:
1. Modelo del celular y versión de Android
2. Operador móvil (Claro/Movistar/Tigo/etc.)
3. ¿Funciona con WiFi? ¿Funciona con datos móviles?
4. ¿Funciona en modo incógnito?
5. Screenshot del error

**Para soporte técnico:**
- Email: admin@akila.work
- Incluir capturas de pantalla del error

---

## 🔄 Resumen Rápido

**Si el error aparece:**

1. ✅ Borrar caché de Chrome (Solución 1)
2. ✅ Configurar DNS manual 8.8.8.8 (Solución 2)
3. ✅ Probar en modo incógnito (Solución 3)
4. ✅ Usar app 1.1.1.1 (Solución 5)

**Uno de estos debería funcionar en el 99% de los casos.**

---

**Última actualización**: Noviembre 1, 2025
**Estado del servidor**: ✅ Operativo
**DNS**: ✅ Funcionando correctamente
