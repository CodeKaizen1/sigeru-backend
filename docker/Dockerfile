# Imagen para correr SiGeRU completo (las 3 APIs + los 3 frontends) tal
# como corre hoy en XAMPP: un solo Apache sirviendo toda la carpeta como
# DocumentRoot, así las 3 APIs comparten la misma sesión de PHP sin
# necesitar nada especial.
FROM php:8.2-apache

RUN docker-php-ext-install pdo_mysql

# El proyecto no usa rutas amigables (?recurso=... en la URL), no hace
# falta mod_rewrite.
