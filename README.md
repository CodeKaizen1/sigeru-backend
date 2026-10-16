# sigeru-backend

Las 3 APIs REST de SiGeRU, cada una con su propio MVC (sin framework), hablando con la misma base de datos (`SiGeRU`, ver `01_code.sql`/`docker/init-db/`). Los 3 frontends que las consumen viven en el repo separado `sigeru-frontend`.

## Estructura

- **`api-usuarios/`** — login, registro, recuperación de contraseña, altas/bajas de funcionarios y usuarios.
- **`api-gestion/`** — incidencias, contenedores, notificaciones, informes, y los recursos de "gestión" en general del panel administrador.
- **`api-recoleccion/`** — cuadrillas, rutas, camiones y todo lo relacionado a la recolección en sí.

Cada una es una base de código independiente (su propio `index.php`, MVC y `.env`), sin importar código entre sí — solo comparten la base de datos y, donde hace falta lo mismo dos veces (parseo de `.env`, conexión a MySQL, envío de mails), se duplica el código chico a propósito en vez de compartirlo, el mismo criterio que ya usa `Conexion.php` en las 3.

**Nota conocida, pendiente (punto 28 del plan de auditoría):** el casing de las carpetas internas no es consistente entre las 3 — `api-usuarios` usa `Application/Configuration` (mayúscula inicial), `api-recoleccion` también, pero `api-gestion` usa `application/configuration` (minúscula). Unificarlo implica un rename de carpetas que, en Windows (sistema de archivos que no distingue mayúsculas de minúsculas), necesita un paso intermedio en git para que el cambio de casing se detecte bien — por eso se dejó para una vuelta aparte en vez de resolverlo de pasada.

## Configuración (`.env`)

Cada API tiene su propio archivo de configuración, nunca compartido:

- `api-usuarios/Application/Configuration/` — sin `.env.example` todavía; sin `.env`, `Conexion.php` usa los defaults de XAMPP (`localhost`/`root`/sin contraseña). El envío de mails de "Recuperar contraseña" sí necesita credenciales SMTP reales en un `.env` a mano (ver `Mailer.php` de esta carpeta).
- `api-gestion/configuration/.env.example` — DB + `TURNSTILE_SECRET_KEY` (captcha real del formulario público de incidencia) + SMTP (mail de confirmación opcional de incidencia, descartable).
- `api-recoleccion/Configuration/.env.example` — DB.

Ninguno de los `.env` reales se sube al repositorio (`.gitignore` en la raíz los ignora a cualquier profundidad) — se copian desde su `.env.example` correspondiente y se completan a mano en cada máquina.

## Tests

Cada API tiene su propio `tests/run.php`, con sus propias clases de test (`MiniTest`, sin ningún framework externo). Se corren por separado:

```
cd api-usuarios && php tests/run.php
cd api-gestion && php tests/run.php
cd api-recoleccion && php tests/run.php
```

o los 3 juntos (en procesos separados, porque las 3 APIs declaran las mismas funciones globales en `Utilidades.php` y no pueden convivir en un mismo proceso PHP) con:

```
./tests-correr-todo.sh
```

Necesitan una base real accesible (vía XAMPP o Docker) con el esquema de `01_code.sql` ya cargado.

## Docker

`docker compose up` (ver `docker-compose.yml` en esta raíz) levanta un contenedor Apache+PHP sirviendo las 3 APIs en `http://localhost:8080` y un MySQL 8 con el esquema y datos de prueba ya cargados la primera vez. Copiá `.env.example` (de esta misma carpeta) a `.env` y poné una contraseña real para `MYSQL_ROOT_PASSWORD` antes de levantarlo — `docker compose up` la lee sola.

Los 3 frontends (`landing`, `frontend-usuarios`, `backoffice`) viven en el repo separado `sigeru-frontend`, con su propio Docker.

## Vendorizado (sin Composer)

Las 2 APIs que mandan mails (`api-usuarios` para "Recuperar contraseña", `api-gestion` para la confirmación opcional de incidencia) vendorizan PHPMailer a mano en su propia carpeta `vendor/PHPMailer/` — duplicado a propósito entre ambas, mismo criterio que el resto del proyecto (ver nota de "Estructura" más arriba). No se usa Composer en ningún lado del backend.
