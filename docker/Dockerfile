# Imagen para correr las 3 APIs de SiGeRU (api-usuarios, api-gestion,
# api-recoleccion) tal como corren hoy en XAMPP: un solo Apache sirviendo
# toda la carpeta como DocumentRoot, asi las 3 APIs comparten la misma
# sesion de PHP sin necesitar nada especial.
FROM php:8.2-apache

RUN docker-php-ext-install pdo_mysql

# El proyecto no usa rutas amigables (?recurso=... en la URL), no hace
# falta mod_rewrite.

# Fase 1 punto 7 de la auditoría 08/10/2026: display_errors=On de fábrica
# en esta imagen expone rutas y consultas SQL crudas ante un error no
# capturado -- ver docker/php.ini.
COPY docker/php.ini /usr/local/etc/php/conf.d/99-sigeru.ini
