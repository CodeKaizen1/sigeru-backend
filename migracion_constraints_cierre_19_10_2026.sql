-- Migración de UNA SOLA VEZ -- ítem alto de la auditoría de cierre de
-- desarrollo (19/10/2026): agrega del lado de la BASE las reglas que hoy
-- solo garantiza el código de la aplicación (estadoIncidencia/estadoRuta/
-- estadoAdminRuta/estadoCuadrilla solo se escriben con un valor de una
-- lista fija, incidencia.estadoIncidencia/fechaReporte siempre se
-- completan, vehiculo.matriculaVehiculo no se repite). Sirve como segunda
-- línea de defensa: si en el futuro un bug, una migración manual a mano, o
-- una carga de datos directa por fuera de la API dejara algo inconsistente,
-- la base lo rechaza en vez de guardarlo en silencio.
--
-- No hace falta tocar ningún .php para esto -- el backend (ver
-- api-usuarios/Application/Utilidades.php, api-gestion/index.php y los
-- frontends) ya solo manda estos valores, así que ninguna de las
-- restricciones de acá abajo debería afectar el funcionamiento normal.
--
-- CÓMO CORRERLO (una sola vez, contra la base real de XAMPP):
--   1. Abrir phpMyAdmin (o la consola de MySQL) apuntando a la base SiGeRU.
--   2. Pegar y ejecutar este archivo completo.
--   3. Si algún ALTER de acá abajo da error de "Duplicate entry" (lo más
--      probable: el de matriculaVehiculo, si dos vehículos quedaron
--      cargados con la misma matrícula), corregir esa fila a mano primero
--      y volver a correr SOLO esa sentencia.
--
-- Es seguro de ejecutar aunque la base ya tenga datos reales cargados: los
-- UPDATE de más abajo completan cualquier fila vieja que pudiera tener
-- estadoIncidencia/fechaReporte vacíos ANTES de exigir NOT NULL, así nada
-- se rompe por datos ya existentes.

-- ------------------------------------------------------------
-- 1. incidencia: estadoIncidencia y fechaReporte nunca deberían quedar
--    vacíos (ítem alto de la auditoría) -- se completan primero por las
--    dudas, y recién después se exige NOT NULL con el mismo valor por
--    defecto que ya usa el código.
-- ------------------------------------------------------------

UPDATE incidencia SET estadoIncidencia = 'abierta' WHERE estadoIncidencia IS NULL OR estadoIncidencia = '';
UPDATE incidencia SET fechaReporte = NOW() WHERE fechaReporte IS NULL;

ALTER TABLE incidencia
    MODIFY estadoIncidencia VARCHAR(50) NOT NULL DEFAULT 'abierta';

ALTER TABLE incidencia
    MODIFY fechaReporte DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- ------------------------------------------------------------
-- 2. CHECK de los 4 campos "estado" que en el código siempre se escriben
--    de una lista fija (ver TIPOS_INCIDENCIA/estados en
--    backoffice/js/admin/model/config-modulos.js y panel-*.js del
--    frontend) -- acá queda garantizado también del lado de la base.
-- ------------------------------------------------------------

ALTER TABLE incidencia
    ADD CONSTRAINT chk_incidencia_estado
    CHECK (estadoIncidencia IN ('abierta', 'asignada', 'resuelta'));

ALTER TABLE ruta
    ADD CONSTRAINT chk_ruta_estado
    CHECK (estadoRuta IN ('sin iniciar', 'en curso', 'finalizada'));

ALTER TABLE ruta
    ADD CONSTRAINT chk_ruta_estado_admin
    CHECK (estadoAdminRuta IN ('activa', 'baja'));

ALTER TABLE cuadrilla
    ADD CONSTRAINT chk_cuadrilla_estado
    CHECK (estadoCuadrilla IN ('activa', 'baja'));

-- ------------------------------------------------------------
-- 3. vehiculo.matriculaVehiculo: dos vehículos con la misma matrícula sería
--    un error de carga (es la identidad real del camión) -- antes nada lo
--    impedía. NULL sigue permitido (un vehículo recién creado sin
--    matrícula cargada todavía), MySQL permite varios NULL en una columna
--    UNIQUE.
--
--    Antes de correr esta última, si querés confirmar que no hay
--    matrículas repetidas en tu base real, podés correr primero:
--      SELECT matriculaVehiculo, COUNT(*) FROM vehiculo
--      WHERE matriculaVehiculo IS NOT NULL
--      GROUP BY matriculaVehiculo HAVING COUNT(*) > 1;
--    (debería devolver 0 filas)
-- ------------------------------------------------------------

ALTER TABLE vehiculo
    ADD CONSTRAINT uq_vehiculo_matricula
    UNIQUE (matriculaVehiculo);
