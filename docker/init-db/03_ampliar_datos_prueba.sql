-- ============================================================
-- SiGeRU — Ampliar datos de prueba (funcionarios, flota, cuadrillas,
-- instalaciones y incidencias) para poder probar el sistema a fondo
-- ============================================================
-- Para qué es esto: 02_datos_prueba.sql ya carga un set chico (2
-- cuadrillas, 3 camiones, 1 centro de acopio, 1 vertedero, 6
-- contenedores manuales + los ~11.130 oficiales de la IMM, 4
-- incidencias). Esto lo AMPLÍA con bastante más variedad para poder
-- probar a fondo: funcionarios de los 4 roles que la Gestión de
-- Funcionarios del panel administrador soporta hoy (Administrador,
-- Chofer, Jefe de Cuadrilla, Operario de cuadrilla — "Operario de
-- vertedero"/"Operario de centro de acopio" quedan afuera a propósito:
-- hoy ni crearFuncionario ni aprobarSolicitud los aceptan todavía en
-- el backend, es una pantalla sin terminar, no tiene sentido cargar
-- datos para algo que el propio backend rechazaría), camiones,
-- vertederos y centros de acopio adicionales (cada uno con SU PROPIA
-- maquinaria, no mezclada con la de otra instalación), bastantes
-- cuadrillas nuevas (una por municipio de Montevideo) e incidencias de
-- varios tipos y estados.
--
-- NO TOCA nada de lo que ya existe (ni tu admin real, ni los datos de
-- 02_datos_prueba.sql, ni los ~11.130 contenedores oficiales) — solo
-- AGREGA filas nuevas, con cédulas de prueba en el rango
-- 30000001-30000034 (no choca con 10000001-10000010 de
-- 02_datos_prueba.sql, ni con 90000xxx de los tests unitarios, ni con
-- cédulas reales).
--
-- Contraseña de las 34 cuentas nuevas: la misma que ya usan las 8 de
-- 02_datos_prueba.sql, para no tener que anotar credenciales nuevas:
-- Equipo2026!
--
-- IDEMPOTENTE: se puede correr más de una vez sin duplicar nada ni
-- romper por clave repetida — cada INSERT valida con
-- "WHERE NOT EXISTS (...)" antes de insertar (mismo patrón que
-- agregar_rutas_recoleccion.sql). Si ya corriste esto antes, volver a
-- correrlo no cambia nada.
--
-- Cómo cargarlo (igual que los otros scripts sueltos del proyecto):
--   - Contra tu base real (XAMPP/MySQL Workbench): abrí este archivo y
--     ejecutalo entero contra la base SiGeRU (Workbench: File > Open
--     SQL Script > Execute (rayo), o `mysql -u root SiGeRU < ampliar_datos_prueba.sql`).
--   - Requiere haber corrido antes 01_code.sql (esquema) y
--     02_datos_prueba.sql (usa varias de sus rutas/cuadrillas como base).
-- ============================================================

USE SiGeRU;

-- ------------------------------------------------------------
-- 1. Funcionarios nuevos — 2 administradores, 8 choferes, 8 jefes de
--    cuadrilla y 16 operarios (2 por cada una de las 8 cuadrillas
--    nuevas de la sección 4).
-- ------------------------------------------------------------

-- usuario (34 filas, una por cada cédula 30000001-30000034)
INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT
    '30000001' AS cedulaUsuario, 'Patricia' AS nombreUsuario, 'Núñez' AS apellidoUsuario, 'Blandengues' AS calleUsuario, '1120' AS numeroPuertaUsuario, NULL AS numeroApartamentoUsuario, 'patricia.nunez@sigeru.test' AS emailUsuario, '099200001' AS telefonoUsuario, '1979-04-02' AS fechaNacimientoUsuario, 'activo' AS estadoUsuario, 'administrador' AS rolUsuario
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000001');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000002', 'Gonzalo', 'Ferreira', 'Durazno', '980', NULL, 'gonzalo.ferreira@sigeru.test', '099200002', '1982-11-19', 'activo', 'administrador'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000002');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000003', 'Walter', 'Suárez', 'Propios', '1455', NULL, 'walter.suarez@sigeru.test', '099200003', '1985-02-11', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000003');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000004', 'Esteban', 'Correa', 'Cerro Largo', '2240', NULL, 'esteban.correa@sigeru.test', '099200004', '1983-06-23', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000004');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000005', 'Fabián', 'Olivera', 'Industria', '3310', NULL, 'fabian.olivera@sigeru.test', '099200005', '1990-09-05', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000005');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000006', 'Marcelo', 'Techera', 'Garibaldi', '1870', NULL, 'marcelo.techera@sigeru.test', '099200006', '1987-01-17', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000006');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000007', 'Rubén', 'Castro', 'Burdeos', '2890', NULL, 'ruben.castro@sigeru.test', '099200007', '1981-12-29', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000007');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000008', 'Pablo', 'Lima', 'Carlos Roxlo', '640', NULL, 'pablo.lima@sigeru.test', '099200008', '1992-03-08', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000008');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000009', 'Sergio', 'Méndez', 'Lucas Obes', '1130', NULL, 'sergio.mendez@sigeru.test', '099200009', '1986-07-14', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000009');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000010', 'Daniel', 'Viera', 'Guayabos', '2015', NULL, 'daniel.viera@sigeru.test', '099200010', '1984-10-21', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000010');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000011', 'Carolina', 'Paz', 'Ellauri', '1240', NULL, 'carolina.paz@sigeru.test', '099200011', '1988-05-30', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000011');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000012', 'Soledad', 'Ramos', 'Grecia', '3980', NULL, 'soledad.ramos@sigeru.test', '099200012', '1991-02-16', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000012');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000013', 'Fernanda', 'Castro', 'Carlos María Ramírez', '1560', NULL, 'fernanda.castro@sigeru.test', '099200013', '1989-08-09', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000013');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000014', 'Gabriela', 'Muñoz', 'Rivera', '4120', NULL, 'gabriela.munoz@sigeru.test', '099200014', '1993-04-27', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000014');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000015', 'Verónica', 'Díaz', 'Comercio', '870', NULL, 'veronica.diaz@sigeru.test', '099200015', '1986-12-03', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000015');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000016', 'Natalia', 'Pintos', 'Av. Garzón', '2670', NULL, 'natalia.pintos@sigeru.test', '099200016', '1990-06-19', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000016');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000017', 'Mariana', 'Cabrera', 'Jacinto Vera', '1340', NULL, 'mariana.cabrera@sigeru.test', '099200017', '1984-09-24', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000017');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000018', 'Leticia', 'Gómez', 'Chucarro', '960', NULL, 'leticia.gomez@sigeru.test', '099200018', '1992-01-13', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000018');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000019', 'Jonathan', 'Silveira', 'Larrañaga', '1680', NULL, 'jonathan.silveira@sigeru.test', '099200019', '1997-03-11', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000019');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000020', 'Ayelén', 'Flores', 'Garibaldi', '2230', NULL, 'ayelen.flores@sigeru.test', '099200020', '1998-07-06', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000020');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000021', 'Maximiliano', 'Rodríguez', 'Carlos Ma. de Pena', '1100', NULL, 'maximiliano.rodriguez@sigeru.test', '099200021', '1995-11-02', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000021');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000022', 'Yamila', 'Barboza', 'Pedro Bustamante', '540', NULL, 'yamila.barboza@sigeru.test', '099200022', '1999-04-15', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000022');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000023', 'Braian', 'Coronel', 'Camino Maldonado', '7820', NULL, 'braian.coronel@sigeru.test', '099200023', '1994-02-28', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000023');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000024', 'Florencia', 'Aguirre', 'Camino Carrasco', '6480', NULL, 'florencia.aguirre@sigeru.test', '099200024', '1996-08-19', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000024');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000025', 'Ezequiel', 'Larrosa', 'Centenario', '1930', NULL, 'ezequiel.larrosa@sigeru.test', '099200025', '1993-10-07', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000025');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000026', 'Daiana', 'Techera', 'Centenario', '2015', NULL, 'daiana.techera@sigeru.test', '099200026', '1997-12-24', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000026');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000027', 'Facundo', 'Pereira', 'Av. San Martín', '3310', NULL, 'facundo.pereira@sigeru.test', '099200027', '1995-05-05', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000027');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000028', 'Rocío', 'Bentancor', 'Burgues', '1240', NULL, 'rocio.bentancor@sigeru.test', '099200028', '1998-09-13', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000028');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000029', 'Lucas', 'Machado', 'Camino Castro', '2240', NULL, 'lucas.machado@sigeru.test', '099200029', '1994-01-30', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000029');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000030', 'Micaela', 'Sosa', 'Bulevar Artigas', '1870', NULL, 'micaela.sosa@sigeru.test', '099200030', '1999-06-22', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000030');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000031', 'Ignacio', 'Pereyra', 'Camino Corrales', '3980', NULL, 'ignacio.pereyra@sigeru.test', '099200031', '1996-03-17', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000031');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000032', 'Brenda', 'Ortiz', 'Camino Corrales', '4020', NULL, 'brenda.ortiz@sigeru.test', '099200032', '1998-11-11', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000032');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000033', 'Franco', 'Delgado', 'Av. Sarmiento', '1450', NULL, 'franco.delgado@sigeru.test', '099200033', '1995-08-04', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000033');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000034', 'Ana Laura', 'Juncal', 'Av. Sarmiento', '1510', NULL, 'analaura.juncal@sigeru.test', '099200034', '1997-10-26', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000034');

-- inicioDeSesion para las 34 cuentas (mismo hash que 02_datos_prueba.sql: Equipo2026!)
INSERT INTO inicioDeSesion (idUsuarioInicioDeSesion, contraseniaUsuarioInicioDeSesion)
SELECT u.cedulaUsuario, '$2y$12$OYGK9T.95E6qmuHAslorOOGtEacKdiYmSpgY227lB1ZlDMgorSHkW'
FROM usuario u
WHERE u.cedulaUsuario BETWEEN '30000001' AND '30000034'
  AND NOT EXISTS (SELECT 1 FROM inicioDeSesion s WHERE s.idUsuarioInicioDeSesion = u.cedulaUsuario);

-- administradorMunicipal para los 2 administradores nuevos
INSERT INTO administradorMunicipal (cedulaUsuario, correoInstaladorMunicipal)
SELECT u.cedulaUsuario, u.emailUsuario
FROM usuario u
WHERE u.cedulaUsuario IN ('30000001', '30000002')
  AND NOT EXISTS (SELECT 1 FROM administradorMunicipal a WHERE a.cedulaUsuario = u.cedulaUsuario);

-- operarioDeCuadrilla para choferes/jefes/operarios (cargo = mismo valor que rolUsuario,
-- igual que hace crearPersonaConRol() en api-usuarios/index.php). idCuadrilla se completa
-- en la sección 4, una vez que las cuadrillas nuevas existen.
INSERT INTO operarioDeCuadrilla (cedulaUsuario, estadoOperarioDeCuadrilla, cargoOperarioDeCuadrilla, turnoOperarioDeCuadrilla, horaInicioOperarioDeCuadrilla, horaFinOperarioDeCuadrilla, licenciaDeConducirOperarioDeCuadrilla, idCuadrilla)
SELECT u.cedulaUsuario, 'activo', u.rolUsuario,
       IF(u.cedulaUsuario IN ('30000003','30000005','30000007','30000009','30000011','30000013','30000015','30000017','30000019','30000021','30000023','30000025','30000027','30000029','30000031','30000033'), 'Mañana', 'Tarde'),
       IF(u.cedulaUsuario IN ('30000003','30000005','30000007','30000009','30000011','30000013','30000015','30000017','30000019','30000021','30000023','30000025','30000027','30000029','30000031','30000033'), '06:00:00', '14:00:00'),
       IF(u.cedulaUsuario IN ('30000003','30000005','30000007','30000009','30000011','30000013','30000015','30000017','30000019','30000021','30000023','30000025','30000027','30000029','30000031','30000033'), '14:00:00', '22:00:00'),
       IF(u.rolUsuario = 'chofer', 'Categoría D', NULL),
       NULL
FROM usuario u
WHERE u.cedulaUsuario BETWEEN '30000003' AND '30000034'
  AND NOT EXISTS (SELECT 1 FROM operarioDeCuadrilla o WHERE o.cedulaUsuario = u.cedulaUsuario);

-- ------------------------------------------------------------
-- 2. Flota nueva — 8 camiones para los 8 choferes nuevos + 2 idle
--    (sin chofer, para variedad: uno disponible de repuesto, otro en
--    mantenimiento) = 10 camiones nuevos.
-- ------------------------------------------------------------

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2201', 'Iveco', 'Tector 170', 2020, 'disponible', 9.00, 'Service al día (último: 20/08/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000003')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2201');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2202', 'Volkswagen', 'Delivery Express', 2018, 'disponible', 6.50, 'Service al día (último: 03/07/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000004')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2202');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2203', 'Ford', 'Cargo 1119', 2019, 'disponible', 8.00, 'Service al día (último: 11/06/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000005')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2203');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2204', 'Iveco', 'Daily', 2021, 'disponible', 8.50, 'Service al día (último: 28/08/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000006')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2204');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2205', 'Volkswagen', 'Constellation 17.280', 2017, 'en mantenimiento', 11.00, 'En taller por falla de frenos',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000007')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2205');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2206', 'Ford', 'Cargo 1723', 2016, 'disponible', 10.00, 'Service al día (último: 02/05/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000008')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2206');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2207', 'Iveco', 'Tector 170', 2022, 'disponible', 9.00, 'Service al día (último: 14/08/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000009')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2207');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2208', 'Volkswagen', 'Delivery Express', 2020, 'disponible', 6.50, 'Service al día (último: 19/07/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000010')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2208');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2209', 'Ford', 'Cargo 1119', 2015, 'disponible', 8.00, 'Camión de repuesto, sin chofer asignado todavía', NULL
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2209');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2210', 'Iveco', 'Daily', 2014, 'fuera de servicio', 8.50, 'Dado de baja temporalmente por rotura de motor', NULL
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2210');

-- ------------------------------------------------------------
-- 3. Instalaciones nuevas — 2 centros de acopio + 2 vertederos más
--    (total 3 de cada uno con 02_datos_prueba.sql), cada uno con SU
--    PROPIA maquinaria (no comparten con la de otra instalación).
-- ------------------------------------------------------------

INSERT INTO instalacion (nombreInstalacion, ubicacionInstalacion, capacidadInstalacion, estadoOperativoInstalacion, tipoResiduoInstalacion, latitudInstalacion, longitudInstalacion)
SELECT 'Centro de Acopio Pocitos', 'Av. Brasil 2480, Pocitos', 320.00, 'operativo', 'Reciclables mixtos', -34.91500000, -56.15700000
WHERE NOT EXISTS (SELECT 1 FROM instalacion WHERE nombreInstalacion = 'Centro de Acopio Pocitos');
SET @inst_centro_pocitos := (SELECT idInstalacion FROM instalacion WHERE nombreInstalacion = 'Centro de Acopio Pocitos');

INSERT INTO instalacion (nombreInstalacion, ubicacionInstalacion, capacidadInstalacion, estadoOperativoInstalacion, tipoResiduoInstalacion, latitudInstalacion, longitudInstalacion)
SELECT 'Centro de Acopio Carrasco', 'Camino Carrasco 6250, Carrasco', 280.00, 'operativo', 'Papel y plástico', -34.87900000, -56.05200000
WHERE NOT EXISTS (SELECT 1 FROM instalacion WHERE nombreInstalacion = 'Centro de Acopio Carrasco');
SET @inst_centro_carrasco := (SELECT idInstalacion FROM instalacion WHERE nombreInstalacion = 'Centro de Acopio Carrasco');

INSERT INTO instalacion (nombreInstalacion, ubicacionInstalacion, capacidadInstalacion, estadoOperativoInstalacion, tipoResiduoInstalacion, latitudInstalacion, longitudInstalacion)
SELECT 'Vertedero Melilla', 'Camino Melilla s/n, Melilla', 4200.00, 'operativo', 'Residuos generales', -34.78500000, -56.32500000
WHERE NOT EXISTS (SELECT 1 FROM instalacion WHERE nombreInstalacion = 'Vertedero Melilla');
SET @inst_vertedero_melilla := (SELECT idInstalacion FROM instalacion WHERE nombreInstalacion = 'Vertedero Melilla');

INSERT INTO instalacion (nombreInstalacion, ubicacionInstalacion, capacidadInstalacion, estadoOperativoInstalacion, tipoResiduoInstalacion, latitudInstalacion, longitudInstalacion)
SELECT 'Vertedero Las Rosas', 'Camino Las Rosas s/n, Manga', 3100.00, 'en proceso de cierre', 'Residuos generales', -34.79800000, -56.14300000
WHERE NOT EXISTS (SELECT 1 FROM instalacion WHERE nombreInstalacion = 'Vertedero Las Rosas');
SET @inst_vertedero_lasrosas := (SELECT idInstalacion FROM instalacion WHERE nombreInstalacion = 'Vertedero Las Rosas');

INSERT INTO centroDeAcopio (idInstalacion, clasificacionDeResiduoCentroDeAcopio, capacidadCentroDeAcopio)
SELECT @inst_centro_pocitos, 'Papel, cartón, plástico y vidrio', 320.00
WHERE NOT EXISTS (SELECT 1 FROM centroDeAcopio WHERE idInstalacion = @inst_centro_pocitos);

INSERT INTO centroDeAcopio (idInstalacion, clasificacionDeResiduoCentroDeAcopio, capacidadCentroDeAcopio)
SELECT @inst_centro_carrasco, 'Papel y plástico', 280.00
WHERE NOT EXISTS (SELECT 1 FROM centroDeAcopio WHERE idInstalacion = @inst_centro_carrasco);

INSERT INTO vertedero (idInstalacion, vidaUtil, tipoDeDispocicionVertedero)
SELECT @inst_vertedero_melilla, '12 años estimados', 'Relleno sanitario controlado'
WHERE NOT EXISTS (SELECT 1 FROM vertedero WHERE idInstalacion = @inst_vertedero_melilla);

INSERT INTO vertedero (idInstalacion, vidaUtil, tipoDeDispocicionVertedero)
SELECT @inst_vertedero_lasrosas, '1 año estimado (en cierre)', 'Relleno sanitario en etapa de clausura'
WHERE NOT EXISTS (SELECT 1 FROM vertedero WHERE idInstalacion = @inst_vertedero_lasrosas);

-- Maquinaria propia de cada instalación nueva (nunca mezclada con la de otra).
INSERT INTO maquinaria (tipoDeMaquinaria, estadoMaquinaria, disponibilidadMaquinaria, idInstalacion)
SELECT 'Prensa de fardos (Centro Pocitos)', 'operativa', 'disponible', @inst_centro_pocitos
WHERE NOT EXISTS (SELECT 1 FROM maquinaria WHERE tipoDeMaquinaria = 'Prensa de fardos (Centro Pocitos)' AND idInstalacion = @inst_centro_pocitos);

INSERT INTO maquinaria (tipoDeMaquinaria, estadoMaquinaria, disponibilidadMaquinaria, idInstalacion)
SELECT 'Cinta transportadora (Centro Pocitos)', 'operativa', 'disponible', @inst_centro_pocitos
WHERE NOT EXISTS (SELECT 1 FROM maquinaria WHERE tipoDeMaquinaria = 'Cinta transportadora (Centro Pocitos)' AND idInstalacion = @inst_centro_pocitos);

INSERT INTO maquinaria (tipoDeMaquinaria, estadoMaquinaria, disponibilidadMaquinaria, idInstalacion)
SELECT 'Prensa de fardos (Centro Carrasco)', 'en mantenimiento', 'no disponible', @inst_centro_carrasco
WHERE NOT EXISTS (SELECT 1 FROM maquinaria WHERE tipoDeMaquinaria = 'Prensa de fardos (Centro Carrasco)' AND idInstalacion = @inst_centro_carrasco);

INSERT INTO maquinaria (tipoDeMaquinaria, estadoMaquinaria, disponibilidadMaquinaria, idInstalacion)
SELECT 'Balanza industrial (Centro Carrasco)', 'operativa', 'disponible', @inst_centro_carrasco
WHERE NOT EXISTS (SELECT 1 FROM maquinaria WHERE tipoDeMaquinaria = 'Balanza industrial (Centro Carrasco)' AND idInstalacion = @inst_centro_carrasco);

INSERT INTO maquinaria (tipoDeMaquinaria, estadoMaquinaria, disponibilidadMaquinaria, idInstalacion)
SELECT 'Retroexcavadora (Vertedero Melilla)', 'operativa', 'disponible', @inst_vertedero_melilla
WHERE NOT EXISTS (SELECT 1 FROM maquinaria WHERE tipoDeMaquinaria = 'Retroexcavadora (Vertedero Melilla)' AND idInstalacion = @inst_vertedero_melilla);

INSERT INTO maquinaria (tipoDeMaquinaria, estadoMaquinaria, disponibilidadMaquinaria, idInstalacion)
SELECT 'Compactador de residuos (Vertedero Melilla)', 'operativa', 'disponible', @inst_vertedero_melilla
WHERE NOT EXISTS (SELECT 1 FROM maquinaria WHERE tipoDeMaquinaria = 'Compactador de residuos (Vertedero Melilla)' AND idInstalacion = @inst_vertedero_melilla);

INSERT INTO maquinaria (tipoDeMaquinaria, estadoMaquinaria, disponibilidadMaquinaria, idInstalacion)
SELECT 'Topadora (Vertedero Las Rosas)', 'en mantenimiento', 'no disponible', @inst_vertedero_lasrosas
WHERE NOT EXISTS (SELECT 1 FROM maquinaria WHERE tipoDeMaquinaria = 'Topadora (Vertedero Las Rosas)' AND idInstalacion = @inst_vertedero_lasrosas);

-- ------------------------------------------------------------
-- 4. Cuadrillas nuevas — 8, una por municipio de Montevideo (A a G y
--    CH), cada una con su chofer + jefe + 2 operarios + camión + una
--    de las rutas oficiales de la IMM que todavía no tenía cuadrilla
--    asignada (de las 127 que agregó agregar_rutas_recoleccion.sql).
-- ------------------------------------------------------------

SET @ruta_pocitos   := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%CH_DU_RM_CL_102%' LIMIT 1);
SET @ruta_cerro     := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%A_DU_RM_CL_202%' LIMIT 1);
SET @ruta_carrasco  := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%E_DU_RM_CL_113%' LIMIT 1);
SET @ruta_cerrito   := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%D_DU_RM_CL_111%' LIMIT 1);
SET @ruta_colon     := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%G_DU_RM_CL_110%' LIMIT 1);
SET @ruta_prado     := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%C_DU_RM_CL_115%' LIMIT 1);
SET @ruta_maronas   := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%F_DU_RM_CL_104%' LIMIT 1);
SET @ruta_pqerodo   := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%B_DU_RM_CL_07%' LIMIT 1);

INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Pocitos',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000003'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000011'),
    @ruta_pocitos, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Pocitos');

INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Cerro',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000004'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000012'),
    @ruta_cerro, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Cerro');

INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Carrasco',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000005'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000013'),
    @ruta_carrasco, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Carrasco');

INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Cerrito',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000006'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000014'),
    @ruta_cerrito, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Cerrito');

-- Cuadrilla Colón: a propósito con el camión que está "en mantenimiento"
-- (SCA 2205, chofer 30000007), para poder probar ese caso en el panel.
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Colón',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000007'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000015'),
    @ruta_colon, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Colón');

INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Prado',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000008'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000016'),
    @ruta_prado, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Prado');

INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Flor de Maronas',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000009'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000017'),
    @ruta_maronas, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Flor de Maronas');

-- Cuadrilla Parque Rodó: a propósito dada de baja (estadoCuadrilla = 'baja'),
-- para poder probar el filtro de cuadrillas de baja en el panel.
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Parque Rodó',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000010'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000018'),
    @ruta_pqerodo, 'baja'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Parque Rodó');

-- Completa el idCuadrilla de cada chofer/jefe/operario (igual que hace
-- 02_datos_prueba.sql en su sección 4). Es un UPDATE puro -- repetirlo
-- no cambia nada, así que no necesita guarda de idempotencia aparte.
UPDATE operarioDeCuadrilla o
JOIN usuario u ON u.cedulaUsuario = o.cedulaUsuario
JOIN cuadrilla c ON (
       (u.cedulaUsuario IN ('30000003','30000011','30000019','30000020') AND c.nombreCuadrilla = 'Cuadrilla Pocitos')
    OR (u.cedulaUsuario IN ('30000004','30000012','30000021','30000022') AND c.nombreCuadrilla = 'Cuadrilla Cerro')
    OR (u.cedulaUsuario IN ('30000005','30000013','30000023','30000024') AND c.nombreCuadrilla = 'Cuadrilla Carrasco')
    OR (u.cedulaUsuario IN ('30000006','30000014','30000025','30000026') AND c.nombreCuadrilla = 'Cuadrilla Cerrito')
    OR (u.cedulaUsuario IN ('30000007','30000015','30000027','30000028') AND c.nombreCuadrilla = 'Cuadrilla Colón')
    OR (u.cedulaUsuario IN ('30000008','30000016','30000029','30000030') AND c.nombreCuadrilla = 'Cuadrilla Prado')
    OR (u.cedulaUsuario IN ('30000009','30000017','30000031','30000032') AND c.nombreCuadrilla = 'Cuadrilla Flor de Maronas')
    OR (u.cedulaUsuario IN ('30000010','30000018','30000033','30000034') AND c.nombreCuadrilla = 'Cuadrilla Parque Rodó')
)
SET o.idCuadrilla = c.idCuadrilla
WHERE u.cedulaUsuario BETWEEN '30000003' AND '30000034';

-- ------------------------------------------------------------
-- 5. Contenedores nuevos — direcciones puntuales para poder atar las
--    incidencias de la sección 6 a un contenedor real (los ~11.130
--    oficiales de la IMM no tienen un id previsible para hacer esto a
--    mano, así que se agregan estos aparte, con sus propios barrio y
--    municipio para que el buscador del mapa también los encuentre).
-- ------------------------------------------------------------

INSERT INTO contenedor (ubicacionContenedor, estadoContenedor, capacidadContenedor, tipoResiduoContenedor, latitudContenedor, longitudContenedor, zonaContenedor, municipioContenedor)
SELECT 'Ellauri 1240, Pocitos', 'disponible', 1100.00, 'General', -34.91480000, -56.15650000, 'Pocitos', 'CH'
WHERE NOT EXISTS (SELECT 1 FROM contenedor WHERE ubicacionContenedor = 'Ellauri 1240, Pocitos');

INSERT INTO contenedor (ubicacionContenedor, estadoContenedor, capacidadContenedor, tipoResiduoContenedor, latitudContenedor, longitudContenedor, zonaContenedor, municipioContenedor)
SELECT 'Carlos Ma. de Pena 1100, Cerro', 'lleno', 1100.00, 'Reciclable', -34.89900000, -56.26100000, 'Cerro', 'A'
WHERE NOT EXISTS (SELECT 1 FROM contenedor WHERE ubicacionContenedor = 'Carlos Ma. de Pena 1100, Cerro');

INSERT INTO contenedor (ubicacionContenedor, estadoContenedor, capacidadContenedor, tipoResiduoContenedor, latitudContenedor, longitudContenedor, zonaContenedor, municipioContenedor)
SELECT 'Camino Maldonado 7820, Carrasco', 'dañado', 800.00, 'General', -34.86100000, -56.05900000, 'Carrasco', 'E'
WHERE NOT EXISTS (SELECT 1 FROM contenedor WHERE ubicacionContenedor = 'Camino Maldonado 7820, Carrasco');

INSERT INTO contenedor (ubicacionContenedor, estadoContenedor, capacidadContenedor, tipoResiduoContenedor, latitudContenedor, longitudContenedor, zonaContenedor, municipioContenedor)
SELECT 'Centenario 1930, Cerrito', 'disponible', 1100.00, 'Orgánico', -34.86700000, -56.19200000, 'Cerrito', 'D'
WHERE NOT EXISTS (SELECT 1 FROM contenedor WHERE ubicacionContenedor = 'Centenario 1930, Cerrito');

INSERT INTO contenedor (ubicacionContenedor, estadoContenedor, capacidadContenedor, tipoResiduoContenedor, latitudContenedor, longitudContenedor, zonaContenedor, municipioContenedor)
SELECT 'Camino Corrales 3980, Colón', 'disponible', 1100.00, 'General', -34.82900000, -56.25400000, 'Colon Centro y Noroeste', 'G'
WHERE NOT EXISTS (SELECT 1 FROM contenedor WHERE ubicacionContenedor = 'Camino Corrales 3980, Colón');

INSERT INTO contenedor (ubicacionContenedor, estadoContenedor, capacidadContenedor, tipoResiduoContenedor, latitudContenedor, longitudContenedor, zonaContenedor, municipioContenedor)
SELECT 'Av. Sarmiento 1450, Prado', 'lleno', 1100.00, 'Reciclable', -34.87700000, -56.20900000, 'Prado Nueva Savona', 'C'
WHERE NOT EXISTS (SELECT 1 FROM contenedor WHERE ubicacionContenedor = 'Av. Sarmiento 1450, Prado');

INSERT INTO contenedor (ubicacionContenedor, estadoContenedor, capacidadContenedor, tipoResiduoContenedor, latitudContenedor, longitudContenedor, zonaContenedor, municipioContenedor)
SELECT 'Camino Castro 2240, Flor de Maronas', 'en depósito', 1100.00, 'General', -34.84100000, -56.13800000, 'Flor de Maronas', 'F'
WHERE NOT EXISTS (SELECT 1 FROM contenedor WHERE ubicacionContenedor = 'Camino Castro 2240, Flor de Maronas');

INSERT INTO contenedor (ubicacionContenedor, estadoContenedor, capacidadContenedor, tipoResiduoContenedor, latitudContenedor, longitudContenedor, zonaContenedor, municipioContenedor)
SELECT 'Bulevar Artigas 1870, Parque Rodó', 'dañado', 1100.00, 'General', -34.91100000, -56.17300000, 'Parque Rodo', 'B'
WHERE NOT EXISTS (SELECT 1 FROM contenedor WHERE ubicacionContenedor = 'Bulevar Artigas 1870, Parque Rodó');

-- ------------------------------------------------------------
-- 6. Incidencias nuevas — varios tipos (vocabulario real que usan el
--    formulario público y el panel del Jefe: Contenedor desbordado /
--    dañado / prendido fuego, Residuos fuera de lugar, Inconveniente
--    en la ruta o el camión, Otra situación) y varios estados (abierta
--    sin asignar, asignada a una cuadrilla nueva, resuelta).
-- ------------------------------------------------------------

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Contenedor desbordado hace dos días, se acumulan bolsas en la vereda.', 'abierta', 'vecino.pocitos@example.com', 'Contenedor desbordado', 'Pocitos', DATE_SUB(NOW(), INTERVAL 2 DAY),
    (SELECT idContenedor FROM contenedor WHERE ubicacionContenedor = 'Ellauri 1240, Pocitos'), NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Contenedor desbordado hace dos días, se acumulan bolsas en la vereda.');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El contenedor tiene la tapa rota y pierde residuos con el viento.', 'asignada', 'vecino.cerro@example.com', 'Contenedor dañado', 'Cerro', DATE_SUB(NOW(), INTERVAL 1 DAY),
    (SELECT idContenedor FROM contenedor WHERE ubicacionContenedor = 'Carlos Ma. de Pena 1100, Cerro'),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Cerro')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El contenedor tiene la tapa rota y pierde residuos con el viento.');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Se ve humo y restos quemados junto al contenedor, posible incendio intencional.', 'asignada', 'vecino.carrasco@example.com', 'Contenedor prendido fuego', 'Carrasco', DATE_SUB(NOW(), INTERVAL 5 HOUR),
    (SELECT idContenedor FROM contenedor WHERE ubicacionContenedor = 'Camino Maldonado 7820, Carrasco'),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Carrasco')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Se ve humo y restos quemados junto al contenedor, posible incendio intencional.');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Hay bolsas de residuos tiradas al lado del contenedor, no adentro.', 'abierta', NULL, 'Residuos fuera de lugar', 'Cerrito', DATE_SUB(NOW(), INTERVAL 10 HOUR),
    (SELECT idContenedor FROM contenedor WHERE ubicacionContenedor = 'Centenario 1930, Cerrito'), NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Hay bolsas de residuos tiradas al lado del contenedor, no adentro.');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El camión de la cuadrilla no pudo pasar por la calle por obras, quedó pendiente el retiro.', 'resuelta', NULL, 'Inconveniente en la ruta o el camión', 'Colon Centro y Noroeste', DATE_SUB(NOW(), INTERVAL 6 DAY),
    (SELECT idContenedor FROM contenedor WHERE ubicacionContenedor = 'Camino Corrales 3980, Colón'),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Colón')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El camión de la cuadrilla no pudo pasar por la calle por obras, quedó pendiente el retiro.');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Mal olor fuerte en la zona, posible contenedor con residuos orgánicos vencidos.', 'abierta', 'vecino.prado@example.com', 'Otra situación', 'Prado Nueva Savona', DATE_SUB(NOW(), INTERVAL 8 HOUR),
    (SELECT idContenedor FROM contenedor WHERE ubicacionContenedor = 'Av. Sarmiento 1450, Prado'), NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Mal olor fuerte en la zona, posible contenedor con residuos orgánicos vencidos.');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Contenedor en depósito, pendiente de reinstalar en la vía pública.', 'resuelta', NULL, 'Otra situación', 'Flor de Maronas', DATE_SUB(NOW(), INTERVAL 9 DAY),
    (SELECT idContenedor FROM contenedor WHERE ubicacionContenedor = 'Camino Castro 2240, Flor de Maronas'),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Flor de Maronas')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Contenedor en depósito, pendiente de reinstalar en la vía pública.');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Contenedor dañado por un choque, quedó inclinado contra el cordón.', 'abierta', 'vecino.rodo@example.com', 'Contenedor dañado', 'Parque Rodo', DATE_SUB(NOW(), INTERVAL 1 HOUR),
    (SELECT idContenedor FROM contenedor WHERE ubicacionContenedor = 'Bulevar Artigas 1870, Parque Rodó'), NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Contenedor dañado por un choque, quedó inclinado contra el cordón.');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reclamo reiterado por falta de recolección en la zona hace más de una semana.', 'abierta', NULL, 'Otra situación', 'Pocitos', DATE_SUB(NOW(), INTERVAL 30 MINUTE),
    (SELECT idContenedor FROM contenedor WHERE ubicacionContenedor = 'Ellauri 1240, Pocitos'),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Pocitos')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reclamo reiterado por falta de recolección en la zona hace más de una semana.');

-- ------------------------------------------------------------
-- 7. Solicitudes de usuario pendientes — una por cada uno de los 4
--    roles que aprobarSolicitud soporta hoy, para probar la aprobación
--    de cada caso.
-- ------------------------------------------------------------

INSERT INTO solicitudDeUsuario (cedulaUsuario, nombreUsuario, apellidoUsuario, direccionCompletaUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, contraseniaSolicitud, rolSolicitado, estadoSolicitud, fechaSolicitud)
SELECT '30000901', 'Cecilia', 'Barrios', 'Av. Millán 4120', 'cecilia.barrios@example.com', '099300001', '1991-05-14', '$2y$12$OYGK9T.95E6qmuHAslorOOGtEacKdiYmSpgY227lB1ZlDMgorSHkW', 'administrador', 'pendiente', DATE_SUB(NOW(), INTERVAL 1 DAY)
WHERE NOT EXISTS (SELECT 1 FROM solicitudDeUsuario WHERE cedulaUsuario = '30000901');

INSERT INTO solicitudDeUsuario (cedulaUsuario, nombreUsuario, apellidoUsuario, direccionCompletaUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, contraseniaSolicitud, rolSolicitado, estadoSolicitud, fechaSolicitud)
SELECT '30000902', 'Hernán', 'Bordón', 'Luis Alberto de Herrera 2240', 'hernan.bordon@example.com', '099300002', '1989-02-27', '$2y$12$OYGK9T.95E6qmuHAslorOOGtEacKdiYmSpgY227lB1ZlDMgorSHkW', 'chofer', 'pendiente', DATE_SUB(NOW(), INTERVAL 10 HOUR)
WHERE NOT EXISTS (SELECT 1 FROM solicitudDeUsuario WHERE cedulaUsuario = '30000902');

INSERT INTO solicitudDeUsuario (cedulaUsuario, nombreUsuario, apellidoUsuario, direccionCompletaUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, contraseniaSolicitud, rolSolicitado, estadoSolicitud, fechaSolicitud)
SELECT '30000903', 'Paola', 'Techera', 'Av. Rivera 3320', 'paola.techera@example.com', '099300003', '1994-09-08', '$2y$12$OYGK9T.95E6qmuHAslorOOGtEacKdiYmSpgY227lB1ZlDMgorSHkW', 'jefeDeCuadrilla', 'pendiente', DATE_SUB(NOW(), INTERVAL 3 DAY)
WHERE NOT EXISTS (SELECT 1 FROM solicitudDeUsuario WHERE cedulaUsuario = '30000903');

INSERT INTO solicitudDeUsuario (cedulaUsuario, nombreUsuario, apellidoUsuario, direccionCompletaUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, contraseniaSolicitud, rolSolicitado, estadoSolicitud, fechaSolicitud)
SELECT '30000904', 'Ariel', 'Núñez', 'Camino Maldonado 5120', 'ariel.nunez@example.com', '099300004', '1997-11-23', '$2y$12$OYGK9T.95E6qmuHAslorOOGtEacKdiYmSpgY227lB1ZlDMgorSHkW', 'operarioDeCuadrilla', 'pendiente', DATE_SUB(NOW(), INTERVAL 4 HOUR)
WHERE NOT EXISTS (SELECT 1 FROM solicitudDeUsuario WHERE cedulaUsuario = '30000904');

COMMIT;

-- ============================================================
-- Listo. Resumen de lo que se agregó (además de lo que ya traía
-- 02_datos_prueba.sql):
--   - 34 funcionarios nuevos: 2 administradores, 8 choferes, 8 jefes
--     de cuadrilla, 16 operarios de cuadrilla. Contraseña de los 34:
--     Equipo2026!
--   - 10 camiones nuevos (8 asignados a los choferes nuevos, 1 de
--     repuesto sin chofer, 1 fuera de servicio).
--   - 2 centros de acopio + 2 vertederos nuevos (total 3 de cada uno
--     con 02_datos_prueba.sql), cada uno con su propia maquinaria.
--   - 8 cuadrillas nuevas (una por municipio A-G y CH, total 10 con
--     las 2 de 02_datos_prueba.sql), usando rutas oficiales de la IMM
--     que todavía no tenían cuadrilla. Una queda dada de baja (Parque
--     Rodó) y otra con el camión en mantenimiento (Colón), para poder
--     probar esos casos.
--   - 8 contenedores nuevos, en las mismas zonas que las cuadrillas
--     nuevas (sirven también para probar el buscador del mapa por
--     barrio/municipio).
--   - 9 incidencias nuevas: varios tipos (desbordado, dañado,
--     prendido fuego, residuos fuera de lugar, inconveniente de ruta,
--     otra situación) y estados (abierta/asignada/resuelta).
--   - 4 solicitudes de usuario pendientes, una por cada rol que hoy
--     puede aprobarse (administrador, chofer, jefe de cuadrilla,
--     operario de cuadrilla).
--
-- Cuentas nuevas para probar cada rol (todas con Equipo2026!):
--   Administrador      -> patricia.nunez@sigeru.test / gonzalo.ferreira@sigeru.test
--   Chofer              -> walter.suarez@sigeru.test (y 7 más, ver sección 1)
--   Jefe de Cuadrilla   -> carolina.paz@sigeru.test (y 7 más, ver sección 1)
--   Operario de cuadrilla -> jonathan.silveira@sigeru.test (y 15 más)
-- ============================================================
