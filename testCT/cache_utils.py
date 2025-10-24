"""
Implementación de caché para catálogos que no cambian frecuentemente
"""
from functools import lru_cache
from datetime import datetime, timedelta

# Cache simple en memoria usando lru_cache de Python
# Para producción considerar Flask-Caching con Redis

# Tiempo de vida del caché en segundos (30 minutos)
CACHE_TIMEOUT = 1800

class SimpleCache:
    """Cache simple basado en diccionario con timestamps y TTL por clave"""
    def __init__(self):
        self._cache = {}
    
    def get(self, key):
        """Obtiene un valor del caché si no ha expirado"""
        if key in self._cache:
            entry = self._cache[key]
            # Compatibilidad hacia atrás: (value, ts) o nuevo formato (value, ts, ttl)
            if len(entry) == 2:
                value, timestamp = entry
                ttl = CACHE_TIMEOUT
            else:
                value, timestamp, ttl = entry
            if datetime.now() - timestamp < timedelta(seconds=ttl):
                return value
            else:
                # Caché expirado, eliminar
                del self._cache[key]
        return None
    
    def set(self, key, value, ttl: int | None = None):
        """Guarda un valor en el caché con timestamp y un TTL opcional (segundos)"""
        ttl_val = ttl if ttl is not None else CACHE_TIMEOUT
        self._cache[key] = (value, datetime.now(), ttl_val)
    
    def delete(self, key):
        if key in self._cache:
            del self._cache[key]
    
    def clear(self):
        """Limpia todo el caché"""
        self._cache.clear()

# Instancia global del caché
app_cache = SimpleCache()

def get_cached_colegios():
    """Retorna lista de colegios desde caché o DB"""
    from models import Colegio
    
    cached = app_cache.get('colegios')
    if cached is not None:
        return cached
    
    # No está en caché, consultar DB
    colegios = Colegio.query.order_by(Colegio.nombre).all()
    app_cache.set('colegios', colegios)
    return colegios

def get_cached_cursos():
    """Retorna lista de cursos desde caché o DB"""
    from models import Curso
    
    cached = app_cache.get('cursos')
    if cached is not None:
        return cached
    
    cursos = Curso.query.order_by(Curso.nombre).all()
    app_cache.set('cursos', cursos)
    return cursos

def get_cached_niveles():
    """Retorna lista de niveles desde caché o DB"""
    from models import Nivel
    
    cached = app_cache.get('niveles')
    if cached is not None:
        return cached
    
    niveles = Nivel.query.order_by(Nivel.nombre).all()
    app_cache.set('niveles', niveles)
    return niveles

def get_cached_grados():
    """Retorna lista de grados desde caché o DB"""
    from models import Grado
    
    cached = app_cache.get('grados')
    if cached is not None:
        return cached
    
    grados = Grado.query.order_by(Grado.nombre).all()
    app_cache.set('grados', grados)
    return grados

def clear_catalogs_cache():
    """Limpia el caché de catálogos (llamar al crear/editar/eliminar)"""
    app_cache.clear()

def cache_get_or_set(key: str, loader, ttl: int | None = None):
    """Obtiene un valor del caché o lo calcula con `loader` y lo guarda.
    - key: clave única del caché
    - loader: función sin argumentos que retorna el valor a cachear
    - ttl: tiempo de vida en segundos (si None toma CACHE_TIMEOUT)
    """
    val = app_cache.get(key)
    if val is not None:
        return val
    data = loader()
    app_cache.set(key, data, ttl=ttl)
    return data

# Ejemplo de uso en app.py:
# 
# from cache_utils import get_cached_colegios, get_cached_cursos, get_cached_niveles, get_cached_grados
# 
# @app.route('/register')
# def register():
#     colegios = get_cached_colegios()  # En lugar de Colegio.query.order_by(...).all()
#     cursos = get_cached_cursos()
#     niveles = get_cached_niveles()
#     grados = get_cached_grados()
#     ...
