-- ============================================================
-- SiGeRU — Cobertura total de rutas con datos reales (funcionarios,
-- camiones, cuadrillas e incidencias para las 68 rutas que todavia
-- no tenian cuadrilla asignada, de las 73 que tienen horario y
-- frecuencia reales - las 57 "Sin datos" quedan deliberadamente
-- afuera, igual que las 5 cuadrillas ya existentes que habian quedado
-- sobre rutas "Sin datos" (Pocitos/Cerro/Prado/Flor de Maronas/Parque
-- Rodo), que no se tocan.
-- ============================================================
-- IDEMPOTENTE: mismo patron que 03_ampliar_datos_prueba.sql -
-- INSERT ... SELECT ... WHERE NOT EXISTS (...). Se puede correr mas
-- de una vez sin duplicar nada.
--
-- Cedulas nuevas: 30000035-30000306 (272 funcionarios: 68 choferes,
-- 68 jefes de cuadrilla, 136 operarios - 2 por cuadrilla). Misma
-- contraseña que el resto de las cuentas de prueba: Equipo2026!
--
-- Requiere haber corrido antes 01_code.sql, 02_datos_prueba.sql y
-- 03_ampliar_datos_prueba.sql.
-- ============================================================

USE SiGeRU;

-- ------------------------------------------------------------
-- 1. Funcionarios nuevos - 68 choferes, 68 jefes de cuadrilla y
--    136 operarios (2 por cada una de las 68 cuadrillas nuevas).
-- ------------------------------------------------------------

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000035', 'Lucia', 'Perez', 'Carlos Roxlo', '500', NULL, 'lucia.perez35@sigeru.test', '099200035', '1975-01-01', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000035');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000036', 'Alvaro', 'Alvarez', 'Ellauri', '537', NULL, 'alvaro.alvarez36@sigeru.test', '099200036', '1976-08-12', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000036');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000037', 'Nestor', 'Correa', 'Rivera', '574', NULL, 'nestor.correa37@sigeru.test', '099200037', '1977-03-23', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000037');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000038', 'Valentina', 'Mendez', 'Jacinto Vera', '611', NULL, 'valentina.mendez38@sigeru.test', '099200038', '1978-10-06', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000038');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000039', 'Hugo', 'Cabrera', 'Camino Maldonado', '648', NULL, 'hugo.cabrera39@sigeru.test', '099200039', '1979-05-17', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000039');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000040', 'Ruben', 'Coronel', 'Av. San Martin', '685', NULL, 'ruben.coronel40@sigeru.test', '099200040', '1980-12-28', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000040');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000041', 'Camila', 'Pereyra', 'Bulevar Artigas', '722', NULL, 'camila.pereyra41@sigeru.test', '099200041', '1981-07-11', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000041');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000042', 'Washington', 'Rivero', 'Av. Millan', '759', NULL, 'washington.rivero42@sigeru.test', '099200042', '1982-02-22', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000042');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000043', 'Leonel', 'Acosta', '8 de Octubre', '796', NULL, 'leonel.acosta43@sigeru.test', '099200043', '1983-09-05', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000043');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000044', 'Ines', 'Methol', 'Av. Italia', '833', NULL, 'ines.methol44@sigeru.test', '099200044', '1984-04-16', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000044');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000045', 'Federico', 'Rotela', 'Av. 18 de Julio', '870', NULL, 'federico.rotela45@sigeru.test', '099200045', '1985-11-27', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000045');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000046', 'Richard', 'Brum', 'Dante', '907', NULL, 'richard.brum46@sigeru.test', '099200046', '1986-06-10', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000046');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000047', 'Noelia', 'Soca', 'Carlos Maria de Pena', '944', NULL, 'noelia.soca47@sigeru.test', '099200047', '1987-01-21', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000047');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000048', 'Cristian', 'Estevez', 'Camino Melilla', '981', NULL, 'cristian.estevez48@sigeru.test', '099200048', '1988-08-04', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000048');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000049', 'Julio', 'Perez', 'Av. Dr. Juan Pablo Fabini', '1018', NULL, 'julio.perez49@sigeru.test', '099200049', '1989-03-15', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000049');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000050', 'Carla', 'Alvarez', 'Durazno', '1055', NULL, 'carla.alvarez50@sigeru.test', '099200050', '1990-10-26', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000050');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000051', 'Wilson', 'Correa', 'Industria', '1092', NULL, 'wilson.correa51@sigeru.test', '099200051', '1991-05-09', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000051');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000052', 'Alfredo', 'Mendez', 'Carlos Roxlo', '1129', NULL, 'alfredo.mendez52@sigeru.test', '099200052', '1992-12-20', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000052');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000053', 'Gimena', 'Cabrera', 'Ellauri', '1166', NULL, 'gimena.cabrera53@sigeru.test', '099200053', '1993-07-03', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000053');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000054', 'Danilo', 'Coronel', 'Rivera', '1203', NULL, 'danilo.coronel54@sigeru.test', '099200054', '1994-02-14', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000054');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000055', 'Marcos', 'Pereyra', 'Jacinto Vera', '1240', NULL, 'marcos.pereyra55@sigeru.test', '099200055', '1995-09-25', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000055');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000056', 'Antonella', 'Rivero', 'Camino Maldonado', '1277', NULL, 'antonella.rivero56@sigeru.test', '099200056', '1996-04-08', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000056');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000057', 'Emiliano', 'Acosta', 'Av. San Martin', '1314', NULL, 'emiliano.acosta57@sigeru.test', '099200057', '1997-11-19', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000057');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000058', 'Agustin', 'Methol', 'Bulevar Artigas', '1351', NULL, 'agustin.methol58@sigeru.test', '099200058', '1998-06-02', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000058');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000059', 'Melisa', 'Rotela', 'Av. Millan', '1388', NULL, 'melisa.rotela59@sigeru.test', '099200059', '1999-01-13', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000059');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000060', 'Santiago', 'Brum', '8 de Octubre', '1425', NULL, 'santiago.brum60@sigeru.test', '099200060', '1975-08-24', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000060');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000061', 'Gaston', 'Soca', 'Av. Italia', '1462', NULL, 'gaston.soca61@sigeru.test', '099200061', '1976-03-07', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000061');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000062', 'Victoria', 'Estevez', 'Av. 18 de Julio', '1499', NULL, 'victoria.estevez62@sigeru.test', '099200062', '1977-10-18', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000062');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000063', 'Bruno', 'Perez', 'Dante', '1536', NULL, 'bruno.perez63@sigeru.test', '099200063', '1978-05-01', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000063');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000064', 'Nahuel', 'Alvarez', 'Carlos Maria de Pena', '1573', NULL, 'nahuel.alvarez64@sigeru.test', '099200064', '1979-12-12', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000064');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000065', 'Cecilia', 'Correa', 'Camino Melilla', '1610', NULL, 'cecilia.correa65@sigeru.test', '099200065', '1980-07-23', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000065');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000066', 'Joaquin', 'Mendez', 'Av. Dr. Juan Pablo Fabini', '1647', NULL, 'joaquin.mendez66@sigeru.test', '099200066', '1981-02-06', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000066');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000067', 'Tabare', 'Cabrera', 'Durazno', '1684', NULL, 'tabare.cabrera67@sigeru.test', '099200067', '1982-09-17', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000067');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000068', 'Daniela', 'Coronel', 'Industria', '1721', NULL, 'daniela.coronel68@sigeru.test', '099200068', '1983-04-28', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000068');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000069', 'Sergio', 'Pereyra', 'Carlos Roxlo', '1758', NULL, 'sergio.pereyra69@sigeru.test', '099200069', '1984-11-11', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000069');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000070', 'Fernando', 'Rivero', 'Ellauri', '1795', NULL, 'fernando.rivero70@sigeru.test', '099200070', '1985-06-22', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000070');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000071', 'Paola', 'Acosta', 'Rivera', '1832', NULL, 'paola.acosta71@sigeru.test', '099200071', '1986-01-05', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000071');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000072', 'Pedro', 'Methol', 'Jacinto Vera', '1869', NULL, 'pedro.methol72@sigeru.test', '099200072', '1987-08-16', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000072');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000073', 'Jorge', 'Rotela', 'Camino Maldonado', '1906', NULL, 'jorge.rotela73@sigeru.test', '099200073', '1988-03-27', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000073');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000074', 'Mariana', 'Brum', 'Av. San Martin', '1943', NULL, 'mariana.brum74@sigeru.test', '099200074', '1989-10-10', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000074');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000075', 'Eduardo', 'Soca', 'Bulevar Artigas', '1980', NULL, 'eduardo.soca75@sigeru.test', '099200075', '1990-05-21', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000075');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000076', 'Roberto', 'Estevez', 'Av. Millan', '2017', NULL, 'roberto.estevez76@sigeru.test', '099200076', '1991-12-04', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000076');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000077', 'Andrea', 'Perez', '8 de Octubre', '2054', NULL, 'andrea.perez77@sigeru.test', '099200077', '1992-07-15', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000077');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000078', 'Raul', 'Alvarez', 'Av. Italia', '2091', NULL, 'raul.alvarez78@sigeru.test', '099200078', '1993-02-26', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000078');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000079', 'Mario', 'Correa', 'Av. 18 de Julio', '2128', NULL, 'mario.correa79@sigeru.test', '099200079', '1994-09-09', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000079');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000080', 'Patricia', 'Mendez', 'Dante', '2165', NULL, 'patricia.mendez80@sigeru.test', '099200080', '1995-04-20', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000080');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000081', 'Ariel', 'Cabrera', 'Carlos Maria de Pena', '2202', NULL, 'ariel.cabrera81@sigeru.test', '099200081', '1996-11-03', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000081');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000082', 'Leandro', 'Coronel', 'Camino Melilla', '2239', NULL, 'leandro.coronel82@sigeru.test', '099200082', '1997-06-14', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000082');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000083', 'Gabriela', 'Pereyra', 'Av. Dr. Juan Pablo Fabini', '2276', NULL, 'gabriela.pereyra83@sigeru.test', '099200083', '1998-01-25', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000083');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000084', 'Ivan', 'Rivero', 'Durazno', '2313', NULL, 'ivan.rivero84@sigeru.test', '099200084', '1999-08-08', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000084');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000085', 'Pablo', 'Acosta', 'Industria', '2350', NULL, 'pablo.acosta85@sigeru.test', '099200085', '1975-03-19', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000085');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000086', 'Silvana', 'Methol', 'Carlos Roxlo', '2387', NULL, 'silvana.methol86@sigeru.test', '099200086', '1976-10-02', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000086');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000087', 'Enzo', 'Rotela', 'Ellauri', '2424', NULL, 'enzo.rotela87@sigeru.test', '099200087', '1977-05-13', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000087');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000088', 'Franco', 'Brum', 'Rivera', '2461', NULL, 'franco.brum88@sigeru.test', '099200088', '1978-12-24', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000088');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000089', 'Estela', 'Soca', 'Jacinto Vera', '2498', NULL, 'estela.soca89@sigeru.test', '099200089', '1979-07-07', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000089');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000090', 'Maxi', 'Estevez', 'Camino Maldonado', '2535', NULL, 'maxi.estevez90@sigeru.test', '099200090', '1980-02-18', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000090');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000091', 'Alan', 'Perez', 'Av. San Martin', '2572', NULL, 'alan.perez91@sigeru.test', '099200091', '1981-09-01', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000091');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000092', 'Monica', 'Alvarez', 'Bulevar Artigas', '2609', NULL, 'monica.alvarez92@sigeru.test', '099200092', '1982-04-12', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000092');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000093', 'Dario', 'Correa', 'Av. Millan', '2646', NULL, 'dario.correa93@sigeru.test', '099200093', '1983-11-23', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000093');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000094', 'Sebastian', 'Mendez', '8 de Octubre', '2683', NULL, 'sebastian.mendez94@sigeru.test', '099200094', '1984-06-06', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000094');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000095', 'Adriana', 'Cabrera', 'Av. Italia', '2720', NULL, 'adriana.cabrera95@sigeru.test', '099200095', '1985-01-17', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000095');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000096', 'Horacio', 'Coronel', 'Av. 18 de Julio', '2757', NULL, 'horacio.coronel96@sigeru.test', '099200096', '1986-08-28', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000096');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000097', 'Elbio', 'Pereyra', 'Dante', '2794', NULL, 'elbio.pereyra97@sigeru.test', '099200097', '1987-03-11', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000097');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000098', 'Veronica', 'Rivero', 'Carlos Maria de Pena', '2831', NULL, 'veronica.rivero98@sigeru.test', '099200098', '1988-10-22', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000098');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000099', 'Rafael', 'Acosta', 'Camino Melilla', '2868', NULL, 'rafael.acosta99@sigeru.test', '099200099', '1989-05-05', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000099');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000100', 'Jose', 'Methol', 'Av. Dr. Juan Pablo Fabini', '2905', NULL, 'jose.methol100@sigeru.test', '099200100', '1990-12-16', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000100');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000101', 'Natalia', 'Rotela', 'Durazno', '2942', NULL, 'natalia.rotela101@sigeru.test', '099200101', '1991-07-27', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000101');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000102', 'Ismael', 'Brum', 'Industria', '2979', NULL, 'ismael.brum102@sigeru.test', '099200102', '1992-02-10', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000102');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000103', 'Walter', 'Soca', 'Carlos Roxlo', '3016', NULL, 'walter.soca103@sigeru.test', '099200103', '1993-09-21', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000103');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000104', 'Alejandra', 'Estevez', 'Ellauri', '3053', NULL, 'alejandra.estevez104@sigeru.test', '099200104', '1994-04-04', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000104');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000105', 'Mauricio', 'Perez', 'Rivera', '3090', NULL, 'mauricio.perez105@sigeru.test', '099200105', '1995-11-15', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000105');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000106', 'Alvaro', 'Alvarez', 'Jacinto Vera', '3127', NULL, 'alvaro.alvarez106@sigeru.test', '099200106', '1996-06-26', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000106');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000107', 'Beatriz', 'Correa', 'Camino Maldonado', '3164', NULL, 'beatriz.correa107@sigeru.test', '099200107', '1997-01-09', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000107');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000108', 'Diego', 'Mendez', 'Av. San Martin', '3201', NULL, 'diego.mendez108@sigeru.test', '099200108', '1998-08-20', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000108');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000109', 'Hugo', 'Cabrera', 'Bulevar Artigas', '3238', NULL, 'hugo.cabrera109@sigeru.test', '099200109', '1999-03-03', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000109');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000110', 'Clara', 'Coronel', 'Av. Millan', '3275', NULL, 'clara.coronel110@sigeru.test', '099200110', '1975-10-14', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000110');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000111', 'Gerardo', 'Pereyra', '8 de Octubre', '3312', NULL, 'gerardo.pereyra111@sigeru.test', '099200111', '1976-05-25', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000111');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000112', 'Washington', 'Rivero', 'Av. Italia', '3349', NULL, 'washington.rivero112@sigeru.test', '099200112', '1977-12-08', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000112');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000113', 'Elena', 'Acosta', 'Av. 18 de Julio', '3386', NULL, 'elena.acosta113@sigeru.test', '099200113', '1978-07-19', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000113');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000114', 'Martin', 'Methol', 'Dante', '3423', NULL, 'martin.methol114@sigeru.test', '099200114', '1979-02-02', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000114');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000115', 'Federico', 'Rotela', 'Carlos Maria de Pena', '3460', NULL, 'federico.rotela115@sigeru.test', '099200115', '1980-09-13', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000115');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000116', 'Susana', 'Brum', 'Camino Melilla', '3497', NULL, 'susana.brum116@sigeru.test', '099200116', '1981-04-24', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000116');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000117', 'Alexis', 'Soca', 'Av. Dr. Juan Pablo Fabini', '3534', NULL, 'alexis.soca117@sigeru.test', '099200117', '1982-11-07', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000117');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000118', 'Cristian', 'Estevez', 'Durazno', '3571', NULL, 'cristian.estevez118@sigeru.test', '099200118', '1983-06-18', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000118');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000119', 'Rosana', 'Perez', 'Industria', '3608', NULL, 'rosana.perez119@sigeru.test', '099200119', '1984-01-01', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000119');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000120', 'Omar', 'Alvarez', 'Carlos Roxlo', '3645', NULL, 'omar.alvarez120@sigeru.test', '099200120', '1985-08-12', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000120');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000121', 'Wilson', 'Correa', 'Ellauri', '3682', NULL, 'wilson.correa121@sigeru.test', '099200121', '1986-03-23', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000121');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000122', 'Virginia', 'Mendez', 'Rivera', '3719', NULL, 'virginia.mendez122@sigeru.test', '099200122', '1987-10-06', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000122');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000123', 'Gustavo', 'Cabrera', 'Jacinto Vera', '3756', NULL, 'gustavo.cabrera123@sigeru.test', '099200123', '1988-05-17', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000123');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000124', 'Danilo', 'Coronel', 'Camino Maldonado', '3793', NULL, 'danilo.coronel124@sigeru.test', '099200124', '1989-12-28', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000124');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000125', 'Mariela', 'Pereyra', 'Av. San Martin', '3830', NULL, 'mariela.pereyra125@sigeru.test', '099200125', '1990-07-11', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000125');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000126', 'Nicolas', 'Rivero', 'Bulevar Artigas', '3867', NULL, 'nicolas.rivero126@sigeru.test', '099200126', '1991-02-22', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000126');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000127', 'Emiliano', 'Acosta', 'Av. Millan', '3904', NULL, 'emiliano.acosta127@sigeru.test', '099200127', '1992-09-05', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000127');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000128', 'Griselda', 'Methol', '8 de Octubre', '3941', NULL, 'griselda.methol128@sigeru.test', '099200128', '1993-04-16', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000128');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000129', 'Rodrigo', 'Rotela', 'Av. Italia', '3978', NULL, 'rodrigo.rotela129@sigeru.test', '099200129', '1994-11-27', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000129');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000130', 'Santiago', 'Brum', 'Av. 18 de Julio', '4015', NULL, 'santiago.brum130@sigeru.test', '099200130', '1995-06-10', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000130');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000131', 'Laura', 'Soca', 'Dante', '4052', NULL, 'laura.soca131@sigeru.test', '099200131', '1996-01-21', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000131');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000132', 'Matias', 'Estevez', 'Carlos Maria de Pena', '4089', NULL, 'matias.estevez132@sigeru.test', '099200132', '1997-08-04', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000132');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000133', 'Bruno', 'Perez', 'Camino Melilla', '4126', NULL, 'bruno.perez133@sigeru.test', '099200133', '1998-03-15', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000133');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000134', 'Marcela', 'Alvarez', 'Av. Dr. Juan Pablo Fabini', '4163', NULL, 'marcela.alvarez134@sigeru.test', '099200134', '1999-10-26', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000134');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000135', 'Ramiro', 'Correa', 'Durazno', '4200', NULL, 'ramiro.correa135@sigeru.test', '099200135', '1975-05-09', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000135');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000136', 'Joaquin', 'Mendez', 'Industria', '4237', NULL, 'joaquin.mendez136@sigeru.test', '099200136', '1976-12-20', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000136');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000137', 'Sandra', 'Cabrera', 'Carlos Roxlo', '4274', NULL, 'sandra.cabrera137@sigeru.test', '099200137', '1977-07-03', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000137');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000138', 'Milton', 'Coronel', 'Ellauri', '4311', NULL, 'milton.coronel138@sigeru.test', '099200138', '1978-02-14', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000138');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000139', 'Sergio', 'Pereyra', 'Rivera', '4348', NULL, 'sergio.pereyra139@sigeru.test', '099200139', '1979-09-25', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000139');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000140', 'Ivonne', 'Rivero', 'Jacinto Vera', '4385', NULL, 'ivonne.rivero140@sigeru.test', '099200140', '1980-04-08', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000140');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000141', 'Andres', 'Acosta', 'Camino Maldonado', '4422', NULL, 'andres.acosta141@sigeru.test', '099200141', '1981-11-19', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000141');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000142', 'Pedro', 'Methol', 'Av. San Martin', '4459', NULL, 'pedro.methol142@sigeru.test', '099200142', '1982-06-02', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000142');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000143', 'Karina', 'Rotela', 'Bulevar Artigas', '4496', NULL, 'karina.rotela143@sigeru.test', '099200143', '1983-01-13', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000143');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000144', 'Carlos', 'Brum', 'Av. Millan', '4533', NULL, 'carlos.brum144@sigeru.test', '099200144', '1984-08-24', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000144');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000145', 'Eduardo', 'Soca', '8 de Octubre', '4570', NULL, 'eduardo.soca145@sigeru.test', '099200145', '1985-03-07', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000145');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000146', 'Yolanda', 'Estevez', 'Av. Italia', '4607', NULL, 'yolanda.estevez146@sigeru.test', '099200146', '1986-10-18', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000146');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000147', 'Victor', 'Perez', 'Av. 18 de Julio', '4644', NULL, 'victor.perez147@sigeru.test', '099200147', '1987-05-01', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000147');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000148', 'Raul', 'Alvarez', 'Dante', '4681', NULL, 'raul.alvarez148@sigeru.test', '099200148', '1988-12-12', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000148');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000149', 'Noelia', 'Correa', 'Carlos Maria de Pena', '4718', NULL, 'noelia.correa149@sigeru.test', '099200149', '1989-07-23', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000149');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000150', 'Adrian', 'Mendez', 'Camino Melilla', '4755', NULL, 'adrian.mendez150@sigeru.test', '099200150', '1990-02-06', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000150');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000151', 'Ariel', 'Cabrera', 'Av. Dr. Juan Pablo Fabini', '4792', NULL, 'ariel.cabrera151@sigeru.test', '099200151', '1991-09-17', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000151');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000152', 'Milagros', 'Coronel', 'Durazno', '4829', NULL, 'milagros.coronel152@sigeru.test', '099200152', '1992-04-28', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000152');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000153', 'Maximo', 'Pereyra', 'Industria', '4866', NULL, 'maximo.pereyra153@sigeru.test', '099200153', '1993-11-11', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000153');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000154', 'Ivan', 'Rivero', 'Carlos Roxlo', '4903', NULL, 'ivan.rivero154@sigeru.test', '099200154', '1994-06-22', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000154');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000155', 'Belen', 'Acosta', 'Ellauri', '4940', NULL, 'belen.acosta155@sigeru.test', '099200155', '1995-01-05', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000155');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000156', 'Luis', 'Methol', 'Rivera', '4977', NULL, 'luis.methol156@sigeru.test', '099200156', '1996-08-16', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000156');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000157', 'Enzo', 'Rotela', 'Jacinto Vera', '5014', NULL, 'enzo.rotela157@sigeru.test', '099200157', '1997-03-27', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000157');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000158', 'Agustina', 'Brum', 'Camino Maldonado', '5051', NULL, 'agustina.brum158@sigeru.test', '099200158', '1998-10-10', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000158');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000159', 'Ignacio', 'Soca', 'Av. San Martin', '5088', NULL, 'ignacio.soca159@sigeru.test', '099200159', '1999-05-21', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000159');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000160', 'Maxi', 'Estevez', 'Bulevar Artigas', '5125', NULL, 'maxi.estevez160@sigeru.test', '099200160', '1975-12-04', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000160');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000161', 'Romina', 'Perez', 'Av. Millan', '5162', NULL, 'romina.perez161@sigeru.test', '099200161', '1976-07-15', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000161');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000162', 'Yamandu', 'Alvarez', '8 de Octubre', '5199', NULL, 'yamandu.alvarez162@sigeru.test', '099200162', '1977-02-26', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000162');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000163', 'Dario', 'Correa', 'Av. Italia', '5236', NULL, 'dario.correa163@sigeru.test', '099200163', '1978-09-09', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000163');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000164', 'Yesica', 'Mendez', 'Av. 18 de Julio', '5273', NULL, 'yesica.mendez164@sigeru.test', '099200164', '1979-04-20', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000164');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000165', 'Pedro', 'Cabrera', 'Dante', '5310', NULL, 'pedro.cabrera165@sigeru.test', '099200165', '1980-11-03', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000165');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000166', 'Horacio', 'Coronel', 'Carlos Maria de Pena', '5347', NULL, 'horacio.coronel166@sigeru.test', '099200166', '1981-06-14', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000166');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000167', 'Estefania', 'Pereyra', 'Camino Melilla', '5384', NULL, 'estefania.pereyra167@sigeru.test', '099200167', '1982-01-25', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000167');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000168', 'Nicolas', 'Rivero', 'Av. Dr. Juan Pablo Fabini', '5421', NULL, 'nicolas.rivero168@sigeru.test', '099200168', '1983-08-08', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000168');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000169', 'Rafael', 'Acosta', 'Durazno', '5458', NULL, 'rafael.acosta169@sigeru.test', '099200169', '1984-03-19', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000169');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000170', 'Brenda', 'Methol', 'Industria', '5495', NULL, 'brenda.methol170@sigeru.test', '099200170', '1985-10-02', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000170');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000171', 'Angel', 'Rotela', 'Carlos Roxlo', '5532', NULL, 'angel.rotela171@sigeru.test', '099200171', '1986-05-13', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000171');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000172', 'Ismael', 'Brum', 'Ellauri', '5569', NULL, 'ismael.brum172@sigeru.test', '099200172', '1987-12-24', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000172');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000173', 'Rocio', 'Soca', 'Rivera', '5606', NULL, 'rocio.soca173@sigeru.test', '099200173', '1988-07-07', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000173');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000174', 'Guillermo', 'Estevez', 'Jacinto Vera', '5643', NULL, 'guillermo.estevez174@sigeru.test', '099200174', '1989-02-18', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000174');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000175', 'Mauricio', 'Perez', 'Camino Maldonado', '5680', NULL, 'mauricio.perez175@sigeru.test', '099200175', '1990-09-01', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000175');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000176', 'Micaela', 'Alvarez', 'Av. San Martin', '5717', NULL, 'micaela.alvarez176@sigeru.test', '099200176', '1991-04-12', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000176');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000177', 'Nestor', 'Correa', 'Bulevar Artigas', '5754', NULL, 'nestor.correa177@sigeru.test', '099200177', '1992-11-23', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000177');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000178', 'Diego', 'Mendez', 'Av. Millan', '5791', NULL, 'diego.mendez178@sigeru.test', '099200178', '1993-06-06', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000178');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000179', 'Florencia', 'Cabrera', '8 de Octubre', '5828', NULL, 'florencia.cabrera179@sigeru.test', '099200179', '1994-01-17', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000179');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000180', 'Ruben', 'Coronel', 'Av. Italia', '5865', NULL, 'ruben.coronel180@sigeru.test', '099200180', '1995-08-28', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000180');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000181', 'Gerardo', 'Pereyra', 'Av. 18 de Julio', '5902', NULL, 'gerardo.pereyra181@sigeru.test', '099200181', '1996-03-11', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000181');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000182', 'Luciana', 'Rivero', 'Dante', '5939', NULL, 'luciana.rivero182@sigeru.test', '099200182', '1997-10-22', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000182');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000183', 'Leonel', 'Acosta', 'Carlos Maria de Pena', '5976', NULL, 'leonel.acosta183@sigeru.test', '099200183', '1998-05-05', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000183');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000184', 'Martin', 'Methol', 'Camino Melilla', '6013', NULL, 'martin.methol184@sigeru.test', '099200184', '1999-12-16', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000184');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000185', 'Ayelen', 'Rotela', 'Av. Dr. Juan Pablo Fabini', '6050', NULL, 'ayelen.rotela185@sigeru.test', '099200185', '1975-07-27', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000185');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000186', 'Richard', 'Brum', 'Durazno', '6087', NULL, 'richard.brum186@sigeru.test', '099200186', '1976-02-10', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000186');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000187', 'Alexis', 'Soca', 'Industria', '6124', NULL, 'alexis.soca187@sigeru.test', '099200187', '1977-09-21', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000187');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000188', 'Yamila', 'Estevez', 'Carlos Roxlo', '6161', NULL, 'yamila.estevez188@sigeru.test', '099200188', '1978-04-04', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000188');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000189', 'Julio', 'Perez', 'Ellauri', '6198', NULL, 'julio.perez189@sigeru.test', '099200189', '1979-11-15', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000189');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000190', 'Omar', 'Alvarez', 'Rivera', '6235', NULL, 'omar.alvarez190@sigeru.test', '099200190', '1980-06-26', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000190');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000191', 'Daiana', 'Correa', 'Jacinto Vera', '6272', NULL, 'daiana.correa191@sigeru.test', '099200191', '1981-01-09', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000191');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000192', 'Alfredo', 'Mendez', 'Camino Maldonado', '6309', NULL, 'alfredo.mendez192@sigeru.test', '099200192', '1982-08-20', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000192');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000193', 'Gustavo', 'Cabrera', 'Av. San Martin', '6346', NULL, 'gustavo.cabrera193@sigeru.test', '099200193', '1983-03-03', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000193');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000194', 'Carolina', 'Coronel', 'Bulevar Artigas', '6383', NULL, 'carolina.coronel194@sigeru.test', '099200194', '1984-10-14', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000194');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000195', 'Marcos', 'Pereyra', 'Av. Millan', '6420', NULL, 'marcos.pereyra195@sigeru.test', '099200195', '1985-05-25', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000195');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000196', 'Nicolas', 'Rivero', '8 de Octubre', '6457', NULL, 'nicolas.rivero196@sigeru.test', '099200196', '1986-12-08', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000196');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000197', 'Soledad', 'Acosta', 'Av. Italia', '6494', NULL, 'soledad.acosta197@sigeru.test', '099200197', '1987-07-19', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000197');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000198', 'Agustin', 'Methol', 'Av. 18 de Julio', '6531', NULL, 'agustin.methol198@sigeru.test', '099200198', '1988-02-02', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000198');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000199', 'Rodrigo', 'Rotela', 'Dante', '6568', NULL, 'rodrigo.rotela199@sigeru.test', '099200199', '1989-09-13', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000199');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000200', 'Fernanda', 'Brum', 'Carlos Maria de Pena', '6605', NULL, 'fernanda.brum200@sigeru.test', '099200200', '1990-04-24', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000200');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000201', 'Gaston', 'Soca', 'Camino Melilla', '6642', NULL, 'gaston.soca201@sigeru.test', '099200201', '1991-11-07', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000201');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000202', 'Matias', 'Estevez', 'Av. Dr. Juan Pablo Fabini', '6679', NULL, 'matias.estevez202@sigeru.test', '099200202', '1992-06-18', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000202');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000203', 'Natacha', 'Perez', 'Durazno', '6716', NULL, 'natacha.perez203@sigeru.test', '099200203', '1993-01-01', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000203');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000204', 'Nahuel', 'Alvarez', 'Industria', '6753', NULL, 'nahuel.alvarez204@sigeru.test', '099200204', '1994-08-12', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000204');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000205', 'Ramiro', 'Correa', 'Carlos Roxlo', '6790', NULL, 'ramiro.correa205@sigeru.test', '099200205', '1995-03-23', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000205');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000206', 'Vanesa', 'Mendez', 'Ellauri', '6827', NULL, 'vanesa.mendez206@sigeru.test', '099200206', '1996-10-06', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000206');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000207', 'Tabare', 'Cabrera', 'Rivera', '6864', NULL, 'tabare.cabrera207@sigeru.test', '099200207', '1997-05-17', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000207');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000208', 'Milton', 'Coronel', 'Jacinto Vera', '6901', NULL, 'milton.coronel208@sigeru.test', '099200208', '1998-12-28', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000208');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000209', 'Jessica', 'Pereyra', 'Camino Maldonado', '6938', NULL, 'jessica.pereyra209@sigeru.test', '099200209', '1999-07-11', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000209');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000210', 'Fernando', 'Rivero', 'Av. San Martin', '6975', NULL, 'fernando.rivero210@sigeru.test', '099200210', '1975-02-22', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000210');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000211', 'Andres', 'Acosta', 'Bulevar Artigas', '7012', NULL, 'andres.acosta211@sigeru.test', '099200211', '1976-09-05', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000211');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000212', 'Erika', 'Methol', 'Av. Millan', '7049', NULL, 'erika.methol212@sigeru.test', '099200212', '1977-04-16', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000212');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000213', 'Jorge', 'Rotela', '8 de Octubre', '7086', NULL, 'jorge.rotela213@sigeru.test', '099200213', '1978-11-27', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000213');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000214', 'Carlos', 'Brum', 'Av. Italia', '7123', NULL, 'carlos.brum214@sigeru.test', '099200214', '1979-06-10', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000214');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000215', 'Lucia', 'Soca', 'Av. 18 de Julio', '7160', NULL, 'lucia.soca215@sigeru.test', '099200215', '1980-01-21', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000215');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000216', 'Roberto', 'Estevez', 'Dante', '7197', NULL, 'roberto.estevez216@sigeru.test', '099200216', '1981-08-04', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000216');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000217', 'Victor', 'Perez', 'Carlos Maria de Pena', '7234', NULL, 'victor.perez217@sigeru.test', '099200217', '1982-03-15', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000217');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000218', 'Valentina', 'Alvarez', 'Camino Melilla', '7271', NULL, 'valentina.alvarez218@sigeru.test', '099200218', '1983-10-26', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000218');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000219', 'Mario', 'Correa', 'Av. Dr. Juan Pablo Fabini', '7308', NULL, 'mario.correa219@sigeru.test', '099200219', '1984-05-09', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000219');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000220', 'Adrian', 'Mendez', 'Durazno', '7345', NULL, 'adrian.mendez220@sigeru.test', '099200220', '1985-12-20', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000220');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000221', 'Camila', 'Cabrera', 'Industria', '7382', NULL, 'camila.cabrera221@sigeru.test', '099200221', '1986-07-03', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000221');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000222', 'Leandro', 'Coronel', 'Carlos Roxlo', '7419', NULL, 'leandro.coronel222@sigeru.test', '099200222', '1987-02-14', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000222');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000223', 'Maximo', 'Pereyra', 'Ellauri', '7456', NULL, 'maximo.pereyra223@sigeru.test', '099200223', '1988-09-25', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000223');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000224', 'Ines', 'Rivero', 'Rivera', '7493', NULL, 'ines.rivero224@sigeru.test', '099200224', '1989-04-08', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000224');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000225', 'Pablo', 'Acosta', 'Jacinto Vera', '530', NULL, 'pablo.acosta225@sigeru.test', '099200225', '1990-11-19', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000225');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000226', 'Luis', 'Methol', 'Camino Maldonado', '567', NULL, 'luis.methol226@sigeru.test', '099200226', '1991-06-02', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000226');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000227', 'Noelia', 'Rotela', 'Av. San Martin', '604', NULL, 'noelia.rotela227@sigeru.test', '099200227', '1992-01-13', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000227');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000228', 'Franco', 'Brum', 'Bulevar Artigas', '641', NULL, 'franco.brum228@sigeru.test', '099200228', '1993-08-24', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000228');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000229', 'Ignacio', 'Soca', 'Av. Millan', '678', NULL, 'ignacio.soca229@sigeru.test', '099200229', '1994-03-07', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000229');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000230', 'Carla', 'Estevez', '8 de Octubre', '715', NULL, 'carla.estevez230@sigeru.test', '099200230', '1995-10-18', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000230');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000231', 'Alan', 'Perez', 'Av. Italia', '752', NULL, 'alan.perez231@sigeru.test', '099200231', '1996-05-01', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000231');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000232', 'Yamandu', 'Alvarez', 'Av. 18 de Julio', '789', NULL, 'yamandu.alvarez232@sigeru.test', '099200232', '1997-12-12', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000232');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000233', 'Gimena', 'Correa', 'Dante', '826', NULL, 'gimena.correa233@sigeru.test', '099200233', '1998-07-23', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000233');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000234', 'Sebastian', 'Mendez', 'Carlos Maria de Pena', '863', NULL, 'sebastian.mendez234@sigeru.test', '099200234', '1999-02-06', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000234');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000235', 'Pedro', 'Cabrera', 'Camino Melilla', '900', NULL, 'pedro.cabrera235@sigeru.test', '099200235', '1975-09-17', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000235');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000236', 'Antonella', 'Coronel', 'Av. Dr. Juan Pablo Fabini', '937', NULL, 'antonella.coronel236@sigeru.test', '099200236', '1976-04-28', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000236');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000237', 'Elbio', 'Pereyra', 'Durazno', '974', NULL, 'elbio.pereyra237@sigeru.test', '099200237', '1977-11-11', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000237');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000238', 'Nicolas', 'Rivero', 'Industria', '1011', NULL, 'nicolas.rivero238@sigeru.test', '099200238', '1978-06-22', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000238');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000239', 'Melisa', 'Acosta', 'Carlos Roxlo', '1048', NULL, 'melisa.acosta239@sigeru.test', '099200239', '1979-01-05', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000239');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000240', 'Jose', 'Methol', 'Ellauri', '1085', NULL, 'jose.methol240@sigeru.test', '099200240', '1980-08-16', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000240');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000241', 'Angel', 'Rotela', 'Rivera', '1122', NULL, 'angel.rotela241@sigeru.test', '099200241', '1981-03-27', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000241');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000242', 'Victoria', 'Brum', 'Jacinto Vera', '1159', NULL, 'victoria.brum242@sigeru.test', '099200242', '1982-10-10', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000242');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000243', 'Walter', 'Soca', 'Camino Maldonado', '1196', NULL, 'walter.soca243@sigeru.test', '099200243', '1983-05-21', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000243');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000244', 'Guillermo', 'Estevez', 'Av. San Martin', '1233', NULL, 'guillermo.estevez244@sigeru.test', '099200244', '1984-12-04', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000244');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000245', 'Cecilia', 'Perez', 'Bulevar Artigas', '1270', NULL, 'cecilia.perez245@sigeru.test', '099200245', '1985-07-15', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000245');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000246', 'Alvaro', 'Alvarez', 'Av. Millan', '1307', NULL, 'alvaro.alvarez246@sigeru.test', '099200246', '1986-02-26', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000246');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000247', 'Nestor', 'Correa', '8 de Octubre', '1344', NULL, 'nestor.correa247@sigeru.test', '099200247', '1987-09-09', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000247');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000248', 'Daniela', 'Mendez', 'Av. Italia', '1381', NULL, 'daniela.mendez248@sigeru.test', '099200248', '1988-04-20', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000248');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000249', 'Hugo', 'Cabrera', 'Av. 18 de Julio', '1418', NULL, 'hugo.cabrera249@sigeru.test', '099200249', '1989-11-03', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000249');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000250', 'Ruben', 'Coronel', 'Dante', '1455', NULL, 'ruben.coronel250@sigeru.test', '099200250', '1990-06-14', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000250');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000251', 'Paola', 'Pereyra', 'Carlos Maria de Pena', '1492', NULL, 'paola.pereyra251@sigeru.test', '099200251', '1991-01-25', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000251');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000252', 'Washington', 'Rivero', 'Camino Melilla', '1529', NULL, 'washington.rivero252@sigeru.test', '099200252', '1992-08-08', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000252');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000253', 'Leonel', 'Acosta', 'Av. Dr. Juan Pablo Fabini', '1566', NULL, 'leonel.acosta253@sigeru.test', '099200253', '1993-03-19', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000253');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000254', 'Mariana', 'Methol', 'Durazno', '1603', NULL, 'mariana.methol254@sigeru.test', '099200254', '1994-10-02', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000254');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000255', 'Federico', 'Rotela', 'Industria', '1640', NULL, 'federico.rotela255@sigeru.test', '099200255', '1995-05-13', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000255');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000256', 'Richard', 'Brum', 'Carlos Roxlo', '1677', NULL, 'richard.brum256@sigeru.test', '099200256', '1996-12-24', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000256');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000257', 'Andrea', 'Soca', 'Ellauri', '1714', NULL, 'andrea.soca257@sigeru.test', '099200257', '1997-07-07', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000257');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000258', 'Cristian', 'Estevez', 'Rivera', '1751', NULL, 'cristian.estevez258@sigeru.test', '099200258', '1998-02-18', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000258');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000259', 'Julio', 'Perez', 'Jacinto Vera', '1788', NULL, 'julio.perez259@sigeru.test', '099200259', '1999-09-01', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000259');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000260', 'Patricia', 'Alvarez', 'Camino Maldonado', '1825', NULL, 'patricia.alvarez260@sigeru.test', '099200260', '1975-04-12', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000260');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000261', 'Wilson', 'Correa', 'Av. San Martin', '1862', NULL, 'wilson.correa261@sigeru.test', '099200261', '1976-11-23', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000261');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000262', 'Alfredo', 'Mendez', 'Bulevar Artigas', '1899', NULL, 'alfredo.mendez262@sigeru.test', '099200262', '1977-06-06', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000262');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000263', 'Gabriela', 'Cabrera', 'Av. Millan', '1936', NULL, 'gabriela.cabrera263@sigeru.test', '099200263', '1978-01-17', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000263');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000264', 'Danilo', 'Coronel', '8 de Octubre', '1973', NULL, 'danilo.coronel264@sigeru.test', '099200264', '1979-08-28', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000264');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000265', 'Marcos', 'Pereyra', 'Av. Italia', '2010', NULL, 'marcos.pereyra265@sigeru.test', '099200265', '1980-03-11', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000265');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000266', 'Silvana', 'Rivero', 'Av. 18 de Julio', '2047', NULL, 'silvana.rivero266@sigeru.test', '099200266', '1981-10-22', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000266');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000267', 'Emiliano', 'Acosta', 'Dante', '2084', NULL, 'emiliano.acosta267@sigeru.test', '099200267', '1982-05-05', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000267');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000268', 'Agustin', 'Methol', 'Carlos Maria de Pena', '2121', NULL, 'agustin.methol268@sigeru.test', '099200268', '1983-12-16', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000268');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000269', 'Estela', 'Rotela', 'Camino Melilla', '2158', NULL, 'estela.rotela269@sigeru.test', '099200269', '1984-07-27', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000269');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000270', 'Santiago', 'Brum', 'Av. Dr. Juan Pablo Fabini', '2195', NULL, 'santiago.brum270@sigeru.test', '099200270', '1985-02-10', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000270');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000271', 'Gaston', 'Soca', 'Durazno', '2232', NULL, 'gaston.soca271@sigeru.test', '099200271', '1986-09-21', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000271');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000272', 'Monica', 'Estevez', 'Industria', '2269', NULL, 'monica.estevez272@sigeru.test', '099200272', '1987-04-04', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000272');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000273', 'Bruno', 'Perez', 'Carlos Roxlo', '2306', NULL, 'bruno.perez273@sigeru.test', '099200273', '1988-11-15', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000273');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000274', 'Nahuel', 'Alvarez', 'Ellauri', '2343', NULL, 'nahuel.alvarez274@sigeru.test', '099200274', '1989-06-26', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000274');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000275', 'Adriana', 'Correa', 'Rivera', '2380', NULL, 'adriana.correa275@sigeru.test', '099200275', '1990-01-09', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000275');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000276', 'Joaquin', 'Mendez', 'Jacinto Vera', '2417', NULL, 'joaquin.mendez276@sigeru.test', '099200276', '1991-08-20', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000276');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000277', 'Tabare', 'Cabrera', 'Camino Maldonado', '2454', NULL, 'tabare.cabrera277@sigeru.test', '099200277', '1992-03-03', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000277');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000278', 'Veronica', 'Coronel', 'Av. San Martin', '2491', NULL, 'veronica.coronel278@sigeru.test', '099200278', '1993-10-14', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000278');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000279', 'Sergio', 'Pereyra', 'Bulevar Artigas', '2528', NULL, 'sergio.pereyra279@sigeru.test', '099200279', '1994-05-25', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000279');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000280', 'Fernando', 'Rivero', 'Av. Millan', '2565', NULL, 'fernando.rivero280@sigeru.test', '099200280', '1995-12-08', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000280');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000281', 'Natalia', 'Acosta', '8 de Octubre', '2602', NULL, 'natalia.acosta281@sigeru.test', '099200281', '1996-07-19', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000281');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000282', 'Pedro', 'Methol', 'Av. Italia', '2639', NULL, 'pedro.methol282@sigeru.test', '099200282', '1997-02-02', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000282');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000283', 'Jorge', 'Rotela', 'Av. 18 de Julio', '2676', NULL, 'jorge.rotela283@sigeru.test', '099200283', '1998-09-13', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000283');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000284', 'Alejandra', 'Brum', 'Dante', '2713', NULL, 'alejandra.brum284@sigeru.test', '099200284', '1999-04-24', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000284');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000285', 'Eduardo', 'Soca', 'Carlos Maria de Pena', '2750', NULL, 'eduardo.soca285@sigeru.test', '099200285', '1975-11-07', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000285');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000286', 'Roberto', 'Estevez', 'Camino Melilla', '2787', NULL, 'roberto.estevez286@sigeru.test', '099200286', '1976-06-18', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000286');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000287', 'Beatriz', 'Perez', 'Av. Dr. Juan Pablo Fabini', '2824', NULL, 'beatriz.perez287@sigeru.test', '099200287', '1977-01-01', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000287');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000288', 'Raul', 'Alvarez', 'Durazno', '2861', NULL, 'raul.alvarez288@sigeru.test', '099200288', '1978-08-12', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000288');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000289', 'Mario', 'Correa', 'Industria', '2898', NULL, 'mario.correa289@sigeru.test', '099200289', '1979-03-23', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000289');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000290', 'Clara', 'Mendez', 'Carlos Roxlo', '2935', NULL, 'clara.mendez290@sigeru.test', '099200290', '1980-10-06', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000290');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000291', 'Ariel', 'Cabrera', 'Ellauri', '2972', NULL, 'ariel.cabrera291@sigeru.test', '099200291', '1981-05-17', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000291');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000292', 'Leandro', 'Coronel', 'Rivera', '3009', NULL, 'leandro.coronel292@sigeru.test', '099200292', '1982-12-28', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000292');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000293', 'Elena', 'Pereyra', 'Jacinto Vera', '3046', NULL, 'elena.pereyra293@sigeru.test', '099200293', '1983-07-11', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000293');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000294', 'Ivan', 'Rivero', 'Camino Maldonado', '3083', NULL, 'ivan.rivero294@sigeru.test', '099200294', '1984-02-22', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000294');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000295', 'Pablo', 'Acosta', 'Av. San Martin', '3120', NULL, 'pablo.acosta295@sigeru.test', '099200295', '1985-09-05', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000295');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000296', 'Susana', 'Methol', 'Bulevar Artigas', '3157', NULL, 'susana.methol296@sigeru.test', '099200296', '1986-04-16', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000296');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000297', 'Enzo', 'Rotela', 'Av. Millan', '3194', NULL, 'enzo.rotela297@sigeru.test', '099200297', '1987-11-27', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000297');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000298', 'Franco', 'Brum', '8 de Octubre', '3231', NULL, 'franco.brum298@sigeru.test', '099200298', '1988-06-10', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000298');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000299', 'Rosana', 'Soca', 'Av. Italia', '3268', NULL, 'rosana.soca299@sigeru.test', '099200299', '1989-01-21', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000299');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000300', 'Maxi', 'Estevez', 'Av. 18 de Julio', '3305', NULL, 'maxi.estevez300@sigeru.test', '099200300', '1990-08-04', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000300');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000301', 'Alan', 'Perez', 'Dante', '3342', NULL, 'alan.perez301@sigeru.test', '099200301', '1991-03-15', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000301');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000302', 'Virginia', 'Alvarez', 'Carlos Maria de Pena', '3379', NULL, 'virginia.alvarez302@sigeru.test', '099200302', '1992-10-26', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000302');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000303', 'Dario', 'Correa', 'Camino Melilla', '3416', NULL, 'dario.correa303@sigeru.test', '099200303', '1993-05-09', 'activo', 'chofer'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000303');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000304', 'Sebastian', 'Mendez', 'Av. Dr. Juan Pablo Fabini', '3453', NULL, 'sebastian.mendez304@sigeru.test', '099200304', '1994-12-20', 'activo', 'jefeDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000304');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000305', 'Mariela', 'Cabrera', 'Durazno', '3490', NULL, 'mariela.cabrera305@sigeru.test', '099200305', '1995-07-03', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000305');

INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario)
SELECT '30000306', 'Horacio', 'Coronel', 'Industria', '3527', NULL, 'horacio.coronel306@sigeru.test', '099200306', '1996-02-14', 'activo', 'operarioDeCuadrilla'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE cedulaUsuario = '30000306');

-- inicioDeSesion para los 272 nuevos (mismo hash: Equipo2026!)
INSERT INTO inicioDeSesion (idUsuarioInicioDeSesion, contraseniaUsuarioInicioDeSesion)
SELECT u.cedulaUsuario, '$2y$12$OYGK9T.95E6qmuHAslorOOGtEacKdiYmSpgY227lB1ZlDMgorSHkW'
FROM usuario u
WHERE u.cedulaUsuario BETWEEN '30000035' AND '30000306'
  AND NOT EXISTS (SELECT 1 FROM inicioDeSesion s WHERE s.idUsuarioInicioDeSesion = u.cedulaUsuario);

-- operarioDeCuadrilla para los 272 nuevos (cargo = rolUsuario, igual que
-- crearPersonaConRol() en api-usuarios/index.php). idCuadrilla se completa
-- en la seccion 3, una vez creadas las cuadrillas.
INSERT INTO operarioDeCuadrilla (cedulaUsuario, estadoOperarioDeCuadrilla, cargoOperarioDeCuadrilla, turnoOperarioDeCuadrilla, horaInicioOperarioDeCuadrilla, horaFinOperarioDeCuadrilla, licenciaDeConducirOperarioDeCuadrilla, idCuadrilla)
SELECT u.cedulaUsuario, 'activo', u.rolUsuario,
       IF(u.cedulaUsuario IN ('30000035','30000036','30000039','30000040','30000043','30000044','30000047','30000048','30000051','30000052','30000055','30000056','30000059','30000060','30000063','30000064','30000067','30000068','30000071','30000072','30000075','30000076','30000079','30000080','30000083','30000084','30000087','30000088','30000091','30000092','30000095','30000096','30000099','30000100','30000103','30000104','30000107','30000108','30000111','30000112','30000115','30000116','30000119','30000120','30000123','30000124','30000127','30000128','30000131','30000132','30000135','30000136','30000139','30000140','30000143','30000144','30000147','30000148','30000151','30000152','30000155','30000156','30000159','30000160','30000163','30000164','30000167','30000168','30000171','30000172','30000175','30000176','30000179','30000180','30000183','30000184','30000187','30000188','30000191','30000192','30000195','30000196','30000199','30000200','30000203','30000204','30000207','30000208','30000211','30000212','30000215','30000216','30000219','30000220','30000223','30000224','30000227','30000228','30000231','30000232','30000235','30000236','30000239','30000240','30000243','30000244','30000247','30000248','30000251','30000252','30000255','30000256','30000259','30000260','30000263','30000264','30000267','30000268','30000271','30000272','30000275','30000276','30000279','30000280','30000283','30000284','30000287','30000288','30000291','30000292','30000295','30000296','30000299','30000300','30000303','30000304'), 'Mañana', 'Tarde'),
       IF(u.cedulaUsuario IN ('30000035','30000036','30000039','30000040','30000043','30000044','30000047','30000048','30000051','30000052','30000055','30000056','30000059','30000060','30000063','30000064','30000067','30000068','30000071','30000072','30000075','30000076','30000079','30000080','30000083','30000084','30000087','30000088','30000091','30000092','30000095','30000096','30000099','30000100','30000103','30000104','30000107','30000108','30000111','30000112','30000115','30000116','30000119','30000120','30000123','30000124','30000127','30000128','30000131','30000132','30000135','30000136','30000139','30000140','30000143','30000144','30000147','30000148','30000151','30000152','30000155','30000156','30000159','30000160','30000163','30000164','30000167','30000168','30000171','30000172','30000175','30000176','30000179','30000180','30000183','30000184','30000187','30000188','30000191','30000192','30000195','30000196','30000199','30000200','30000203','30000204','30000207','30000208','30000211','30000212','30000215','30000216','30000219','30000220','30000223','30000224','30000227','30000228','30000231','30000232','30000235','30000236','30000239','30000240','30000243','30000244','30000247','30000248','30000251','30000252','30000255','30000256','30000259','30000260','30000263','30000264','30000267','30000268','30000271','30000272','30000275','30000276','30000279','30000280','30000283','30000284','30000287','30000288','30000291','30000292','30000295','30000296','30000299','30000300','30000303','30000304'), '06:00:00', '14:00:00'),
       IF(u.cedulaUsuario IN ('30000035','30000036','30000039','30000040','30000043','30000044','30000047','30000048','30000051','30000052','30000055','30000056','30000059','30000060','30000063','30000064','30000067','30000068','30000071','30000072','30000075','30000076','30000079','30000080','30000083','30000084','30000087','30000088','30000091','30000092','30000095','30000096','30000099','30000100','30000103','30000104','30000107','30000108','30000111','30000112','30000115','30000116','30000119','30000120','30000123','30000124','30000127','30000128','30000131','30000132','30000135','30000136','30000139','30000140','30000143','30000144','30000147','30000148','30000151','30000152','30000155','30000156','30000159','30000160','30000163','30000164','30000167','30000168','30000171','30000172','30000175','30000176','30000179','30000180','30000183','30000184','30000187','30000188','30000191','30000192','30000195','30000196','30000199','30000200','30000203','30000204','30000207','30000208','30000211','30000212','30000215','30000216','30000219','30000220','30000223','30000224','30000227','30000228','30000231','30000232','30000235','30000236','30000239','30000240','30000243','30000244','30000247','30000248','30000251','30000252','30000255','30000256','30000259','30000260','30000263','30000264','30000267','30000268','30000271','30000272','30000275','30000276','30000279','30000280','30000283','30000284','30000287','30000288','30000291','30000292','30000295','30000296','30000299','30000300','30000303','30000304'), '14:00:00', '22:00:00'),
       IF(u.rolUsuario = 'chofer', 'Categoría D', NULL),
       NULL
FROM usuario u
WHERE u.cedulaUsuario BETWEEN '30000035' AND '30000306'
  AND NOT EXISTS (SELECT 1 FROM operarioDeCuadrilla o WHERE o.cedulaUsuario = u.cedulaUsuario);

-- ------------------------------------------------------------
-- 2. Flota nueva - 68 camiones, uno por chofer nuevo.
-- ------------------------------------------------------------

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2211', 'Iveco', 'Tector 170', 2014, 'disponible', 9.00, 'Service al día (último: 01/01/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000035')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2211');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2212', 'Volkswagen', 'Delivery Express', 2015, 'disponible', 6.50, 'Service al día (último: 04/06/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000039')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2212');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2213', 'Ford', 'Cargo 1119', 2016, 'disponible', 8.00, 'Service al día (último: 07/11/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000043')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2213');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2214', 'Iveco', 'Daily', 2017, 'disponible', 8.50, 'Service al día (último: 10/04/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000047')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2214');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2215', 'Ford', 'Cargo 1723', 2018, 'disponible', 10.00, 'Service al día (último: 13/09/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000051')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2215');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2216', 'Volkswagen', 'Constellation 17.280', 2019, 'disponible', 11.00, 'Service al día (último: 16/02/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000055')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2216');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2217', 'Iveco', 'Tector 240', 2020, 'disponible', 9.50, 'Service al día (último: 19/07/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000059')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2217');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2218', 'Ford', 'Cargo 815', 2021, 'disponible', 7.00, 'Service al día (último: 22/12/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000063')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2218');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2219', 'Iveco', 'Tector 170', 2022, 'disponible', 9.00, 'Service al día (último: 25/05/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000067')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2219');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2220', 'Volkswagen', 'Delivery Express', 2023, 'disponible', 6.50, 'Service al día (último: 28/10/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000071')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2220');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2221', 'Ford', 'Cargo 1119', 2024, 'disponible', 8.00, 'Service al día (último: 03/03/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000075')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2221');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2222', 'Iveco', 'Daily', 2014, 'disponible', 8.50, 'Service al día (último: 06/08/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000079')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2222');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2223', 'Ford', 'Cargo 1723', 2015, 'disponible', 10.00, 'Service al día (último: 09/01/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000083')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2223');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2224', 'Volkswagen', 'Constellation 17.280', 2016, 'disponible', 11.00, 'Service al día (último: 12/06/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000087')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2224');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2225', 'Iveco', 'Tector 240', 2017, 'disponible', 9.50, 'Service al día (último: 15/11/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000091')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2225');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2226', 'Ford', 'Cargo 815', 2018, 'disponible', 7.00, 'Service al día (último: 18/04/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000095')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2226');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2227', 'Iveco', 'Tector 170', 2019, 'disponible', 9.00, 'Service al día (último: 21/09/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000099')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2227');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2228', 'Volkswagen', 'Delivery Express', 2020, 'disponible', 6.50, 'Service al día (último: 24/02/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000103')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2228');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2229', 'Ford', 'Cargo 1119', 2021, 'disponible', 8.00, 'Service al día (último: 27/07/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000107')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2229');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2230', 'Iveco', 'Daily', 2022, 'disponible', 8.50, 'Service al día (último: 02/12/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000111')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2230');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2231', 'Ford', 'Cargo 1723', 2023, 'disponible', 10.00, 'Service al día (último: 05/05/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000115')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2231');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2232', 'Volkswagen', 'Constellation 17.280', 2024, 'disponible', 11.00, 'Service al día (último: 08/10/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000119')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2232');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2233', 'Iveco', 'Tector 240', 2014, 'disponible', 9.50, 'Service al día (último: 11/03/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000123')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2233');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2234', 'Ford', 'Cargo 815', 2015, 'disponible', 7.00, 'Service al día (último: 14/08/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000127')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2234');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2235', 'Iveco', 'Tector 170', 2016, 'disponible', 9.00, 'Service al día (último: 17/01/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000131')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2235');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2236', 'Volkswagen', 'Delivery Express', 2017, 'disponible', 6.50, 'Service al día (último: 20/06/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000135')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2236');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2237', 'Ford', 'Cargo 1119', 2018, 'disponible', 8.00, 'Service al día (último: 23/11/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000139')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2237');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2238', 'Iveco', 'Daily', 2019, 'disponible', 8.50, 'Service al día (último: 26/04/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000143')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2238');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2239', 'Ford', 'Cargo 1723', 2020, 'disponible', 10.00, 'Service al día (último: 01/09/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000147')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2239');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2240', 'Volkswagen', 'Constellation 17.280', 2021, 'disponible', 11.00, 'Service al día (último: 04/02/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000151')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2240');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2241', 'Iveco', 'Tector 240', 2022, 'disponible', 9.50, 'Service al día (último: 07/07/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000155')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2241');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2242', 'Ford', 'Cargo 815', 2023, 'disponible', 7.00, 'Service al día (último: 10/12/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000159')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2242');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2243', 'Iveco', 'Tector 170', 2024, 'disponible', 9.00, 'Service al día (último: 13/05/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000163')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2243');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2244', 'Volkswagen', 'Delivery Express', 2014, 'disponible', 6.50, 'Service al día (último: 16/10/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000167')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2244');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2245', 'Ford', 'Cargo 1119', 2015, 'disponible', 8.00, 'Service al día (último: 19/03/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000171')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2245');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2246', 'Iveco', 'Daily', 2016, 'disponible', 8.50, 'Service al día (último: 22/08/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000175')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2246');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2247', 'Ford', 'Cargo 1723', 2017, 'disponible', 10.00, 'Service al día (último: 25/01/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000179')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2247');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2248', 'Volkswagen', 'Constellation 17.280', 2018, 'disponible', 11.00, 'Service al día (último: 28/06/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000183')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2248');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2249', 'Iveco', 'Tector 240', 2019, 'disponible', 9.50, 'Service al día (último: 03/11/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000187')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2249');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2250', 'Ford', 'Cargo 815', 2020, 'disponible', 7.00, 'Service al día (último: 06/04/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000191')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2250');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2251', 'Iveco', 'Tector 170', 2021, 'disponible', 9.00, 'Service al día (último: 09/09/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000195')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2251');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2252', 'Volkswagen', 'Delivery Express', 2022, 'disponible', 6.50, 'Service al día (último: 12/02/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000199')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2252');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2253', 'Ford', 'Cargo 1119', 2023, 'disponible', 8.00, 'Service al día (último: 15/07/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000203')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2253');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2254', 'Iveco', 'Daily', 2024, 'disponible', 8.50, 'Service al día (último: 18/12/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000207')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2254');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2255', 'Ford', 'Cargo 1723', 2014, 'disponible', 10.00, 'Service al día (último: 21/05/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000211')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2255');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2256', 'Volkswagen', 'Constellation 17.280', 2015, 'disponible', 11.00, 'Service al día (último: 24/10/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000215')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2256');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2257', 'Iveco', 'Tector 240', 2016, 'disponible', 9.50, 'Service al día (último: 27/03/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000219')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2257');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2258', 'Ford', 'Cargo 815', 2017, 'disponible', 7.00, 'Service al día (último: 02/08/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000223')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2258');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2259', 'Iveco', 'Tector 170', 2018, 'disponible', 9.00, 'Service al día (último: 05/01/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000227')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2259');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2260', 'Volkswagen', 'Delivery Express', 2019, 'disponible', 6.50, 'Service al día (último: 08/06/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000231')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2260');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2261', 'Ford', 'Cargo 1119', 2020, 'disponible', 8.00, 'Service al día (último: 11/11/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000235')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2261');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2262', 'Iveco', 'Daily', 2021, 'disponible', 8.50, 'Service al día (último: 14/04/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000239')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2262');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2263', 'Ford', 'Cargo 1723', 2022, 'disponible', 10.00, 'Service al día (último: 17/09/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000243')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2263');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2264', 'Volkswagen', 'Constellation 17.280', 2023, 'disponible', 11.00, 'Service al día (último: 20/02/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000247')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2264');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2265', 'Iveco', 'Tector 240', 2024, 'disponible', 9.50, 'Service al día (último: 23/07/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000251')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2265');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2266', 'Ford', 'Cargo 815', 2014, 'disponible', 7.00, 'Service al día (último: 26/12/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000255')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2266');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2267', 'Iveco', 'Tector 170', 2015, 'disponible', 9.00, 'Service al día (último: 01/05/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000259')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2267');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2268', 'Volkswagen', 'Delivery Express', 2016, 'disponible', 6.50, 'Service al día (último: 04/10/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000263')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2268');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2269', 'Ford', 'Cargo 1119', 2017, 'disponible', 8.00, 'Service al día (último: 07/03/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000267')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2269');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2270', 'Iveco', 'Daily', 2018, 'disponible', 8.50, 'Service al día (último: 10/08/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000271')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2270');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2271', 'Ford', 'Cargo 1723', 2019, 'disponible', 10.00, 'Service al día (último: 13/01/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000275')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2271');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2272', 'Volkswagen', 'Constellation 17.280', 2020, 'disponible', 11.00, 'Service al día (último: 16/06/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000279')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2272');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2273', 'Iveco', 'Tector 240', 2021, 'disponible', 9.50, 'Service al día (último: 19/11/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000283')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2273');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2274', 'Ford', 'Cargo 815', 2022, 'disponible', 7.00, 'Service al día (último: 22/04/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000287')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2274');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2275', 'Iveco', 'Tector 170', 2023, 'disponible', 9.00, 'Service al día (último: 25/09/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000291')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2275');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2276', 'Volkswagen', 'Delivery Express', 2024, 'disponible', 6.50, 'Service al día (último: 28/02/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000295')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2276');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2277', 'Ford', 'Cargo 1119', 2014, 'disponible', 8.00, 'Service al día (último: 03/07/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000299')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2277');

INSERT INTO vehiculo (matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer)
SELECT 'SCA 2278', 'Iveco', 'Daily', 2015, 'disponible', 8.50, 'Service al día (último: 06/12/2026)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000303')
WHERE NOT EXISTS (SELECT 1 FROM vehiculo WHERE matriculaVehiculo = 'SCA 2278');

-- ------------------------------------------------------------
-- 3. Cuadrillas nuevas - 68, una por cada ruta real pendiente,
--    cada una con su chofer + jefe + 2 operarios + camion + la
--    ruta oficial correspondiente (identificada por su circuito).
-- ------------------------------------------------------------

SET @ruta_cob_0 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%E_DU_RM_CL_105%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Malvin (E_DU_RM_CL_105)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000035'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000036'),
    @ruta_cob_0, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Malvin (E_DU_RM_CL_105)');

SET @ruta_cob_1 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%A_DU_RM_CL_105%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Tres Ombues Pblo Victoria (A_DU_RM_CL_105)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000039'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000040'),
    @ruta_cob_1, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Tres Ombues Pblo Victoria (A_DU_RM_CL_105)');

SET @ruta_cob_2 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%A_DU_RM_CL_106%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla La Teja (A_DU_RM_CL_106)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000043'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000044'),
    @ruta_cob_2, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla La Teja (A_DU_RM_CL_106)');

SET @ruta_cob_3 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%A_DU_RM_CL_107%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Belvedere (A_DU_RM_CL_107)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000047'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000048'),
    @ruta_cob_3, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Belvedere (A_DU_RM_CL_107)');

SET @ruta_cob_4 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%A_DU_RM_CL_108%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Belvedere (A_DU_RM_CL_108)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000051'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000052'),
    @ruta_cob_4, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Belvedere (A_DU_RM_CL_108)');

SET @ruta_cob_5 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%A_DU_RM_CL_109%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Nuevo Paris (A_DU_RM_CL_109)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000055'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000056'),
    @ruta_cob_5, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Nuevo Paris (A_DU_RM_CL_109)');

SET @ruta_cob_6 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%A_DU_RM_CL_110%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Nuevo Paris (A_DU_RM_CL_110)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000059'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000060'),
    @ruta_cob_6, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Nuevo Paris (A_DU_RM_CL_110)');

SET @ruta_cob_7 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%A_DU_RM_CL_111%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Nuevo Paris (A_DU_RM_CL_111)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000063'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000064'),
    @ruta_cob_7, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Nuevo Paris (A_DU_RM_CL_111)');

SET @ruta_cob_8 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%A_DU_RM_CL_112%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla La Paloma Tomkinson (A_DU_RM_CL_112)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000067'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000068'),
    @ruta_cob_8, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla La Paloma Tomkinson (A_DU_RM_CL_112)');

SET @ruta_cob_9 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%A_DU_RM_CL_113%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla La Paloma Tomkinson (A_DU_RM_CL_113)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000071'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000072'),
    @ruta_cob_9, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla La Paloma Tomkinson (A_DU_RM_CL_113)');

SET @ruta_cob_10 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%A_DU_RM_CL_114%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla La Paloma Tomkinson (A_DU_RM_CL_114)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000075'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000076'),
    @ruta_cob_10, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla La Paloma Tomkinson (A_DU_RM_CL_114)');

SET @ruta_cob_11 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%A_DU_RM_CL_116%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Paso de la Arena (A_DU_RM_CL_116)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000079'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000080'),
    @ruta_cob_11, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Paso de la Arena (A_DU_RM_CL_116)');

SET @ruta_cob_12 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%B_DU_RM_CL_02%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Centro (B_DU_RM_CL_02)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000083'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000084'),
    @ruta_cob_12, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Centro (B_DU_RM_CL_02)');

SET @ruta_cob_13 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%C_DU_RM_CL_101%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Aguada (C_DU_RM_CL_101)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000087'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000088'),
    @ruta_cob_13, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Aguada (C_DU_RM_CL_101)');

SET @ruta_cob_14 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%C_DU_RM_CL_102%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Villa Muñoz Retiro (C_DU_RM_CL_102)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000091'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000092'),
    @ruta_cob_14, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Villa Muñoz Retiro (C_DU_RM_CL_102)');

SET @ruta_cob_15 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%C_DU_RM_CL_103%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla La Comercial (C_DU_RM_CL_103)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000095'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000096'),
    @ruta_cob_15, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla La Comercial (C_DU_RM_CL_103)');

SET @ruta_cob_16 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%C_DU_RM_CL_104%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Larranaga (C_DU_RM_CL_104)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000099'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000100'),
    @ruta_cob_16, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Larranaga (C_DU_RM_CL_104)');

SET @ruta_cob_17 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%C_DU_RM_CL_105%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Larranaga (C_DU_RM_CL_105)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000103'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000104'),
    @ruta_cob_17, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Larranaga (C_DU_RM_CL_105)');

SET @ruta_cob_18 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%C_DU_RM_CL_106%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Figurita (C_DU_RM_CL_106)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000107'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000108'),
    @ruta_cob_18, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Figurita (C_DU_RM_CL_106)');

SET @ruta_cob_19 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%C_DU_RM_CL_107%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Figurita (C_DU_RM_CL_107)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000111'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000112'),
    @ruta_cob_19, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Figurita (C_DU_RM_CL_107)');

SET @ruta_cob_20 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%C_DU_RM_CL_108%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Reducto (C_DU_RM_CL_108)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000115'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000116'),
    @ruta_cob_20, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Reducto (C_DU_RM_CL_108)');

SET @ruta_cob_21 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%C_DU_RM_CL_109%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Capurro Bella Vista (C_DU_RM_CL_109)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000119'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000120'),
    @ruta_cob_21, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Capurro Bella Vista (C_DU_RM_CL_109)');

SET @ruta_cob_22 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%D_DU_RM_CL_101%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Mercado Modelo y Bolivar (D_DU_RM_CL_101)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000123'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000124'),
    @ruta_cob_22, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Mercado Modelo y Bolivar (D_DU_RM_CL_101)');

SET @ruta_cob_23 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%D_DU_RM_CL_102%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Villa Espanola (D_DU_RM_CL_102)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000127'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000128'),
    @ruta_cob_23, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Villa Espanola (D_DU_RM_CL_102)');

SET @ruta_cob_24 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%D_DU_RM_CL_103%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Union (D_DU_RM_CL_103)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000131'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000132'),
    @ruta_cob_24, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Union (D_DU_RM_CL_103)');

SET @ruta_cob_25 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%D_DU_RM_CL_104%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Villa Espanola (D_DU_RM_CL_104)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000135'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000136'),
    @ruta_cob_25, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Villa Espanola (D_DU_RM_CL_104)');

SET @ruta_cob_26 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%D_DU_RM_CL_105%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Mercado Modelo y Bolivar (D_DU_RM_CL_105)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000139'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000140'),
    @ruta_cob_26, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Mercado Modelo y Bolivar (D_DU_RM_CL_105)');

SET @ruta_cob_27 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%D_DU_RM_CL_106%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Villa Espanola (D_DU_RM_CL_106)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000143'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000144'),
    @ruta_cob_27, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Villa Espanola (D_DU_RM_CL_106)');

SET @ruta_cob_28 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%D_DU_RM_CL_107%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Villa Espanola (D_DU_RM_CL_107)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000147'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000148'),
    @ruta_cob_28, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Villa Espanola (D_DU_RM_CL_107)');

SET @ruta_cob_29 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%D_DU_RM_CL_108%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Castro Castellanos (D_DU_RM_CL_108)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000151'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000152'),
    @ruta_cob_29, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Castro Castellanos (D_DU_RM_CL_108)');

SET @ruta_cob_30 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%D_DU_RM_CL_109%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Castro Castellanos (D_DU_RM_CL_109)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000155'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000156'),
    @ruta_cob_30, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Castro Castellanos (D_DU_RM_CL_109)');

SET @ruta_cob_31 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%D_DU_RM_CL_110%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Castro Castellanos (D_DU_RM_CL_110)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000159'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000160'),
    @ruta_cob_31, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Castro Castellanos (D_DU_RM_CL_110)');

SET @ruta_cob_32 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%D_DU_RM_CL_112%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Cerrito (D_DU_RM_CL_112)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000163'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000164'),
    @ruta_cob_32, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Cerrito (D_DU_RM_CL_112)');

SET @ruta_cob_33 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%D_DU_RM_CL_113%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Las Acacias (D_DU_RM_CL_113)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000167'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000168'),
    @ruta_cob_33, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Las Acacias (D_DU_RM_CL_113)');

SET @ruta_cob_34 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%D_DU_RM_CL_114%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Las Acacias (D_DU_RM_CL_114)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000171'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000172'),
    @ruta_cob_34, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Las Acacias (D_DU_RM_CL_114)');

SET @ruta_cob_35 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%D_DU_RM_CL_115%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Casavalle (D_DU_RM_CL_115)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000175'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000176'),
    @ruta_cob_35, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Casavalle (D_DU_RM_CL_115)');

SET @ruta_cob_36 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%D_DU_RM_CL_116%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Piedras Blancas (D_DU_RM_CL_116)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000179'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000180'),
    @ruta_cob_36, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Piedras Blancas (D_DU_RM_CL_116)');

SET @ruta_cob_37 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%D_DU_RM_CL_117%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Casavalle (D_DU_RM_CL_117)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000183'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000184'),
    @ruta_cob_37, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Casavalle (D_DU_RM_CL_117)');

SET @ruta_cob_38 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%D_DU_RM_CL_118%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Piedras Blancas (D_DU_RM_CL_118)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000187'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000188'),
    @ruta_cob_38, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Piedras Blancas (D_DU_RM_CL_118)');

SET @ruta_cob_39 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%D_DU_RM_CL_119%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Manga (D_DU_RM_CL_119)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000191'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000192'),
    @ruta_cob_39, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Manga (D_DU_RM_CL_119)');

SET @ruta_cob_40 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%D_DU_RM_CL_120%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Manga (D_DU_RM_CL_120)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000195'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000196'),
    @ruta_cob_40, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Manga (D_DU_RM_CL_120)');

SET @ruta_cob_41 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%E_DU_RM_CL_101%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Union (E_DU_RM_CL_101)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000199'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000200'),
    @ruta_cob_41, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Union (E_DU_RM_CL_101)');

SET @ruta_cob_42 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%E_DU_RM_CL_102%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Union (E_DU_RM_CL_102)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000203'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000204'),
    @ruta_cob_42, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Union (E_DU_RM_CL_102)');

SET @ruta_cob_43 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%E_DU_RM_CL_103%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Union (E_DU_RM_CL_103)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000207'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000208'),
    @ruta_cob_43, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Union (E_DU_RM_CL_103)');

SET @ruta_cob_44 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%E_DU_RM_CL_104%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Buceo (E_DU_RM_CL_104)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000211'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000212'),
    @ruta_cob_44, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Buceo (E_DU_RM_CL_104)');

SET @ruta_cob_45 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%E_DU_RM_CL_106%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Malvin (E_DU_RM_CL_106)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000215'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000216'),
    @ruta_cob_45, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Malvin (E_DU_RM_CL_106)');

SET @ruta_cob_46 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%E_DU_RM_CL_107%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Las Canteras (E_DU_RM_CL_107)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000219'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000220'),
    @ruta_cob_46, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Las Canteras (E_DU_RM_CL_107)');

SET @ruta_cob_47 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%E_DU_RM_CL_108%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Malvin (E_DU_RM_CL_108)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000223'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000224'),
    @ruta_cob_47, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Malvin (E_DU_RM_CL_108)');

SET @ruta_cob_48 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%E_DU_RM_CL_109%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Buceo (E_DU_RM_CL_109)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000227'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000228'),
    @ruta_cob_48, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Buceo (E_DU_RM_CL_109)');

SET @ruta_cob_49 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%E_DU_RM_CL_110%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Las Canteras (E_DU_RM_CL_110)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000231'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000232'),
    @ruta_cob_49, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Las Canteras (E_DU_RM_CL_110)');

SET @ruta_cob_50 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%E_DU_RM_CL_111%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Carrasco Norte (E_DU_RM_CL_111)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000235'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000236'),
    @ruta_cob_50, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Carrasco Norte (E_DU_RM_CL_111)');

SET @ruta_cob_51 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%E_DU_RM_CL_114%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Carrasco (E_DU_RM_CL_114)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000239'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000240'),
    @ruta_cob_51, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Carrasco (E_DU_RM_CL_114)');

SET @ruta_cob_52 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%E_DU_RM_CL_115%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Carrasco Norte (E_DU_RM_CL_115)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000243'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000244'),
    @ruta_cob_52, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Carrasco Norte (E_DU_RM_CL_115)');

SET @ruta_cob_53 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%E_DU_RM_CL_136%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Malvin Norte (E_DU_RM_CL_136)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000247'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000248'),
    @ruta_cob_53, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Malvin Norte (E_DU_RM_CL_136)');

SET @ruta_cob_54 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%G_DU_RM_CL_101%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Paso de las Duranas (G_DU_RM_CL_101)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000251'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000252'),
    @ruta_cob_54, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Paso de las Duranas (G_DU_RM_CL_101)');

SET @ruta_cob_55 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%G_DU_RM_CL_103%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Sayago (G_DU_RM_CL_103)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000255'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000256'),
    @ruta_cob_55, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Sayago (G_DU_RM_CL_103)');

SET @ruta_cob_56 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%G_DU_RM_CL_104%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_104)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000259'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000260'),
    @ruta_cob_56, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_104)');

SET @ruta_cob_57 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%G_DU_RM_CL_105%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_105)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000263'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000264'),
    @ruta_cob_57, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_105)');

SET @ruta_cob_58 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%G_DU_RM_CL_106%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Belvedere (G_DU_RM_CL_106)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000267'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000268'),
    @ruta_cob_58, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Belvedere (G_DU_RM_CL_106)');

SET @ruta_cob_59 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%G_DU_RM_CL_107%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Nuevo Paris (G_DU_RM_CL_107)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000271'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000272'),
    @ruta_cob_59, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Nuevo Paris (G_DU_RM_CL_107)');

SET @ruta_cob_60 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%G_DU_RM_CL_108%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_108)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000275'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000276'),
    @ruta_cob_60, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_108)');

SET @ruta_cob_61 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%G_DU_RM_CL_109%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_109)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000279'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000280'),
    @ruta_cob_61, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_109)');

SET @ruta_cob_62 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%G_DU_RM_CL_111%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Lezica Melilla (G_DU_RM_CL_111)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000283'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000284'),
    @ruta_cob_62, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Lezica Melilla (G_DU_RM_CL_111)');

SET @ruta_cob_63 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%G_DU_RM_CL_112%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_112)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000287'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000288'),
    @ruta_cob_63, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_112)');

SET @ruta_cob_64 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%G_DU_RM_CL_113%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Colon Centro y Noroeste (G_DU_RM_CL_113)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000291'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000292'),
    @ruta_cob_64, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Colon Centro y Noroeste (G_DU_RM_CL_113)');

SET @ruta_cob_65 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%G_DU_RM_CL_114%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Colon Centro y Noroeste (G_DU_RM_CL_114)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000295'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000296'),
    @ruta_cob_65, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Colon Centro y Noroeste (G_DU_RM_CL_114)');

SET @ruta_cob_66 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%G_DU_RM_CL_115%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_115)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000299'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000300'),
    @ruta_cob_66, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_115)');

SET @ruta_cob_67 := (SELECT idRuta FROM ruta WHERE recorridoRuta LIKE '%G_DU_RM_CL_116%' LIMIT 1);
INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idRuta, estadoCuadrilla)
SELECT 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_116)',
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000303'),
    (SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = '30000304'),
    @ruta_cob_67, 'activa'
WHERE NOT EXISTS (SELECT 1 FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_116)');

-- Completa el idCuadrilla de cada chofer/jefe/operario nuevo. UPDATE
-- directo por cedulaUsuario (columna con indice en la propia tabla),
-- sin JOIN, para no chocar con SQL_SAFE_UPDATES en MySQL Workbench.
-- Es un UPDATE puro - repetirlo no cambia nada.
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Malvin (E_DU_RM_CL_105)')
WHERE cedulaUsuario IN ('30000035','30000036','30000037','30000038');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Tres Ombues Pblo Victoria (A_DU_RM_CL_105)')
WHERE cedulaUsuario IN ('30000039','30000040','30000041','30000042');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla La Teja (A_DU_RM_CL_106)')
WHERE cedulaUsuario IN ('30000043','30000044','30000045','30000046');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Belvedere (A_DU_RM_CL_107)')
WHERE cedulaUsuario IN ('30000047','30000048','30000049','30000050');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Belvedere (A_DU_RM_CL_108)')
WHERE cedulaUsuario IN ('30000051','30000052','30000053','30000054');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Nuevo Paris (A_DU_RM_CL_109)')
WHERE cedulaUsuario IN ('30000055','30000056','30000057','30000058');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Nuevo Paris (A_DU_RM_CL_110)')
WHERE cedulaUsuario IN ('30000059','30000060','30000061','30000062');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Nuevo Paris (A_DU_RM_CL_111)')
WHERE cedulaUsuario IN ('30000063','30000064','30000065','30000066');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla La Paloma Tomkinson (A_DU_RM_CL_112)')
WHERE cedulaUsuario IN ('30000067','30000068','30000069','30000070');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla La Paloma Tomkinson (A_DU_RM_CL_113)')
WHERE cedulaUsuario IN ('30000071','30000072','30000073','30000074');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla La Paloma Tomkinson (A_DU_RM_CL_114)')
WHERE cedulaUsuario IN ('30000075','30000076','30000077','30000078');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Paso de la Arena (A_DU_RM_CL_116)')
WHERE cedulaUsuario IN ('30000079','30000080','30000081','30000082');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Centro (B_DU_RM_CL_02)')
WHERE cedulaUsuario IN ('30000083','30000084','30000085','30000086');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Aguada (C_DU_RM_CL_101)')
WHERE cedulaUsuario IN ('30000087','30000088','30000089','30000090');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Villa Muñoz Retiro (C_DU_RM_CL_102)')
WHERE cedulaUsuario IN ('30000091','30000092','30000093','30000094');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla La Comercial (C_DU_RM_CL_103)')
WHERE cedulaUsuario IN ('30000095','30000096','30000097','30000098');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Larranaga (C_DU_RM_CL_104)')
WHERE cedulaUsuario IN ('30000099','30000100','30000101','30000102');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Larranaga (C_DU_RM_CL_105)')
WHERE cedulaUsuario IN ('30000103','30000104','30000105','30000106');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Figurita (C_DU_RM_CL_106)')
WHERE cedulaUsuario IN ('30000107','30000108','30000109','30000110');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Figurita (C_DU_RM_CL_107)')
WHERE cedulaUsuario IN ('30000111','30000112','30000113','30000114');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Reducto (C_DU_RM_CL_108)')
WHERE cedulaUsuario IN ('30000115','30000116','30000117','30000118');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Capurro Bella Vista (C_DU_RM_CL_109)')
WHERE cedulaUsuario IN ('30000119','30000120','30000121','30000122');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Mercado Modelo y Bolivar (D_DU_RM_CL_101)')
WHERE cedulaUsuario IN ('30000123','30000124','30000125','30000126');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Villa Espanola (D_DU_RM_CL_102)')
WHERE cedulaUsuario IN ('30000127','30000128','30000129','30000130');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Union (D_DU_RM_CL_103)')
WHERE cedulaUsuario IN ('30000131','30000132','30000133','30000134');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Villa Espanola (D_DU_RM_CL_104)')
WHERE cedulaUsuario IN ('30000135','30000136','30000137','30000138');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Mercado Modelo y Bolivar (D_DU_RM_CL_105)')
WHERE cedulaUsuario IN ('30000139','30000140','30000141','30000142');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Villa Espanola (D_DU_RM_CL_106)')
WHERE cedulaUsuario IN ('30000143','30000144','30000145','30000146');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Villa Espanola (D_DU_RM_CL_107)')
WHERE cedulaUsuario IN ('30000147','30000148','30000149','30000150');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Castro Castellanos (D_DU_RM_CL_108)')
WHERE cedulaUsuario IN ('30000151','30000152','30000153','30000154');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Castro Castellanos (D_DU_RM_CL_109)')
WHERE cedulaUsuario IN ('30000155','30000156','30000157','30000158');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Castro Castellanos (D_DU_RM_CL_110)')
WHERE cedulaUsuario IN ('30000159','30000160','30000161','30000162');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Cerrito (D_DU_RM_CL_112)')
WHERE cedulaUsuario IN ('30000163','30000164','30000165','30000166');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Las Acacias (D_DU_RM_CL_113)')
WHERE cedulaUsuario IN ('30000167','30000168','30000169','30000170');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Las Acacias (D_DU_RM_CL_114)')
WHERE cedulaUsuario IN ('30000171','30000172','30000173','30000174');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Casavalle (D_DU_RM_CL_115)')
WHERE cedulaUsuario IN ('30000175','30000176','30000177','30000178');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Piedras Blancas (D_DU_RM_CL_116)')
WHERE cedulaUsuario IN ('30000179','30000180','30000181','30000182');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Casavalle (D_DU_RM_CL_117)')
WHERE cedulaUsuario IN ('30000183','30000184','30000185','30000186');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Piedras Blancas (D_DU_RM_CL_118)')
WHERE cedulaUsuario IN ('30000187','30000188','30000189','30000190');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Manga (D_DU_RM_CL_119)')
WHERE cedulaUsuario IN ('30000191','30000192','30000193','30000194');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Manga (D_DU_RM_CL_120)')
WHERE cedulaUsuario IN ('30000195','30000196','30000197','30000198');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Union (E_DU_RM_CL_101)')
WHERE cedulaUsuario IN ('30000199','30000200','30000201','30000202');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Union (E_DU_RM_CL_102)')
WHERE cedulaUsuario IN ('30000203','30000204','30000205','30000206');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Union (E_DU_RM_CL_103)')
WHERE cedulaUsuario IN ('30000207','30000208','30000209','30000210');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Buceo (E_DU_RM_CL_104)')
WHERE cedulaUsuario IN ('30000211','30000212','30000213','30000214');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Malvin (E_DU_RM_CL_106)')
WHERE cedulaUsuario IN ('30000215','30000216','30000217','30000218');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Las Canteras (E_DU_RM_CL_107)')
WHERE cedulaUsuario IN ('30000219','30000220','30000221','30000222');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Malvin (E_DU_RM_CL_108)')
WHERE cedulaUsuario IN ('30000223','30000224','30000225','30000226');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Buceo (E_DU_RM_CL_109)')
WHERE cedulaUsuario IN ('30000227','30000228','30000229','30000230');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Las Canteras (E_DU_RM_CL_110)')
WHERE cedulaUsuario IN ('30000231','30000232','30000233','30000234');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Carrasco Norte (E_DU_RM_CL_111)')
WHERE cedulaUsuario IN ('30000235','30000236','30000237','30000238');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Carrasco (E_DU_RM_CL_114)')
WHERE cedulaUsuario IN ('30000239','30000240','30000241','30000242');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Carrasco Norte (E_DU_RM_CL_115)')
WHERE cedulaUsuario IN ('30000243','30000244','30000245','30000246');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Malvin Norte (E_DU_RM_CL_136)')
WHERE cedulaUsuario IN ('30000247','30000248','30000249','30000250');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Paso de las Duranas (G_DU_RM_CL_101)')
WHERE cedulaUsuario IN ('30000251','30000252','30000253','30000254');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Sayago (G_DU_RM_CL_103)')
WHERE cedulaUsuario IN ('30000255','30000256','30000257','30000258');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_104)')
WHERE cedulaUsuario IN ('30000259','30000260','30000261','30000262');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_105)')
WHERE cedulaUsuario IN ('30000263','30000264','30000265','30000266');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Belvedere (G_DU_RM_CL_106)')
WHERE cedulaUsuario IN ('30000267','30000268','30000269','30000270');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Nuevo Paris (G_DU_RM_CL_107)')
WHERE cedulaUsuario IN ('30000271','30000272','30000273','30000274');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_108)')
WHERE cedulaUsuario IN ('30000275','30000276','30000277','30000278');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_109)')
WHERE cedulaUsuario IN ('30000279','30000280','30000281','30000282');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Lezica Melilla (G_DU_RM_CL_111)')
WHERE cedulaUsuario IN ('30000283','30000284','30000285','30000286');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_112)')
WHERE cedulaUsuario IN ('30000287','30000288','30000289','30000290');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Colon Centro y Noroeste (G_DU_RM_CL_113)')
WHERE cedulaUsuario IN ('30000291','30000292','30000293','30000294');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Colon Centro y Noroeste (G_DU_RM_CL_114)')
WHERE cedulaUsuario IN ('30000295','30000296','30000297','30000298');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_115)')
WHERE cedulaUsuario IN ('30000299','30000300','30000301','30000302');
UPDATE operarioDeCuadrilla
SET idCuadrilla = (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_116)')
WHERE cedulaUsuario IN ('30000303','30000304','30000305','30000306');

-- ------------------------------------------------------------
-- 4. Incidencias nuevas - una por cada cuadrilla/ruta nueva,
--    atada a un contenedor oficial existente en la misma zona
--    (zonaContenedor = zonaRuta), variando tipo y estado.
-- ------------------------------------------------------------

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Contenedor desbordado en Malvin, se acumulan bolsas en la vereda (circuito E_DU_RM_CL_105).', 'abierta', NULL, 'Contenedor desbordado', 'Malvin', DATE_SUB(NOW(), INTERVAL 1 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Malvin' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Contenedor desbordado en Malvin, se acumulan bolsas en la vereda (circuito E_DU_RM_CL_105).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El contenedor de Tres Ombues Pblo Victoria tiene daños visibles y pierde residuos (circuito A_DU_RM_CL_105).', 'asignada', 'vecino.cobertura1@example.com', 'Contenedor dañado', 'Tres Ombues Pblo Victoria', DATE_SUB(NOW(), INTERVAL 8 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Tres Ombues Pblo Victoria' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Tres Ombues Pblo Victoria (A_DU_RM_CL_105)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El contenedor de Tres Ombues Pblo Victoria tiene daños visibles y pierde residuos (circuito A_DU_RM_CL_105).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reporte de posible incendio junto a un contenedor en La Teja (circuito A_DU_RM_CL_106).', 'resuelta', 'vecino.cobertura2@example.com', 'Contenedor prendido fuego', 'La Teja', DATE_SUB(NOW(), INTERVAL 15 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'La Teja' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla La Teja (A_DU_RM_CL_106)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reporte de posible incendio junto a un contenedor en La Teja (circuito A_DU_RM_CL_106).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Hay residuos tirados fuera del contenedor en Belvedere (circuito A_DU_RM_CL_107).', 'abierta', NULL, 'Residuos fuera de lugar', 'Belvedere', DATE_SUB(NOW(), INTERVAL 22 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Belvedere' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Hay residuos tirados fuera del contenedor en Belvedere (circuito A_DU_RM_CL_107).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El camión de la cuadrilla de Belvedere tuvo un inconveniente en el recorrido (circuito A_DU_RM_CL_108).', 'asignada', 'vecino.cobertura4@example.com', 'Inconveniente en la ruta o el camión', 'Belvedere', DATE_SUB(NOW(), INTERVAL 29 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Belvedere' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Belvedere (A_DU_RM_CL_108)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El camión de la cuadrilla de Belvedere tuvo un inconveniente en el recorrido (circuito A_DU_RM_CL_108).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reclamo vecinal por recolección irregular en Nuevo Paris (circuito A_DU_RM_CL_109).', 'resuelta', 'vecino.cobertura5@example.com', 'Otra situación', 'Nuevo Paris', DATE_SUB(NOW(), INTERVAL 36 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Nuevo Paris' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Nuevo Paris (A_DU_RM_CL_109)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reclamo vecinal por recolección irregular en Nuevo Paris (circuito A_DU_RM_CL_109).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Contenedor desbordado en Nuevo Paris, se acumulan bolsas en la vereda (circuito A_DU_RM_CL_110).', 'abierta', NULL, 'Contenedor desbordado', 'Nuevo Paris', DATE_SUB(NOW(), INTERVAL 43 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Nuevo Paris' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Contenedor desbordado en Nuevo Paris, se acumulan bolsas en la vereda (circuito A_DU_RM_CL_110).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El contenedor de Nuevo Paris tiene daños visibles y pierde residuos (circuito A_DU_RM_CL_111).', 'asignada', 'vecino.cobertura7@example.com', 'Contenedor dañado', 'Nuevo Paris', DATE_SUB(NOW(), INTERVAL 50 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Nuevo Paris' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Nuevo Paris (A_DU_RM_CL_111)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El contenedor de Nuevo Paris tiene daños visibles y pierde residuos (circuito A_DU_RM_CL_111).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reporte de posible incendio junto a un contenedor en La Paloma Tomkinson (circuito A_DU_RM_CL_112).', 'resuelta', 'vecino.cobertura8@example.com', 'Contenedor prendido fuego', 'La Paloma Tomkinson', DATE_SUB(NOW(), INTERVAL 57 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'La Paloma Tomkinson' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla La Paloma Tomkinson (A_DU_RM_CL_112)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reporte de posible incendio junto a un contenedor en La Paloma Tomkinson (circuito A_DU_RM_CL_112).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Hay residuos tirados fuera del contenedor en La Paloma Tomkinson (circuito A_DU_RM_CL_113).', 'abierta', NULL, 'Residuos fuera de lugar', 'La Paloma Tomkinson', DATE_SUB(NOW(), INTERVAL 64 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'La Paloma Tomkinson' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Hay residuos tirados fuera del contenedor en La Paloma Tomkinson (circuito A_DU_RM_CL_113).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El camión de la cuadrilla de La Paloma Tomkinson tuvo un inconveniente en el recorrido (circuito A_DU_RM_CL_114).', 'asignada', 'vecino.cobertura10@example.com', 'Inconveniente en la ruta o el camión', 'La Paloma Tomkinson', DATE_SUB(NOW(), INTERVAL 71 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'La Paloma Tomkinson' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla La Paloma Tomkinson (A_DU_RM_CL_114)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El camión de la cuadrilla de La Paloma Tomkinson tuvo un inconveniente en el recorrido (circuito A_DU_RM_CL_114).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reclamo vecinal por recolección irregular en Paso de la Arena (circuito A_DU_RM_CL_116).', 'resuelta', 'vecino.cobertura11@example.com', 'Otra situación', 'Paso de la Arena', DATE_SUB(NOW(), INTERVAL 78 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Paso de la Arena' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Paso de la Arena (A_DU_RM_CL_116)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reclamo vecinal por recolección irregular en Paso de la Arena (circuito A_DU_RM_CL_116).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Contenedor desbordado en Centro, se acumulan bolsas en la vereda (circuito B_DU_RM_CL_02).', 'abierta', NULL, 'Contenedor desbordado', 'Centro', DATE_SUB(NOW(), INTERVAL 85 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Centro' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Contenedor desbordado en Centro, se acumulan bolsas en la vereda (circuito B_DU_RM_CL_02).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El contenedor de Aguada tiene daños visibles y pierde residuos (circuito C_DU_RM_CL_101).', 'asignada', 'vecino.cobertura13@example.com', 'Contenedor dañado', 'Aguada', DATE_SUB(NOW(), INTERVAL 92 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Aguada' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Aguada (C_DU_RM_CL_101)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El contenedor de Aguada tiene daños visibles y pierde residuos (circuito C_DU_RM_CL_101).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reporte de posible incendio junto a un contenedor en Villa Muñoz Retiro (circuito C_DU_RM_CL_102).', 'resuelta', 'vecino.cobertura14@example.com', 'Contenedor prendido fuego', 'Villa Muñoz Retiro', DATE_SUB(NOW(), INTERVAL 99 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Villa Muñoz Retiro' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Villa Muñoz Retiro (C_DU_RM_CL_102)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reporte de posible incendio junto a un contenedor en Villa Muñoz Retiro (circuito C_DU_RM_CL_102).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Hay residuos tirados fuera del contenedor en La Comercial (circuito C_DU_RM_CL_103).', 'abierta', NULL, 'Residuos fuera de lugar', 'La Comercial', DATE_SUB(NOW(), INTERVAL 106 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'La Comercial' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Hay residuos tirados fuera del contenedor en La Comercial (circuito C_DU_RM_CL_103).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El camión de la cuadrilla de Larranaga tuvo un inconveniente en el recorrido (circuito C_DU_RM_CL_104).', 'asignada', 'vecino.cobertura16@example.com', 'Inconveniente en la ruta o el camión', 'Larranaga', DATE_SUB(NOW(), INTERVAL 113 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Larranaga' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Larranaga (C_DU_RM_CL_104)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El camión de la cuadrilla de Larranaga tuvo un inconveniente en el recorrido (circuito C_DU_RM_CL_104).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reclamo vecinal por recolección irregular en Larranaga (circuito C_DU_RM_CL_105).', 'resuelta', 'vecino.cobertura17@example.com', 'Otra situación', 'Larranaga', DATE_SUB(NOW(), INTERVAL 120 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Larranaga' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Larranaga (C_DU_RM_CL_105)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reclamo vecinal por recolección irregular en Larranaga (circuito C_DU_RM_CL_105).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Contenedor desbordado en Figurita, se acumulan bolsas en la vereda (circuito C_DU_RM_CL_106).', 'abierta', NULL, 'Contenedor desbordado', 'Figurita', DATE_SUB(NOW(), INTERVAL 127 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Figurita' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Contenedor desbordado en Figurita, se acumulan bolsas en la vereda (circuito C_DU_RM_CL_106).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El contenedor de Figurita tiene daños visibles y pierde residuos (circuito C_DU_RM_CL_107).', 'asignada', 'vecino.cobertura19@example.com', 'Contenedor dañado', 'Figurita', DATE_SUB(NOW(), INTERVAL 134 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Figurita' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Figurita (C_DU_RM_CL_107)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El contenedor de Figurita tiene daños visibles y pierde residuos (circuito C_DU_RM_CL_107).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reporte de posible incendio junto a un contenedor en Reducto (circuito C_DU_RM_CL_108).', 'resuelta', 'vecino.cobertura20@example.com', 'Contenedor prendido fuego', 'Reducto', DATE_SUB(NOW(), INTERVAL 141 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Reducto' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Reducto (C_DU_RM_CL_108)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reporte de posible incendio junto a un contenedor en Reducto (circuito C_DU_RM_CL_108).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Hay residuos tirados fuera del contenedor en Capurro Bella Vista (circuito C_DU_RM_CL_109).', 'abierta', NULL, 'Residuos fuera de lugar', 'Capurro Bella Vista', DATE_SUB(NOW(), INTERVAL 148 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Capurro Bella Vista' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Hay residuos tirados fuera del contenedor en Capurro Bella Vista (circuito C_DU_RM_CL_109).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El camión de la cuadrilla de Mercado Modelo y Bolivar tuvo un inconveniente en el recorrido (circuito D_DU_RM_CL_101).', 'asignada', 'vecino.cobertura22@example.com', 'Inconveniente en la ruta o el camión', 'Mercado Modelo y Bolivar', DATE_SUB(NOW(), INTERVAL 155 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Mercado Modelo y Bolivar' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Mercado Modelo y Bolivar (D_DU_RM_CL_101)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El camión de la cuadrilla de Mercado Modelo y Bolivar tuvo un inconveniente en el recorrido (circuito D_DU_RM_CL_101).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reclamo vecinal por recolección irregular en Villa Espanola (circuito D_DU_RM_CL_102).', 'resuelta', 'vecino.cobertura23@example.com', 'Otra situación', 'Villa Espanola', DATE_SUB(NOW(), INTERVAL 162 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Villa Espanola' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Villa Espanola (D_DU_RM_CL_102)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reclamo vecinal por recolección irregular en Villa Espanola (circuito D_DU_RM_CL_102).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Contenedor desbordado en Union, se acumulan bolsas en la vereda (circuito D_DU_RM_CL_103).', 'abierta', NULL, 'Contenedor desbordado', 'Union', DATE_SUB(NOW(), INTERVAL 169 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Union' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Contenedor desbordado en Union, se acumulan bolsas en la vereda (circuito D_DU_RM_CL_103).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El contenedor de Villa Espanola tiene daños visibles y pierde residuos (circuito D_DU_RM_CL_104).', 'asignada', 'vecino.cobertura25@example.com', 'Contenedor dañado', 'Villa Espanola', DATE_SUB(NOW(), INTERVAL 176 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Villa Espanola' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Villa Espanola (D_DU_RM_CL_104)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El contenedor de Villa Espanola tiene daños visibles y pierde residuos (circuito D_DU_RM_CL_104).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reporte de posible incendio junto a un contenedor en Mercado Modelo y Bolivar (circuito D_DU_RM_CL_105).', 'resuelta', 'vecino.cobertura26@example.com', 'Contenedor prendido fuego', 'Mercado Modelo y Bolivar', DATE_SUB(NOW(), INTERVAL 183 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Mercado Modelo y Bolivar' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Mercado Modelo y Bolivar (D_DU_RM_CL_105)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reporte de posible incendio junto a un contenedor en Mercado Modelo y Bolivar (circuito D_DU_RM_CL_105).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Hay residuos tirados fuera del contenedor en Villa Espanola (circuito D_DU_RM_CL_106).', 'abierta', NULL, 'Residuos fuera de lugar', 'Villa Espanola', DATE_SUB(NOW(), INTERVAL 190 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Villa Espanola' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Hay residuos tirados fuera del contenedor en Villa Espanola (circuito D_DU_RM_CL_106).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El camión de la cuadrilla de Villa Espanola tuvo un inconveniente en el recorrido (circuito D_DU_RM_CL_107).', 'asignada', 'vecino.cobertura28@example.com', 'Inconveniente en la ruta o el camión', 'Villa Espanola', DATE_SUB(NOW(), INTERVAL 197 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Villa Espanola' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Villa Espanola (D_DU_RM_CL_107)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El camión de la cuadrilla de Villa Espanola tuvo un inconveniente en el recorrido (circuito D_DU_RM_CL_107).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reclamo vecinal por recolección irregular en Castro Castellanos (circuito D_DU_RM_CL_108).', 'resuelta', 'vecino.cobertura29@example.com', 'Otra situación', 'Castro Castellanos', DATE_SUB(NOW(), INTERVAL 204 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Castro Castellanos' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Castro Castellanos (D_DU_RM_CL_108)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reclamo vecinal por recolección irregular en Castro Castellanos (circuito D_DU_RM_CL_108).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Contenedor desbordado en Castro Castellanos, se acumulan bolsas en la vereda (circuito D_DU_RM_CL_109).', 'abierta', NULL, 'Contenedor desbordado', 'Castro Castellanos', DATE_SUB(NOW(), INTERVAL 211 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Castro Castellanos' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Contenedor desbordado en Castro Castellanos, se acumulan bolsas en la vereda (circuito D_DU_RM_CL_109).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El contenedor de Castro Castellanos tiene daños visibles y pierde residuos (circuito D_DU_RM_CL_110).', 'asignada', 'vecino.cobertura31@example.com', 'Contenedor dañado', 'Castro Castellanos', DATE_SUB(NOW(), INTERVAL 218 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Castro Castellanos' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Castro Castellanos (D_DU_RM_CL_110)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El contenedor de Castro Castellanos tiene daños visibles y pierde residuos (circuito D_DU_RM_CL_110).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reporte de posible incendio junto a un contenedor en Cerrito (circuito D_DU_RM_CL_112).', 'resuelta', 'vecino.cobertura32@example.com', 'Contenedor prendido fuego', 'Cerrito', DATE_SUB(NOW(), INTERVAL 225 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Cerrito' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Cerrito (D_DU_RM_CL_112)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reporte de posible incendio junto a un contenedor en Cerrito (circuito D_DU_RM_CL_112).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Hay residuos tirados fuera del contenedor en Las Acacias (circuito D_DU_RM_CL_113).', 'abierta', NULL, 'Residuos fuera de lugar', 'Las Acacias', DATE_SUB(NOW(), INTERVAL 232 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Las Acacias' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Hay residuos tirados fuera del contenedor en Las Acacias (circuito D_DU_RM_CL_113).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El camión de la cuadrilla de Las Acacias tuvo un inconveniente en el recorrido (circuito D_DU_RM_CL_114).', 'asignada', 'vecino.cobertura34@example.com', 'Inconveniente en la ruta o el camión', 'Las Acacias', DATE_SUB(NOW(), INTERVAL 239 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Las Acacias' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Las Acacias (D_DU_RM_CL_114)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El camión de la cuadrilla de Las Acacias tuvo un inconveniente en el recorrido (circuito D_DU_RM_CL_114).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reclamo vecinal por recolección irregular en Casavalle (circuito D_DU_RM_CL_115).', 'resuelta', 'vecino.cobertura35@example.com', 'Otra situación', 'Casavalle', DATE_SUB(NOW(), INTERVAL 6 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Casavalle' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Casavalle (D_DU_RM_CL_115)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reclamo vecinal por recolección irregular en Casavalle (circuito D_DU_RM_CL_115).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Contenedor desbordado en Piedras Blancas, se acumulan bolsas en la vereda (circuito D_DU_RM_CL_116).', 'abierta', NULL, 'Contenedor desbordado', 'Piedras Blancas', DATE_SUB(NOW(), INTERVAL 13 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Piedras Blancas' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Contenedor desbordado en Piedras Blancas, se acumulan bolsas en la vereda (circuito D_DU_RM_CL_116).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El contenedor de Casavalle tiene daños visibles y pierde residuos (circuito D_DU_RM_CL_117).', 'asignada', 'vecino.cobertura37@example.com', 'Contenedor dañado', 'Casavalle', DATE_SUB(NOW(), INTERVAL 20 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Casavalle' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Casavalle (D_DU_RM_CL_117)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El contenedor de Casavalle tiene daños visibles y pierde residuos (circuito D_DU_RM_CL_117).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reporte de posible incendio junto a un contenedor en Piedras Blancas (circuito D_DU_RM_CL_118).', 'resuelta', 'vecino.cobertura38@example.com', 'Contenedor prendido fuego', 'Piedras Blancas', DATE_SUB(NOW(), INTERVAL 27 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Piedras Blancas' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Piedras Blancas (D_DU_RM_CL_118)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reporte de posible incendio junto a un contenedor en Piedras Blancas (circuito D_DU_RM_CL_118).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Hay residuos tirados fuera del contenedor en Manga (circuito D_DU_RM_CL_119).', 'abierta', NULL, 'Residuos fuera de lugar', 'Manga', DATE_SUB(NOW(), INTERVAL 34 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Manga' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Hay residuos tirados fuera del contenedor en Manga (circuito D_DU_RM_CL_119).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El camión de la cuadrilla de Manga tuvo un inconveniente en el recorrido (circuito D_DU_RM_CL_120).', 'asignada', 'vecino.cobertura40@example.com', 'Inconveniente en la ruta o el camión', 'Manga', DATE_SUB(NOW(), INTERVAL 41 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Manga' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Manga (D_DU_RM_CL_120)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El camión de la cuadrilla de Manga tuvo un inconveniente en el recorrido (circuito D_DU_RM_CL_120).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reclamo vecinal por recolección irregular en Union (circuito E_DU_RM_CL_101).', 'resuelta', 'vecino.cobertura41@example.com', 'Otra situación', 'Union', DATE_SUB(NOW(), INTERVAL 48 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Union' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Union (E_DU_RM_CL_101)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reclamo vecinal por recolección irregular en Union (circuito E_DU_RM_CL_101).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Contenedor desbordado en Union, se acumulan bolsas en la vereda (circuito E_DU_RM_CL_102).', 'abierta', NULL, 'Contenedor desbordado', 'Union', DATE_SUB(NOW(), INTERVAL 55 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Union' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Contenedor desbordado en Union, se acumulan bolsas en la vereda (circuito E_DU_RM_CL_102).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El contenedor de Union tiene daños visibles y pierde residuos (circuito E_DU_RM_CL_103).', 'asignada', 'vecino.cobertura43@example.com', 'Contenedor dañado', 'Union', DATE_SUB(NOW(), INTERVAL 62 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Union' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Union (E_DU_RM_CL_103)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El contenedor de Union tiene daños visibles y pierde residuos (circuito E_DU_RM_CL_103).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reporte de posible incendio junto a un contenedor en Buceo (circuito E_DU_RM_CL_104).', 'resuelta', 'vecino.cobertura44@example.com', 'Contenedor prendido fuego', 'Buceo', DATE_SUB(NOW(), INTERVAL 69 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Buceo' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Buceo (E_DU_RM_CL_104)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reporte de posible incendio junto a un contenedor en Buceo (circuito E_DU_RM_CL_104).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Hay residuos tirados fuera del contenedor en Malvin (circuito E_DU_RM_CL_106).', 'abierta', NULL, 'Residuos fuera de lugar', 'Malvin', DATE_SUB(NOW(), INTERVAL 76 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Malvin' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Hay residuos tirados fuera del contenedor en Malvin (circuito E_DU_RM_CL_106).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El camión de la cuadrilla de Las Canteras tuvo un inconveniente en el recorrido (circuito E_DU_RM_CL_107).', 'asignada', 'vecino.cobertura46@example.com', 'Inconveniente en la ruta o el camión', 'Las Canteras', DATE_SUB(NOW(), INTERVAL 83 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Las Canteras' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Las Canteras (E_DU_RM_CL_107)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El camión de la cuadrilla de Las Canteras tuvo un inconveniente en el recorrido (circuito E_DU_RM_CL_107).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reclamo vecinal por recolección irregular en Malvin (circuito E_DU_RM_CL_108).', 'resuelta', 'vecino.cobertura47@example.com', 'Otra situación', 'Malvin', DATE_SUB(NOW(), INTERVAL 90 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Malvin' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Malvin (E_DU_RM_CL_108)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reclamo vecinal por recolección irregular en Malvin (circuito E_DU_RM_CL_108).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Contenedor desbordado en Buceo, se acumulan bolsas en la vereda (circuito E_DU_RM_CL_109).', 'abierta', NULL, 'Contenedor desbordado', 'Buceo', DATE_SUB(NOW(), INTERVAL 97 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Buceo' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Contenedor desbordado en Buceo, se acumulan bolsas en la vereda (circuito E_DU_RM_CL_109).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El contenedor de Las Canteras tiene daños visibles y pierde residuos (circuito E_DU_RM_CL_110).', 'asignada', 'vecino.cobertura49@example.com', 'Contenedor dañado', 'Las Canteras', DATE_SUB(NOW(), INTERVAL 104 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Las Canteras' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Las Canteras (E_DU_RM_CL_110)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El contenedor de Las Canteras tiene daños visibles y pierde residuos (circuito E_DU_RM_CL_110).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reporte de posible incendio junto a un contenedor en Carrasco Norte (circuito E_DU_RM_CL_111).', 'resuelta', 'vecino.cobertura50@example.com', 'Contenedor prendido fuego', 'Carrasco Norte', DATE_SUB(NOW(), INTERVAL 111 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Carrasco Norte' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Carrasco Norte (E_DU_RM_CL_111)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reporte de posible incendio junto a un contenedor en Carrasco Norte (circuito E_DU_RM_CL_111).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Hay residuos tirados fuera del contenedor en Carrasco (circuito E_DU_RM_CL_114).', 'abierta', NULL, 'Residuos fuera de lugar', 'Carrasco', DATE_SUB(NOW(), INTERVAL 118 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Carrasco' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Hay residuos tirados fuera del contenedor en Carrasco (circuito E_DU_RM_CL_114).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El camión de la cuadrilla de Carrasco Norte tuvo un inconveniente en el recorrido (circuito E_DU_RM_CL_115).', 'asignada', 'vecino.cobertura52@example.com', 'Inconveniente en la ruta o el camión', 'Carrasco Norte', DATE_SUB(NOW(), INTERVAL 125 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Carrasco Norte' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Carrasco Norte (E_DU_RM_CL_115)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El camión de la cuadrilla de Carrasco Norte tuvo un inconveniente en el recorrido (circuito E_DU_RM_CL_115).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reclamo vecinal por recolección irregular en Malvin Norte (circuito E_DU_RM_CL_136).', 'resuelta', 'vecino.cobertura53@example.com', 'Otra situación', 'Malvin Norte', DATE_SUB(NOW(), INTERVAL 132 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Malvin Norte' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Malvin Norte (E_DU_RM_CL_136)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reclamo vecinal por recolección irregular en Malvin Norte (circuito E_DU_RM_CL_136).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Contenedor desbordado en Paso de las Duranas, se acumulan bolsas en la vereda (circuito G_DU_RM_CL_101).', 'abierta', NULL, 'Contenedor desbordado', 'Paso de las Duranas', DATE_SUB(NOW(), INTERVAL 139 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Paso de las Duranas' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Contenedor desbordado en Paso de las Duranas, se acumulan bolsas en la vereda (circuito G_DU_RM_CL_101).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El contenedor de Sayago tiene daños visibles y pierde residuos (circuito G_DU_RM_CL_103).', 'asignada', 'vecino.cobertura55@example.com', 'Contenedor dañado', 'Sayago', DATE_SUB(NOW(), INTERVAL 146 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Sayago' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Sayago (G_DU_RM_CL_103)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El contenedor de Sayago tiene daños visibles y pierde residuos (circuito G_DU_RM_CL_103).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reporte de posible incendio junto a un contenedor en Penarol Lavalleja (circuito G_DU_RM_CL_104).', 'resuelta', 'vecino.cobertura56@example.com', 'Contenedor prendido fuego', 'Penarol Lavalleja', DATE_SUB(NOW(), INTERVAL 153 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Penarol Lavalleja' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_104)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reporte de posible incendio junto a un contenedor en Penarol Lavalleja (circuito G_DU_RM_CL_104).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Hay residuos tirados fuera del contenedor en Penarol Lavalleja (circuito G_DU_RM_CL_105).', 'abierta', NULL, 'Residuos fuera de lugar', 'Penarol Lavalleja', DATE_SUB(NOW(), INTERVAL 160 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Penarol Lavalleja' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Hay residuos tirados fuera del contenedor en Penarol Lavalleja (circuito G_DU_RM_CL_105).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El camión de la cuadrilla de Belvedere tuvo un inconveniente en el recorrido (circuito G_DU_RM_CL_106).', 'asignada', 'vecino.cobertura58@example.com', 'Inconveniente en la ruta o el camión', 'Belvedere', DATE_SUB(NOW(), INTERVAL 167 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Belvedere' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Belvedere (G_DU_RM_CL_106)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El camión de la cuadrilla de Belvedere tuvo un inconveniente en el recorrido (circuito G_DU_RM_CL_106).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reclamo vecinal por recolección irregular en Nuevo Paris (circuito G_DU_RM_CL_107).', 'resuelta', 'vecino.cobertura59@example.com', 'Otra situación', 'Nuevo Paris', DATE_SUB(NOW(), INTERVAL 174 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Nuevo Paris' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Nuevo Paris (G_DU_RM_CL_107)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reclamo vecinal por recolección irregular en Nuevo Paris (circuito G_DU_RM_CL_107).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Contenedor desbordado en Penarol Lavalleja, se acumulan bolsas en la vereda (circuito G_DU_RM_CL_108).', 'abierta', NULL, 'Contenedor desbordado', 'Penarol Lavalleja', DATE_SUB(NOW(), INTERVAL 181 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Penarol Lavalleja' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Contenedor desbordado en Penarol Lavalleja, se acumulan bolsas en la vereda (circuito G_DU_RM_CL_108).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El contenedor de Penarol Lavalleja tiene daños visibles y pierde residuos (circuito G_DU_RM_CL_109).', 'asignada', 'vecino.cobertura61@example.com', 'Contenedor dañado', 'Penarol Lavalleja', DATE_SUB(NOW(), INTERVAL 188 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Penarol Lavalleja' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_109)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El contenedor de Penarol Lavalleja tiene daños visibles y pierde residuos (circuito G_DU_RM_CL_109).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reporte de posible incendio junto a un contenedor en Lezica Melilla (circuito G_DU_RM_CL_111).', 'resuelta', 'vecino.cobertura62@example.com', 'Contenedor prendido fuego', 'Lezica Melilla', DATE_SUB(NOW(), INTERVAL 195 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Lezica Melilla' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Lezica Melilla (G_DU_RM_CL_111)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reporte de posible incendio junto a un contenedor en Lezica Melilla (circuito G_DU_RM_CL_111).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Hay residuos tirados fuera del contenedor en Penarol Lavalleja (circuito G_DU_RM_CL_112).', 'abierta', NULL, 'Residuos fuera de lugar', 'Penarol Lavalleja', DATE_SUB(NOW(), INTERVAL 202 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Penarol Lavalleja' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Hay residuos tirados fuera del contenedor en Penarol Lavalleja (circuito G_DU_RM_CL_112).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El camión de la cuadrilla de Colon Centro y Noroeste tuvo un inconveniente en el recorrido (circuito G_DU_RM_CL_113).', 'asignada', 'vecino.cobertura64@example.com', 'Inconveniente en la ruta o el camión', 'Colon Centro y Noroeste', DATE_SUB(NOW(), INTERVAL 209 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Colon Centro y Noroeste' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Colon Centro y Noroeste (G_DU_RM_CL_113)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El camión de la cuadrilla de Colon Centro y Noroeste tuvo un inconveniente en el recorrido (circuito G_DU_RM_CL_113).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Reclamo vecinal por recolección irregular en Colon Centro y Noroeste (circuito G_DU_RM_CL_114).', 'resuelta', 'vecino.cobertura65@example.com', 'Otra situación', 'Colon Centro y Noroeste', DATE_SUB(NOW(), INTERVAL 216 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Colon Centro y Noroeste' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Colon Centro y Noroeste (G_DU_RM_CL_114)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Reclamo vecinal por recolección irregular en Colon Centro y Noroeste (circuito G_DU_RM_CL_114).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'Contenedor desbordado en Penarol Lavalleja, se acumulan bolsas en la vereda (circuito G_DU_RM_CL_115).', 'abierta', NULL, 'Contenedor desbordado', 'Penarol Lavalleja', DATE_SUB(NOW(), INTERVAL 223 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Penarol Lavalleja' ORDER BY idContenedor LIMIT 1),
    NULL
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'Contenedor desbordado en Penarol Lavalleja, se acumulan bolsas en la vereda (circuito G_DU_RM_CL_115).');

INSERT INTO incidencia (descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla)
SELECT 'El contenedor de Penarol Lavalleja tiene daños visibles y pierde residuos (circuito G_DU_RM_CL_116).', 'asignada', 'vecino.cobertura67@example.com', 'Contenedor dañado', 'Penarol Lavalleja', DATE_SUB(NOW(), INTERVAL 230 HOUR),
    (SELECT idContenedor FROM contenedor WHERE zonaContenedor = 'Penarol Lavalleja' ORDER BY idContenedor LIMIT 1),
    (SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = 'Cuadrilla Penarol Lavalleja (G_DU_RM_CL_116)')
WHERE NOT EXISTS (SELECT 1 FROM incidencia WHERE descripcionIncidencia = 'El contenedor de Penarol Lavalleja tiene daños visibles y pierde residuos (circuito G_DU_RM_CL_116).');

COMMIT;

-- ============================================================
-- Listo. Se agregaron 272 funcionarios (68 choferes, 68 jefes
-- de cuadrilla, 136 operarios), 68 camiones, 68 cuadrillas nuevas
-- (una por cada ruta real pendiente) y 68 incidencias. Junto con lo
-- que ya traian 02/03, quedan cubiertas las 73 rutas con datos reales
-- (horario y frecuencia reales) con cuadrilla + camion asignados.
-- Contraseña de las 272 cuentas nuevas: Equipo2026!
-- ============================================================
