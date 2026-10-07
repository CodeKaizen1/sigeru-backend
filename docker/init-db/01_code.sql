-- ============================================================
-- SiGeRU — Esquema de base de datos
-- Alineado 1:1 con los Controllers/Models PHP ya escritos
-- (api usuarios, api gestion, api recoleccion)
-- Generado a partir de las consultas SQL reales de cada Controller,
-- no de un diseño aparte, para que el CRUD ya hecho funcione
-- apenas se cargue esta base.
--
-- Nota: se corrigió el nombre de la base ("SiGuRU" -> "SiGeRU")
-- para que coincida con el nombre del proyecto. Los 3 Conexion.php
-- ya se actualizaron para apuntar acá.
--
-- ACTUALIZACIÓN (cuadrillas, solicitudes de usuario, roles):
-- - "usuario" separa el nombre en nombreUsuario/apellidoUsuario, y
--   suma fechaNacimientoUsuario, estadoUsuario (activo/inactivo) y
--   rolUsuario (para saber, sin tener que revisar las 3 tablas hijas,
--   si es vecino, administrador, operarioDeCuadrilla u
--   operarioDeInstalacion).
-- - Se agrega "solicitudDeUsuario": cuando alguien se registra desde
--   la landing, la solicitud queda acá pendiente hasta que un
--   administrador la aprueba (creando recién ahí la fila real en
--   "usuario") o la rechaza (se guarda igual, no se borra).
-- - Se agrega "cuadrilla": agrupa un chofer (con su camión, 1 a 1),
--   un jefe de cuadrilla, varios operarios y una ruta con su horario.
--   Como "cuadrilla" apunta a "operarioDeCuadrilla" (chofer y jefe) y
--   "operarioDeCuadrilla" apunta de vuelta a "cuadrilla" (a qué
--   cuadrilla pertenece cada uno), es una referencia cruzada: por eso
--   esa columna se agrega recién al final, con ALTER TABLE, una vez
--   que las dos tablas ya existen.
-- - "ruta" suma horarioRuta (antes no existía en ningún lado; el
--   horario va con la ruta completa, no con cada camión).
--
-- Cuando tu compañero suba clases nuevas al repo, comparamos y
-- agregamos las tablas que falten sin tocar lo que ya está.
-- ============================================================

CREATE DATABASE IF NOT EXISTS SiGeRU CHARACTER SET utf8mb4;
USE SiGeRU;

-- ------------------------------------------------------------
-- 1. Usuarios (api usuarios)
-- ------------------------------------------------------------

CREATE TABLE usuario (
    cedulaUsuario VARCHAR(20) PRIMARY KEY,
    nombreUsuario VARCHAR(100) NOT NULL,
    apellidoUsuario VARCHAR(100) NOT NULL,
    calleUsuario VARCHAR(150),
    numeroPuertaUsuario VARCHAR(20),
    numeroApartamentoUsuario VARCHAR(20),
    emailUsuario VARCHAR(150),
    telefonoUsuario VARCHAR(20),
    fechaNacimientoUsuario DATE,
    estadoUsuario VARCHAR(50) DEFAULT 'activo',
    rolUsuario VARCHAR(50)
);

CREATE TABLE inicioDeSesion (
    idUsuarioInicioDeSesion VARCHAR(20) PRIMARY KEY,
    contraseniaUsuarioInicioDeSesion VARCHAR(255) NOT NULL,
    FOREIGN KEY (idUsuarioInicioDeSesion) REFERENCES usuario(cedulaUsuario) ON DELETE CASCADE
);

-- Solicitud de registro pendiente de aprobación. Se completa cuando
-- alguien se registra desde la landing; el administrador la revisa
-- desde su panel de "Solicitudes de usuarios" y recién ahí se crea
-- (o no) la fila definitiva en "usuario".

CREATE TABLE solicitudDeUsuario (
    idSolicitud INT AUTO_INCREMENT PRIMARY KEY,
    cedulaUsuario VARCHAR(20) NOT NULL,
    nombreUsuario VARCHAR(100) NOT NULL,
    apellidoUsuario VARCHAR(100) NOT NULL,
    direccionCompletaUsuario VARCHAR(255),
    emailUsuario VARCHAR(150),
    telefonoUsuario VARCHAR(20),
    fechaNacimientoUsuario DATE,
    contraseniaSolicitud VARCHAR(255) NOT NULL,
    rolSolicitado VARCHAR(50),
    estadoSolicitud VARCHAR(50) DEFAULT 'pendiente',
    fechaSolicitud DATETIME DEFAULT CURRENT_TIMESTAMP,
    motivoRechazo VARCHAR(255),
    -- fechaRechazo (agregada 01/09/2026): el panel de administrador ya
    -- marca cuándo se rechazó una solicitud (rechazarSolicitud(), en el
    -- frontend simulado) - faltaba la columna para guardarlo. Va aparte
    -- de motivoRechazo (que es un texto con el motivo, no una fecha).
    fechaRechazo DATETIME NULL
);

-- Instalacion se crea antes porque operarioDeInstalacion depende de ella
-- (ver sección 3).

CREATE TABLE administradorMunicipal (
    idAdministradorMunicipal INT AUTO_INCREMENT PRIMARY KEY,
    cedulaUsuario VARCHAR(20) NOT NULL,
    correoInstaladorMunicipal VARCHAR(150),
    FOREIGN KEY (cedulaUsuario) REFERENCES usuario(cedulaUsuario) ON DELETE CASCADE
);

CREATE TABLE operarioDeCuadrilla (
    idOperarioDeCuadrilla INT AUTO_INCREMENT PRIMARY KEY,
    cedulaUsuario VARCHAR(20) NOT NULL,
    estadoOperarioDeCuadrilla VARCHAR(50),
    cargoOperarioDeCuadrilla VARCHAR(100),
    turnoOperarioDeCuadrilla VARCHAR(50),
    horaInicioOperarioDeCuadrilla TIME,
    horaFinOperarioDeCuadrilla TIME,
    licenciaDeConducirOperarioDeCuadrilla VARCHAR(50),
    idCuadrilla INT NULL,
    FOREIGN KEY (cedulaUsuario) REFERENCES usuario(cedulaUsuario) ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- 2. Gestión — Instalaciones, contenedores, maquinaria, incidencias
--    (api gestion)
-- ------------------------------------------------------------

CREATE TABLE instalacion (
    idInstalacion INT AUTO_INCREMENT PRIMARY KEY,
    nombreInstalacion VARCHAR(150),
    ubicacionInstalacion VARCHAR(255),
    capacidadInstalacion DECIMAL(10,2),
    estadoOperativoInstalacion VARCHAR(50),
    tipoResiduoInstalacion VARCHAR(100),
    latitudInstalacion DECIMAL(10,8),
    longitudInstalacion DECIMAL(11,8)
);

-- centroDeAcopio, plantaDeProcesamiento y vertedero son sub-tipos de
-- Instalacion (así están escritos los Models PHP, con "extends
-- Instalacion"), así que comparten idInstalacion como PK/FK.

CREATE TABLE centroDeAcopio (
    idInstalacion INT PRIMARY KEY,
    clasificacionDeResiduoCentroDeAcopio VARCHAR(150),
    capacidadCentroDeAcopio DECIMAL(10,2),
    FOREIGN KEY (idInstalacion) REFERENCES instalacion(idInstalacion) ON DELETE CASCADE
);

CREATE TABLE plantaDeProcesamiento (
    idInstalacion INT PRIMARY KEY,
    capacidadPlantaDeProcesamiento DECIMAL(10,2),
    tipoDeProcesoPlantaDeProcesamiento VARCHAR(150),
    FOREIGN KEY (idInstalacion) REFERENCES instalacion(idInstalacion) ON DELETE CASCADE
);

CREATE TABLE vertedero (
    idInstalacion INT PRIMARY KEY,
    vidaUtil VARCHAR(100),
    tipoDeDispocicionVertedero VARCHAR(150),
    FOREIGN KEY (idInstalacion) REFERENCES instalacion(idInstalacion) ON DELETE CASCADE
);

CREATE TABLE operarioDeInstalacion (
    cedulaUsuario VARCHAR(20) PRIMARY KEY,
    turnoOperarioDeInstalacion VARCHAR(50),
    instalacionAsignada INT,
    estadoOperarioDeInstalacion VARCHAR(50),
    cargoOperarioDeInstalacion VARCHAR(100),
    FOREIGN KEY (cedulaUsuario) REFERENCES usuario(cedulaUsuario) ON DELETE CASCADE,
    FOREIGN KEY (instalacionAsignada) REFERENCES instalacion(idInstalacion)
);

CREATE TABLE contenedor (
    idContenedor INT AUTO_INCREMENT PRIMARY KEY,
    ubicacionContenedor VARCHAR(255),
    estadoContenedor VARCHAR(50),
    capacidadContenedor DECIMAL(10,2),
    tipoResiduoContenedor VARCHAR(100)
);

CREATE TABLE maquinaria (
    idMaquinaria INT AUTO_INCREMENT PRIMARY KEY,
    tipoDeMaquinaria VARCHAR(100),
    estadoMaquinaria VARCHAR(50),
    disponibilidadMaquinaria VARCHAR(50),
    idInstalacion INT NULL,
    FOREIGN KEY (idInstalacion) REFERENCES instalacion(idInstalacion)
);

CREATE TABLE incidencia (
    idIncidencia INT AUTO_INCREMENT PRIMARY KEY,
    descripcionIncidencia TEXT,
    estadoIncidencia VARCHAR(50),
    emailResponsableIncidencia VARCHAR(150),
    tipoIncidencia VARCHAR(100),
    zonaIncidencia VARCHAR(150),
    fechaReporte DATETIME,
    idContenedor INT NULL,
    idCuadrilla INT NULL,
    FOREIGN KEY (idContenedor) REFERENCES contenedor(idContenedor)
);

CREATE TABLE tipoResiduo (
    idTipoResiduo INT AUTO_INCREMENT PRIMARY KEY,
    nombreTipoResiduo VARCHAR(100),
    descripcionTipoResiduo VARCHAR(255),
    esReciclableTipoResiduo BOOLEAN DEFAULT FALSE
);

CREATE TABLE residuo (
    idResiduo INT AUTO_INCREMENT PRIMARY KEY,
    pesoResiduo DECIMAL(10,2),
    fechaResiduo DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ------------------------------------------------------------
-- 3. Recolección — Flota, rutas y cuadrillas (api recoleccion)
-- ------------------------------------------------------------

CREATE TABLE vehiculo (
    idVehiculo INT AUTO_INCREMENT PRIMARY KEY,
    matriculaVehiculo VARCHAR(20),
    marcaVehiculo VARCHAR(100),
    modeloVehiculo VARCHAR(100),
    anioVehiculo YEAR,
    disponibilidadVehiculo VARCHAR(50),
    capacidadVehiculo DECIMAL(10,2),
    mantenimientoVehiculo VARCHAR(255),
    -- idChofer (agregado 01/09/2026, confirmado por Matías el mismo día):
    -- el camión y el chofer se pueden crear por separado, pero una vez
    -- asignados van SIEMPRE en conjunto - ese chofer maneja ese camión
    -- hasta que se rompa y haya que reemplazarlo. Por eso el emparejamiento
    -- vive acá (Vehiculo -> operarioDeCuadrilla) y NO en cuadrilla: cuando
    -- a una cuadrilla se le asigna un chofer, indirectamente se le asigna
    -- su camión (se deriva, no se elige aparte).
    --
    -- DECISIÓN YA TOMADA (esta columna es la relación "oficial"):
    -- la columna cuadrilla.idVehiculo que existía acá quedó REDUNDANTE y
    -- ya se eliminó (07/10/2026) -- CuadrillaController.php deriva el
    -- camión de una cuadrilla siempre a partir de este idChofer (JOIN),
    -- nunca de una columna propia en "cuadrilla".
    idChofer INT NULL,
    FOREIGN KEY (idChofer) REFERENCES operarioDeCuadrilla(idOperarioDeCuadrilla)
);

CREATE TABLE ruta (
    idRuta INT AUTO_INCREMENT PRIMARY KEY,
    zonaRuta VARCHAR(150),
    recorridoRuta TEXT,
    frecuenciaDeRecoleccionRuta VARCHAR(100),
    horarioRuta VARCHAR(100),
    -- Las 4 columnas de acá abajo se agregaron el 01/09/2026: el módulo
    -- de Rutas del panel administrador (frontend simulado) ya las usa
    -- todas, pero la base todavía no las tenía.
    --
    -- estadoRuta / horaInicioRealRuta / horaFinRealRuta: seguimiento del
    -- recorrido DE HOY, que marca el chofer desde su panel (botón
    -- "Marcar inicio" / "Marcar fin" - RF de choferes). Son datetime
    -- completos (no solo la hora) porque una ruta se recorre en un día
    -- puntual, no en abstracto.
    estadoRuta VARCHAR(50) DEFAULT 'sin iniciar',
    horaInicioRealRuta DATETIME NULL,
    horaFinRealRuta DATETIME NULL,
    -- estadoAdminRuta: alta/baja ADMINISTRATIVA de la ruta (la maneja el
    -- administrador desde su panel, con "Dar de baja"/"Reactivar") -
    -- deliberadamente separada de estadoRuta de arriba, que es el
    -- seguimiento operativo de hoy y lo marca el chofer, no el admin.
    -- Son dos cosas distintas que conviven en la misma fila.
    estadoAdminRuta VARCHAR(50) DEFAULT 'activa'
);

-- Cuadrilla = 1 chofer (con su camión, 1 a 1) + 1 jefe de cuadrilla +
-- varios operarios (estos últimos se enganchan del lado de
-- operarioDeCuadrilla.idCuadrilla, no acá) + 1 ruta con su horario.
-- idChofer/idJefeCuadrilla apuntan al id propio de operarioDeCuadrilla
-- (no a la cédula), porque un chofer/jefe siempre es, primero, un
-- operarioDeCuadrilla con ese cargo.

CREATE TABLE cuadrilla (
    idCuadrilla INT AUTO_INCREMENT PRIMARY KEY,
    nombreCuadrilla VARCHAR(100),
    idChofer INT NULL,
    idJefeCuadrilla INT NULL,
    idRuta INT NULL,
    -- estadoCuadrilla (agregada 01/09/2026): alta/baja administrativa de
    -- la cuadrilla (el admin la puede dar de baja/reactivar desde su
    -- panel) - el frontend simulado ya la usa, a la base le faltaba.
    estadoCuadrilla VARCHAR(50) DEFAULT 'activa',
    FOREIGN KEY (idChofer) REFERENCES operarioDeCuadrilla(idOperarioDeCuadrilla),
    FOREIGN KEY (idJefeCuadrilla) REFERENCES operarioDeCuadrilla(idOperarioDeCuadrilla),
    FOREIGN KEY (idRuta) REFERENCES ruta(idRuta)
);

-- Referencia cruzada: recién ahora que "cuadrilla" existe podemos
-- conectar operarioDeCuadrilla.idCuadrilla con ella.

ALTER TABLE operarioDeCuadrilla
    ADD CONSTRAINT fk_operario_cuadrilla
    FOREIGN KEY (idCuadrilla) REFERENCES cuadrilla(idCuadrilla);

-- Referencia cruzada: incidencia.idCuadrilla apunta a cuadrilla, que recien
-- se crea en la seccion de Recoleccion (mas abajo), por eso tambien se
-- agrega aca con ALTER TABLE (mismo motivo que la de arriba).
ALTER TABLE incidencia
    ADD CONSTRAINT fk_incidencia_cuadrilla
    FOREIGN KEY (idCuadrilla) REFERENCES cuadrilla(idCuadrilla);

-- ------------------------------------------------------------
-- 4. Reconciliación 01/09/2026 — tablas que el frontend simulado ya
--    necesita y todavía no existían en la base. Se agrupan acá aparte
--    (en vez de metidas en las secciones 1-3 de arriba) para que quede
--    claro qué es de esta vuelta, igual que se hizo con la sección de
--    cuadrillas en su momento.
-- ------------------------------------------------------------

-- (Hasta 07/10/2026 acá existía "cuadrillaOperario", una tabla puente
-- pensada para que una cuadrilla tenga varios operarios rasos (peones)
-- además del chofer y el jefe. Se eliminó: ningún dato real la poblaba
-- -- los operarios rasos ya se enganchan con la cuadrilla directamente
-- por operarioDeCuadrilla.idCuadrilla, la misma columna que usan el
-- panel administrador y todos los datos de prueba. Tener las dos formas
-- de decir "este operario pertenece a esta cuadrilla" a la vez hacía
-- que NotificacionController::cedulaPerteneceACuadrilla() nunca pudiera
-- confirmar la pertenencia de un operario raso, porque consultaba
-- justamente la tabla que nunca se poblaba -- bug de permisos silencioso,
-- ya corregido.)

-- notificacion: la campanita + banner del ítem 13 del backlog. Hoy vive
-- 100% en localStorage (ver crearNotificacionSiGeRU() en
-- almacenamiento-simulado.js) porque no hay backend real conectado -
-- esta tabla es para cuando lo haya. destinatarioTipoNotificacion vale
-- "admin" (idCuadrillaNotificacion queda NULL) o "cuadrilla"
-- (idCuadrillaNotificacion apunta a la cuadrilla avisada).
-- idEntidadNotificacion guarda el id de la incidencia o ruta
-- relacionada (según tipoNotificacion), sin FK propia porque puede
-- apuntar a distintas tablas según el caso (no se modela como FK
-- polimórfica para no complicar el esquema; el Controller que la lea
-- sabe a qué tabla mirar según tipoNotificacion).
CREATE TABLE notificacion (
    idNotificacion INT AUTO_INCREMENT PRIMARY KEY,
    destinatarioTipoNotificacion VARCHAR(20) NOT NULL,
    idCuadrillaNotificacion INT NULL,
    tipoNotificacion VARCHAR(50),
    mensajeNotificacion VARCHAR(255),
    idEntidadNotificacion INT NULL,
    fechaNotificacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    leidaNotificacion BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (idCuadrillaNotificacion) REFERENCES cuadrilla(idCuadrilla)
);

-- passwordReset: recuperar contraseña (ítem 1 del backlog). Hoy, en el
-- frontend simulado, el token vive directo en el registro del usuario
-- (tokenRecuperacion / tokenRecuperacionExpira) porque es más simple
-- para una simulación en localStorage - pero el propio código del
-- frontend deja anotado que en una base real conviene una tabla aparte
-- para no mezclar tokens temporales con los datos permanentes del
-- usuario. Es esta tabla. cedulaUsuario referencia a usuario (no a
-- inicioDeSesion) porque el flujo empieza por el email/cédula, antes de
-- validar ninguna contraseña.
CREATE TABLE passwordReset (
    idPasswordReset INT AUTO_INCREMENT PRIMARY KEY,
    cedulaUsuario VARCHAR(20) NOT NULL,
    tokenPasswordReset VARCHAR(255) NOT NULL,
    expiraPasswordReset DATETIME NOT NULL,
    FOREIGN KEY (cedulaUsuario) REFERENCES usuario(cedulaUsuario) ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- Pendiente / a confirmar con el equipo:
-- - No se creó ninguna tabla de sesión/2FA porque ningún Controller
--   actual la usa. Si en el repo del compañero ya hay lógica de
--   sesión persistente o 2FA, avisen y la sumamos acorde al código
--   real que la use (evitamos crear tablas "de más" que después
--   generan dudas de para qué son).
-- - Tipos de dato (DECIMAL, VARCHAR largo, etc.) son una primera
--   aproximación razonable; se pueden ajustar cuando tengan claro,
--   por ejemplo, si "disponibilidad" va a ser texto o un booleano.
-- - El panel de "Operario de Centro de Acopio" queda afuera de esta
--   vuelta a propósito (todavía no está definido cómo va a ser).
--
-- Pendiente nuevo, de la reconciliación del 01/09/2026 (auditoría
-- completa del frontend simulado contra este esquema):
-- - Camión↔chofer: RESUELTO del todo (07/10/2026) - vehiculo.idChofer es
--   la relación oficial (ver el comentario junto a esa columna, sección
--   3); CuadrillaController.php ya deriva el camión desde el chofer y
--   cuadrilla.idVehiculo se eliminó del esquema.
-- - Vocabulario de rol/cargo: el frontend usa
--   "Chofer"/"Jefe de Cuadrilla"/"Operario de cuadrilla"/etc. en
--   funcionario.rol; el backend tiene cargoOperarioDeCuadrilla /
--   cargoOperarioDeInstalacion como discriminador de subclase (con un
--   vocabulario propio, no confirmado que coincida). Falta una
--   conversión explícita entre los dos cuando se conecten de verdad.
-- - estadoUsuario (en Usuario, la clase base) y
--   estadoOperarioDeCuadrilla/estadoOperarioDeInstalacion (en las
--   subclases) parecen redundantes - el frontend simulado solo tiene UN
--   campo "estado" por funcionario. A confirmar con el equipo si hace
--   falta el estado a los dos niveles o si conviene dejar uno solo.
-- - PlantaDeProcesamiento, TipoResiduo y Residuo ya existen en el
--   backend (Models + tablas) pero el frontend simulado no tiene
--   ninguna pantalla que los use todavía - se dejan como están, sin
--   tocar, hasta que se decida si se arma esa pantalla (ver la lista de
--   mejoras propuestas aparte).
-- - contenedor.incidencias (texto libre en el frontend simulado, ej.
--   "Sin incidencias abiertas") NO se agregó como columna a propósito:
--   ya existe incidencia.idContenedor (FK inversa), que es la forma
--   correcta de derivar esa info sin duplicar datos. Cuando se conecte
--   la API real, ese campo del frontend debería calcularse a partir de
--   esa relación en vez de guardarse aparte.
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- 5. Mapa interactivo (05/10/2026) — entrega final.
-- ------------------------------------------------------------
-- contenedor necesita coordenadas propias para poder mostrarse en el
-- mapa (Leaflet + OpenStreetMap, sin API key). "instalacion" ya tenía
-- latitudInstalacion/longitudInstalacion sin usar desde la 2da entrega;
-- "contenedor" no tenía ninguna columna de coordenadas todavía, solo
-- ubicacionContenedor (texto libre). Se agrega con ALTER TABLE porque
-- la tabla ya existe más arriba (mismo motivo que las ALTER TABLE de la
-- sección de cuadrillas). Ambas columnas quedan NULL-ables: un
-- contenedor sin coordenadas cargadas simplemente no aparece en el
-- mapa, no rompe nada del resto del CRUD.
ALTER TABLE contenedor
    ADD COLUMN latitudContenedor DECIMAL(10,8) NULL,
    ADD COLUMN longitudContenedor DECIMAL(11,8) NULL;

-- ------------------------------------------------------------
-- 6. Índice de coordenadas (05/10/2026) — entrega final.
-- ------------------------------------------------------------
-- Con los ~11.130 contenedores oficiales de la IMM cargados (sección 8 de
-- 02_datos_prueba.sql), el mapa ya no pide obtenerTodos(): pide solo los
-- contenedores dentro del viewport actual (WHERE latitudContenedor BETWEEN
-- ... AND longitudContenedor BETWEEN ...). Sin índice, esa consulta es un
-- table scan completo en cada movimiento del mapa; con 11 mil filas ya se
-- nota. El índice compuesto cubre ambas columnas a la vez.
ALTER TABLE contenedor
    ADD INDEX idx_contenedor_coordenadas (latitudContenedor, longitudContenedor);

-- ------------------------------------------------------------
-- 9. Barrio y municipio de contenedores (06/10/2026) — entrega final.
-- ------------------------------------------------------------
-- Los contenedores oficiales de la IMM (seccion 8 de 02_datos_prueba.sql)
-- solo traian circuito/municipio como codigo, sin direccion de calle ni
-- barrio. Se agregan estas 2 columnas para poder mostrar algo util en el
-- panel de admin (antes "Barrio/zona" quedaba vacio para contenedores).
-- NULL-ables: un contenedor creado a mano desde el panel puede no tenerlos.
ALTER TABLE contenedor
    ADD COLUMN zonaContenedor VARCHAR(100) NULL,
    ADD COLUMN municipioContenedor VARCHAR(20) NULL;

-- ------------------------------------------------------------
-- 10. Rate limiting de login (06/10/2026) — entrega final.
-- ------------------------------------------------------------
-- Antes el endpoint "login" no tenía ningún límite: se podían probar
-- contraseñas sin parar contra el mismo email. Esta tabla guarda cada
-- intento de login FALLIDO (usuario/contraseña incorrectos o cuenta
-- inexistente); el router (index.php) cuenta cuántos hubo para ese email
-- en los últimos N minutos y bloquea el login con 429 si supera el
-- límite, sin necesidad de bloquear la cuenta (se destraba solo cuando
-- esos intentos salen de la ventana de tiempo). No tiene FK a "usuario"
-- a propósito: también se cuentan intentos contra emails que ni
-- siquiera existen (alguien probando direcciones al azar), y esos no
-- tienen fila en "usuario".
CREATE TABLE intentoLoginFallido (
    idIntentoLoginFallido INT AUTO_INCREMENT PRIMARY KEY,
    emailIntentoLoginFallido VARCHAR(150) NOT NULL,
    fechaIntentoLoginFallido DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_intento_login_email_fecha (emailIntentoLoginFallido, fechaIntentoLoginFallido)
);
