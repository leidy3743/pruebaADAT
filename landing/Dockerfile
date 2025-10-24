# Base image: Python ligera
FROM python:3.12-alpine

# Crear directorio de trabajo
WORKDIR /app

# Copiar index.html
COPY index.html .

# Exponer el puerto 10000 (puede ser el puerto que Render espera)
EXPOSE 10000

# Comando para servir archivos estáticos
CMD ["python", "-m", "http.server", "10000", "--bind", "0.0.0.0"]
