# Información para Desbloqueo en Fortiguard

## Sitio Web: akila.work
**Categoría correcta:** Education / E-Learning / Learning Platforms

---

## ✅ Mejoras de Seguridad Implementadas

### Headers de Seguridad HTTP
- ✅ **Strict-Transport-Security (HSTS)**: Activo con preload
- ✅ **X-Frame-Options**: SAMEORIGIN
- ✅ **X-Content-Type-Options**: nosniff
- ✅ **X-XSS-Protection**: Activo
- ✅ **Referrer-Policy**: strict-origin-when-cross-origin
- ✅ **Permissions-Policy**: Restricciones de privacidad

### Certificado SSL/TLS
- ✅ **Emisor**: Let's Encrypt (Autoridad Certificadora reconocida)
- ✅ **Válido hasta**: 20 enero 2026
- ✅ **Protocolo**: TLS 1.3 con HTTP/2
- ✅ **Cifrado**: AES_256_GCM_SHA384

### Identificación del Sitio
- ✅ **robots.txt** presente y configurado
- ✅ **Dominio verificado** con Let's Encrypt
- ✅ **Puerto 443** con redirección automática desde HTTP

---

## 📋 Soluciones para Acceso desde Red Corporativa

### Opción 1: Solicitar Recategorización en Fortiguard
**URL de solicitud:** https://www.fortiguard.com/faq/wfratingsubmit

**Información a proporcionar:**
- **URL**: https://akila.work
- **Categoría actual detectada**: [La que muestre Fortiguard]
- **Categoría correcta**: Education / E-Learning
- **Descripción**: "Plataforma educativa ADAT (Análisis de Datos para el Aprendizaje y Tecnología) para evaluación de competencias docentes y estudiantes"
- **Contacto**: admin@akila.work

### Opción 2: Excepciones en FortiGate (Administrador de Red)

**Para el administrador de Fortiguard/FortiGate:**

1. **Agregar a lista blanca (Whitelist)**:
   ```
   Security Profiles > Web Filter > Static URL Filter
   Tipo: Simple
   URL/Dominio: akila.work
   Acción: Allow
   ```

2. **Deshabilitar SSL Inspection para este dominio** (si es necesario):
   ```
   Security Profiles > SSL/SSH Inspection > Exceptions
   Agregar: akila.work
   ```

3. **Modificar categoría local**:
   ```
   Security Profiles > Web Filter > FortiGuard Categories
   Buscar: akila.work
   Override Category: Education
   ```

### Opción 3: Bypass temporal (Usuario final)

**Soluciones temporales mientras se procesa la recategorización:**

1. **Usar red móvil** (hotspot del teléfono) para verificar que el sitio funciona
2. **VPN personal** (si está permitido por políticas de la empresa)
3. **Navegador con certificado de Fortiguard instalado** (solicitar al IT)

---

## 🔍 Verificación de Seguridad del Sitio

### Test SSL Labs
Verificar calificación del certificado SSL:
```
https://www.ssllabs.com/ssltest/analyze.html?d=akila.work
```

### Test de Headers de Seguridad
Verificar headers HTTP:
```
https://securityheaders.com/?q=https://akila.work
```

### Whois del Dominio
```bash
whois akila.work
```

---

## 📞 Contacto para Soporte

**Email**: admin@akila.work  
**Dominio**: https://akila.work  
**Tipo de sitio**: Plataforma educativa institucional  
**Público objetivo**: Docentes y estudiantes  

---

## 🔧 Información Técnica

### Servidor
- **IP**: 161.22.44.243
- **Sistema**: Ubuntu Linux + Nginx 1.24.0
- **Backend**: Python Flask (Puerto 5002)
- **Proxy Reverso**: Nginx

### DNS
```bash
akila.work → 161.22.44.243
www.akila.work → 161.22.44.243
```

### Puertos Abiertos
- **80/TCP**: HTTP (redirige a HTTPS)
- **443/TCP**: HTTPS (TLS 1.3)

---

## 📝 Notas para Administradores de Red

Este sitio es una **plataforma educativa legítima** que cumple con:
- Estándares de seguridad OWASP
- Buenas prácticas de SSL/TLS
- Headers de seguridad recomendados por Mozilla
- Certificado válido de Let's Encrypt

**No representa riesgo de seguridad** y debería estar categorizado como Education/E-Learning.

Si el firewall detecta el sitio como "No seguro", es probablemente debido a:
1. SSL Deep Inspection reemplazando el certificado legítimo
2. Categorización incorrecta inicial del dominio
3. Falta de excepción en las políticas de Web Filter

---

**Fecha de este documento**: Noviembre 1, 2025
**Última actualización de configuración**: Noviembre 1, 2025
