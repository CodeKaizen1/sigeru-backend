# Imagen para correr las 3 APIs de SiGeRU (api-usuarios, api-gestion,
# api-recoleccion) tal como corren hoy en XAMPP: un solo Apache sirviendo
# toda la carpeta como DocumentRoot, asi las 3 APIs comparten la misma
# sesion de PHP sin necesitar nada especial.
FROM php:8.2-apache

RUN docker-php-ext-install pdo_mysql

# El proyecto no usa rutas amigables (?recurso=... en la URL), no hace
# falta mod_rewrite.
