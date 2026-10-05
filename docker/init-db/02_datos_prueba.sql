-- ============================================================
-- SiGeRU — Datos de prueba para visualizar los 4 roles
-- ============================================================
-- Para qué es esto: la base tiene el esquema y (para quien ya la usó)
-- el administrador de arranque, pero ningún dato de negocio — así que
-- los paneles se ven todos vacíos. Este script carga un set de datos
-- de prueba realista y coherente (2 cuadrillas completas, camiones,
-- rutas en distintos estados, contenedores, incidencias y solicitudes
-- pendientes) para que cualquiera del equipo pueda entrar con cada rol
-- y ver algo de verdad en pantalla.
--
-- NO toca la tabla "usuario" existente (tu admin real, cédula
-- 49406116, sigue igual) — solo AGREGA filas nuevas, con cédulas de
-- prueba en el rango 100000001-100000010 (no pisa nada real ni choca
-- con las cédulas 90000xxx que usan los tests unitarios).
--
-- Contraseña de las 8 cuentas de prueba (chofer/jefe/operario), todas
-- iguales para simplificar: Equipo2026!
--
-- Cómo cargarlo:
--   - Contra tu base real (XAMPP/MySQL Workbench): abrí este archivo y
--     ejecutalo entero contra la base SiGeRU (Workbench: File > Open
--     SQL Script > Execute (rayo), o `mysql -u root SiGeRU < datos_prueba.sql`).
--   - Contra Docker: copiá este archivo a docker/init-db/02_datos_prueba.sql
--     (el 02_ es a propósito, para que corra DESPUÉS de code.sql) y
--     volvé a levantar con `docker compose up --build` sobre un volumen
--     nuevo (si el volumen de datos ya existe de una corrida anterior,
--     Docker no vuelve a correr los scripts de init — hay que borrar el
--     volumen con `docker compose down -v` primero).
--
-- Se puede correr una sola vez sobre una base vacía de estos datos —
-- si se corre dos veces, las cédulas/matrículas de prueba van a chocar
-- (es intencional, para no duplicar sin darse cuenta).
-- ============================================================

USE SiGeRU;

START TRANSACTION;

-- ------------------------------------------------------------
-- 1. Personas (usuario + inicioDeSesion) — 2 cuadrillas completas:
--    chofer + jefe de cuadrilla + 2 operarios, por cuadrilla.
-- ------------------------------------------------------------

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario) VALUES
('10000001', 'Martín',    'Silva',      'Camino Cibils',      '2345', NULL, 'martin.silva@sigeru.test',    '099100001', '1988-03-14', 'activo', 'chofer'),
('10000002', 'Lucía',     'Fernández',  'Justicia',           '1290', NULL, 'lucia.fernandez@sigeru.test', '099100002', '1985-07-22', 'activo', 'jefeDeCuadrilla'),
('10000003', 'Bruno',     'Acosta',     'Grecia',             '3410', NULL, 'bruno.acosta@sigeru.test',    '099100003', '1996-01-09', 'activo', 'operarioDeCuadrilla'),
('10000004', 'Valentina', 'Rojas',      'Carlos María Ramírez','870', NULL, 'valentina.rojas@sigeru.test', '099100004', '1994-11-30', 'activo', 'operarioDeCuadrilla'),
('10000005', 'Diego',     'Pereyra',    'Bulevar España',     '2650', '4', 'diego.pereyra@sigeru.test',   '099100005', '1990-05-18', 'activo', 'chofer'),
('10000006', 'Camila',    'Sosa',       'Av. Brasil',         '1980', NULL, 'camila.sosa@sigeru.test',     '099100006', '1987-09-02', 'activo', 'jefeDeCuadrilla'),
('10000007', 'Nicolás',   'Methol',     'Comercio',           '1455', NULL, 'nicolas.methol@sigeru.test',  '099100007', '1998-02-27', 'activo', 'operarioDeCuadrilla'),
('10000008', 'Agustina',  'Bado',       'Rivera',             '5320', NULL, 'agustina.bado@sigeru.test',   '099100008', '1995-06-11', 'activo', 'operarioDeCuadrilla');

INSERT INTO inicioDeSesion (idUsuarioInicioDeSesion, contraseniaUsuarioInicioDeSesion) VALUES
('10000001', '$2y$12$OYGK9T.95E6qmuHAslorOOGtEacKdiYmSpgY227lB1ZlDMgorSHkW'),
('10000002', '$2y$12$OYGK9T.95E6qmuHAslorOOGtEacKdiYmSpgY227lB1ZlDMgorSHkW'),
('10000003', '$2y$12$OYGK9T.95E6qmuHAslorOOGtEacKdiYmSpgY227lB1ZlDMgorSHkW'),
('10000004', '$2y$12$OYGK9T.95E6qmuHAslorOOGtEacKdiYmSpgY227lB1ZlDMgorSHkW'),
('10000005', '$2y$12$OYGK9T.95E6qmuHAslorOOGtEacKdiYmSpgY227lB1ZlDMgorSHkW'),
('10000006', '$2y$12$OYGK9T.95E6qmuHAslorOOGtEacKdiYmSpgY227lB1ZlDMgorSHkW'),
('10000007', '$2y$12$OYGK9T.95E6qmuHAslorOOGtEacKdiYmSpgY227lB1ZlDMgorSHkW'),
('10000008', '$2y$12$OYGK9T.95E6qmuHAslorOOGtEacKdiYmSpgY227lB1ZlDMgorSHkW');

-- operarioDeCuadrilla: idCuadrilla se completa más abajo (la cuadrilla
-- todavía no existe en este punto — dependencia cruzada, igual que en
-- code.sql). licenciaDeConducir solo tiene sentido para los choferes.

INSERT INTO operarioDeCuadrilla (cedulaUsuario, estadoOperarioDeCuadrilla, cargoOperarioDeCuadrilla, turnoOperarioDeCuadrilla, horaInicioOperarioDeCuadrilla, horaFinOperarioDeCuadrilla, licenciaDeConducirOperarioDeCuadrilla, idCuadrilla) VALUES
('10000001', 'activo', 'chofer',              'Mañana', '06:00:00', '14:00:00', 'Categoría D', NULL);
SET @op_chofer1 := LAST_INSERT_ID();

INSERT INTO operarioDeCuadrilla (cedulaUsuario, estadoOperarioDeCuadrilla, cargoOperarioDeCuadrilla, turnoOperarioDeCuadrilla, horaInicioOperarioDeCuadrilla, horaFinOperarioDeCuadrilla, licenciaDeConducirOperarioDeCuadrilla, idCuadrilla) VALUES
('10000002', 'activo', 'jefeDeCuadrilla',     'Mañana', '06:00:00', '14:00:00', NULL, NULL);
SET @op_jefe1 := LAST_INSERT_ID();

INSERT INTO operarioDeCuadrilla (cedulaUsuario, estadoOperarioDeCuadrilla, cargoOperarioDeCuadrilla, turnoOperarioDeCuadrilla, horaInicioOperarioDeCuadrilla, horaFinOperarioDeCuadrilla, licenciaDeConducirOperarioDeCuadrilla, idCuadrilla) VALUES
('10000003', 'activo', 'operarioDeCuadrilla', 'Mañana', '06:00:00', '14:00:00', NULL, NULL);
SET @op_peon1a := LAST_INSERT_ID();

INSERT INTO operarioDeCuadrilla (cedulaUsuario, estadoOperarioDeCuadrilla, cargoOperarioDeCuadrilla, turnoOperarioDeCuadrilla, horaInicioOperarioDeCuadrilla, horaFinOperarioDeCuadrilla, licenciaDeConducirOperarioDeCuadrilla, idCuadrilla) VALUES
('10000004', 'activo', 'operarioDeCuadrilla', 'Mañana', '06:00:00', '14:00:00', NULL, NULL);
SET @op_peon1b := LAST_INSERT_ID();

INSERT INTO operarioDeCuadrilla (cedulaUsuario, estadoOperarioDeCuadrilla, cargoOperarioDeCuadrilla, turnoOperarioDeCuadrilla, horaInicioOperarioDeCuadrilla, horaFinOperarioDeCuadrilla, licenciaDeConducirOperarioDeCuadrilla, idCuadrilla) VALUES
('10000005', 'activo', 'chofer',              'Tarde',  '14:00:00', '22:00:00', 'Categoría D', NULL);
SET @op_chofer2 := LAST_INSERT_ID();

INSERT INTO operarioDeCuadrilla (cedulaUsuario, estadoOperarioDeCuadrilla, cargoOperarioDeCuadrilla, turnoOperarioDeCuadrilla, horaInicioOperarioDeCuadrilla, horaFinOperarioDeCuadrilla, licenciaDeConducirOperarioDeCuadrilla, idCuadrilla) VALUES
('10000006', 'activo', 'jefeDeCuadrilla',     'Tarde',  '14:00:00', '22:00:00', NULL, NULL);
SET @op_jefe2 := LAST_INSERT_ID();

INSERT INTO operarioDeCuadrilla (cedulaUsuario, estadoOperarioDeCuadrilla, cargoOperarioDeCuadrilla, turnoOperarioDeCuadrilla, horaInicioOperarioDeCuadrilla, horaFinOperarioDeCuadrilla, licenciaDeConducirOperarioDeCuadrilla, idCuadrilla) VALUES
('10000007', 'activo', 'operarioDeCuadrilla', 'Tarde',  '14:00:00', '22:00:00', NULL, NULL);
SET @op_peon2a := LAST_INSERT_ID();

INSERT INTO operarioDeCuadrilla (cedulaUsuario, estadoOperarioDeCuadrilla, cargoOperarioDeCuadrilla, turnoOperarioDeCuadrilla, horaInicioOperarioDeCuadrilla, horaFinOperarioDeCuadrilla, licenciaDeConducirOperarioDeCuadrilla, idCuadrilla) VALUES
('10000008', 'activo', 'operarioDeCuadrilla', 'Tarde',  '14:00:00', '22:00:00', NULL, NULL);
SET @op_peon2b := LAST_INSERT_ID();

-- ------------------------------------------------------------
-- 2. Flota — 2 camiones asignados + 1 en mantenimiento, sin chofer
-- ------------------------------------------------------------

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer) VALUES
('STA 1234', 'Iveco', 'Daily', 2019, 'disponible', 8.50, 'Service al día (último: 15/08/2026)', @op_chofer1);
SET @veh1 := LAST_INSERT_ID();

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer) VALUES
('SBH 5678', 'Volkswagen', 'Constellation 24.280', 2021, 'disponible', 12.00, 'Service al día (último: 02/09/2026)', @op_chofer2);
SET @veh2 := LAST_INSERT_ID();

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer) VALUES
('SBK 9012', 'Ford', 'Cargo 1723', 2017, 'en mantenimiento', 10.00, 'En taller por rotura de caja compactadora', NULL);
SET @veh3 := LAST_INSERT_ID();

-- ------------------------------------------------------------
-- 3. Rutas — una en curso, una sin iniciar, una ya finalizada
-- ------------------------------------------------------------

INSERT INTO ruta (zonaRuta, recorridoRuta, frecuenciaDeRecoleccionRuta, horarioRuta, estadoRuta, horaInicioRealRuta, horaFinRealRuta, estadoAdminRuta) VALUES
('Ciudad Vieja', 'Circuito Centro: Ciudad Vieja - Peatonal Sarandí - Mercado del Puerto', 'Diaria', '06:00 - 12:00', 'en curso', DATE_SUB(NOW(), INTERVAL 3 HOUR), NULL, 'activa');
SET @ruta1 := LAST_INSERT_ID();

INSERT INTO ruta (zonaRuta, recorridoRuta, frecuenciaDeRecoleccionRuta, horarioRuta, estadoRuta, horaInicioRealRuta, horaFinRealRuta, estadoAdminRuta) VALUES
('Pocitos', 'Circuito Pocitos: Rambla República del Perú - Bulevar España - Av. Brasil', 'Interdiaria', '14:00 - 20:00', 'sin iniciar', NULL, NULL, 'activa');
SET @ruta2 := LAST_INSERT_ID();

INSERT INTO ruta (zonaRuta, recorridoRuta, frecuenciaDeRecoleccionRuta, horarioRuta, estadoRuta, horaInicioRealRuta, horaFinRealRuta, estadoAdminRuta) VALUES
('Malvín', 'Circuito Malvín - Buceo: Av. Rivera - Av. Italia - Rambla', 'Semanal', '08:00 - 14:00', 'finalizada', DATE_SUB(NOW(), INTERVAL 1 DAY), DATE_SUB(NOW(), INTERVAL 18 HOUR), 'activa');
SET @ruta3 := LAST_INSERT_ID();

-- ------------------------------------------------------------
-- 4. Cuadrillas — arma el vínculo chofer + jefe + camión + ruta, y
--    recién ahora completa el idCuadrilla de cada operario (incluye
--    a los 2 peones de cada una, que no tienen fila propia acá).
-- ------------------------------------------------------------

INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idVehiculo, idRuta, estadoCuadrilla) VALUES
('Cuadrilla Centro', @op_chofer1, @op_jefe1, @veh1, @ruta1, 'activa');
SET @cuadrilla1 := LAST_INSERT_ID();

INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idVehiculo, idRuta, estadoCuadrilla) VALUES
('Cuadrilla Este', @op_chofer2, @op_jefe2, @veh2, @ruta2, 'activa');
SET @cuadrilla2 := LAST_INSERT_ID();

UPDATE operarioDeCuadrilla SET idCuadrilla = @cuadrilla1
    WHERE idOperarioDeCuadrilla IN (@op_chofer1, @op_jefe1, @op_peon1a, @op_peon1b);

UPDATE operarioDeCuadrilla SET idCuadrilla = @cuadrilla2
    WHERE idOperarioDeCuadrilla IN (@op_chofer2, @op_jefe2, @op_peon2a, @op_peon2b);

-- ------------------------------------------------------------
-- 5. Instalaciones — 1 centro de acopio + 1 vertedero, con maquinaria
-- ------------------------------------------------------------

INSERT INTO instalacion (nombreInstalacion, ubicacionInstalacion, capacidadInstalacion, estadoOperativoInstalacion, tipoResiduoInstalacion, latitudInstalacion, longitudInstalacion) VALUES
('Centro de Acopio Cerro', 'Camino Burdeos 1450, Cerro', 500.00, 'operativo', 'Reciclables mixtos', -34.90110000, -56.25400000);
SET @inst_centro := LAST_INSERT_ID();

INSERT INTO instalacion (nombreInstalacion, ubicacionInstalacion, capacidadInstalacion, estadoOperativoInstalacion, tipoResiduoInstalacion, latitudInstalacion, longitudInstalacion) VALUES
('Vertedero Felipe Cardoso', 'Camino Felipe Cardoso s/n', 5000.00, 'operativo', 'Residuos generales', -34.86500000, -56.10800000);
SET @inst_vertedero := LAST_INSERT_ID();

INSERT INTO centroDeAcopio (idInstalacion, clasificacionDeResiduoCentroDeAcopio, capacidadCentroDeAcopio) VALUES
(@inst_centro, 'Papel, cartón, plástico y vidrio', 500.00);

INSERT INTO vertedero (idInstalacion, vidaUtil, tipoDeDispocicionVertedero) VALUES
(@inst_vertedero, '8 años estimados', 'Relleno sanitario controlado');

INSERT INTO maquinaria (tipoDeMaquinaria, estadoMaquinaria, disponibilidadMaquinaria, idInstalacion) VALUES
('Retroexcavadora', 'operativa', 'disponible', @inst_vertedero),
('Compactadora', 'en mantenimiento', 'no disponible', @inst_vertedero),
('Prensa de fardos', 'operativa', 'disponible', @inst_centro);

-- ------------------------------------------------------------
-- 6. Contenedores — variedad de estados, incluye uno de repuesto
--    (sin ubicación todavía, ítem 8+10 del backlog)
-- ------------------------------------------------------------

INSERT INTO contenedor (ubicacionContenedor, estadoContenedor, capacidadContenedor, tipoResiduoContenedor, latitudContenedor, longitudContenedor) VALUES
('18 de Julio 1234, Centro', 'disponible', 1100.00, 'General', -34.90580000, -56.19130000);
SET @cont1 := LAST_INSERT_ID();

INSERT INTO contenedor (ubicacionContenedor, estadoContenedor, capacidadContenedor, tipoResiduoContenedor, latitudContenedor, longitudContenedor) VALUES
('Bulevar España 2650, Pocitos', 'lleno', 1100.00, 'Reciclable', -34.91270000, -56.14890000);
SET @cont2 := LAST_INSERT_ID();

INSERT INTO contenedor (ubicacionContenedor, estadoContenedor, capacidadContenedor, tipoResiduoContenedor, latitudContenedor, longitudContenedor) VALUES
('Rambla República de México 4500, Malvín', 'dañado', 800.00, 'General', -34.89750000, -56.12150000);
SET @cont3 := LAST_INSERT_ID();

INSERT INTO contenedor (ubicacionContenedor, estadoContenedor, capacidadContenedor, tipoResiduoContenedor, latitudContenedor, longitudContenedor) VALUES
('Av. Italia 3200, Buceo', 'disponible', 1100.00, 'Orgánico', -34.90230000, -56.13720000);
SET @cont4 := LAST_INSERT_ID();

INSERT INTO contenedor (ubicacionContenedor, estadoContenedor, capacidadContenedor, tipoResiduoContenedor, latitudContenedor, longitudContenedor) VALUES
('Camino Carrasco 6100, Carrasco', 'disponible', 1100.00, 'General', -34.88050000, -56.05750000);
SET @cont5 := LAST_INSERT_ID();

INSERT INTO contenedor (ubicacionContenedor, estadoContenedor, capacidadContenedor, tipoResiduoContenedor) VALUES
(NULL, 'en depósito', 1100.00, 'General');
SET @cont6 := LAST_INSERT_ID();

-- ------------------------------------------------------------
-- 7. Incidencias — 2 abiertas sin asignar, 1 asignada a una cuadrilla,
--    1 ya resuelta (historial)
-- ------------------------------------------------------------

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla) VALUES
('Contenedor desbordado, acumulación de residuos en la vereda.', 'abierta', 'vecino1@example.com', 'Desborde', 'Pocitos', DATE_SUB(NOW(), INTERVAL 2 DAY), @cont2, NULL);

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla) VALUES
('Contenedor roto, le falta la tapa.', 'asignada', 'vecino2@example.com', 'Daño', 'Malvín', DATE_SUB(NOW(), INTERVAL 1 DAY), @cont3, @cuadrilla2);

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla) VALUES
('Mal olor y presencia de plagas cerca del contenedor.', 'resuelta', NULL, 'Salubridad', 'Centro', DATE_SUB(NOW(), INTERVAL 4 DAY), @cont1, @cuadrilla1);

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla) VALUES
('Retraso reiterado en la recolección de la zona.', 'abierta', NULL, 'Reclamo', 'Carrasco', DATE_SUB(NOW(), INTERVAL 3 HOUR), @cont5, NULL);

-- ------------------------------------------------------------
-- 8. Solicitudes de usuario pendientes — para el módulo "Solicitudes"
--    del panel administrador (aprobar/rechazar)
-- ------------------------------------------------------------

INSERT INTO solicitudDeUsuario (cedulaUsuario, nombreUsuario, apellidoUsuario, direccionCompletaUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, contraseniaSolicitud, rolSolicitado, estadoSolicitud, fechaSolicitud) VALUES
('10000009', 'Rodrigo', 'Núñez', 'Av. Garzón 1800', 'rodrigo.nunez@example.com', '099123456', '1996-04-12', '$2y$12$OYGK9T.95E6qmuHAslorOOGtEacKdiYmSpgY227lB1ZlDMgorSHkW', 'operarioDeCuadrilla', 'pendiente', DATE_SUB(NOW(), INTERVAL 2 DAY));

INSERT INTO solicitudDeUsuario (cedulaUsuario, nombreUsuario, apellidoUsuario, direccionCompletaUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, contraseniaSolicitud, rolSolicitado, estadoSolicitud, fechaSolicitud) VALUES
('10000010', 'Melina', 'Ibarra', 'Bulevar Artigas 2300', 'melina.ibarra@example.com', '098765432', '1993-11-02', '$2y$12$OYGK9T.95E6qmuHAslorOOGtEacKdiYmSpgY227lB1ZlDMgorSHkW', 'chofer', 'pendiente', DATE_SUB(NOW(), INTERVAL 6 HOUR));

COMMIT;

-- ============================================================
-- Listo. Resumen de lo que quedó cargado:
--   - 8 cuentas de funcionario (2 cuadrillas completas), password
--     Equipo2026! para las 8.
--   - 3 camiones (2 asignados, 1 en mantenimiento sin chofer).
--   - 3 rutas (en curso, sin iniciar, finalizada).
--   - 2 cuadrillas activas, cada una con su chofer + jefe + 2 operarios.
--   - 1 centro de acopio + 1 vertedero, con 3 máquinas entre los dos.
--   - 6 contenedores (distintos estados + 1 de repuesto sin ubicación).
--   - 4 incidencias (2 abiertas sin asignar, 1 asignada, 1 resuelta).
--   - 2 solicitudes de cuenta pendientes de aprobar/rechazar.
--
-- Cuentas para probar cada rol:
--   Chofer            -> martin.silva@sigeru.test       / Equipo2026!
--   Jefe de Cuadrilla -> lucia.fernandez@sigeru.test     / Equipo2026!
--   Operario Cuadrilla-> bruno.acosta@sigeru.test        / Equipo2026!
--   (los otros 4 de la Cuadrilla Este funcionan igual)
--   Administrador     -> tu cuenta real ya existente (no se tocó).
-- ============================================================
