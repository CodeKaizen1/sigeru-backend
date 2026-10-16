<?php
require_once __DIR__ . "/../Application/Controller/IncidenciaController.php";
require_once __DIR__ . "/../Application/Model/Incidencia.php";
require_once __DIR__ . "/../Application/Controller/ContenedorController.php";
require_once __DIR__ . "/../Application/Model/Contenedor.php";
require_once __DIR__ . "/../Application/Controller/NotificacionController.php";
require_once __DIR__ . "/../Configuration/Conexion.php";

// Reporte de incidencia real, contra la base que apunte el .env de esta carpeta.
class IncidenciaControllerTest
{
    private $conexion;
    private $idContenedor;
    private $idIncidencia;
    private $idCuadrilla;

    public function antes()
    {
        $this->conexion = (new Conexion())->conectar();
        $ubicacion = 'Contenedor de prueba ' . uniqid();
        (new ContenedorController())->crear(new Contenedor(null, $ubicacion, 'operativo', 1100, 'organico'));

        // El controller abre su propia conexión PDO, distinta de la de este
        // test - lastInsertId() es por conexión, así que hay que buscar el
        // id por un dato único en vez de confiar en lastInsertId() acá.
        $stmt = $this->conexion->prepare("SELECT idContenedor FROM contenedor WHERE ubicacionContenedor = ?");
        $stmt->execute([$ubicacion]);
        $this->idContenedor = (int) $stmt->fetchColumn();

        // Cuadrilla "pelada" (sin chofer/jefe/vehículo/ruta, todos nullable) --
        // alcanza con que exista para probar las notificaciones del punto 16,
        // no hace falta la cuadrilla completa que arma NotificacionControllerTest.
        $nombreCuadrilla = 'Cuadrilla test incidencia ' . uniqid();
        $this->conexion->prepare("INSERT INTO cuadrilla (nombreCuadrilla) VALUES (?)")->execute([$nombreCuadrilla]);
        $stmtCuadrilla = $this->conexion->prepare("SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = ?");
        $stmtCuadrilla->execute([$nombreCuadrilla]);
        $this->idCuadrilla = (int) $stmtCuadrilla->fetchColumn();
    }

    public function despues()
    {
        // Las notificaciones primero (por idEntidadNotificacion == idIncidencia),
        // antes de borrar la incidencia -- y de nuevo por idCuadrillaNotificacion
        // como red de seguridad, por si alguna quedó con otro idEntidadNotificacion.
        if ($this->idIncidencia) {
            $this->conexion->prepare("DELETE FROM notificacion WHERE idEntidadNotificacion = ?")->execute([$this->idIncidencia]);
            $this->conexion->prepare("DELETE FROM incidencia WHERE idIncidencia = ?")->execute([$this->idIncidencia]);
        }
        $this->conexion->prepare("DELETE FROM notificacion WHERE idCuadrillaNotificacion = ?")->execute([$this->idCuadrilla]);
        $this->conexion->prepare("DELETE FROM cuadrilla WHERE idCuadrilla = ?")->execute([$this->idCuadrilla]);
        $this->conexion->prepare("DELETE FROM contenedor WHERE idContenedor = ?")->execute([$this->idContenedor]);
    }

    public function testCrearDevuelveElIdNuevo()
    {
        $controller = new IncidenciaController();
        $id = $controller->crear(new Incidencia(null, 'Huele mal', 'abierta', 'vecino@x.com', 'olor', 'Zona test', date('Y-m-d H:i:s'), $this->idContenedor, null));
        $this->idIncidencia = $id;

        MiniTest::afirmar(is_int($id) && $id > 0, "debería devolver un id entero positivo");

        $fila = $controller->obtenerPorId($id);
        MiniTest::afirmarIgual('abierta', $fila['estadoIncidencia'] ?? null, "queda abierta como se mandó");
        MiniTest::afirmarIgual($this->idContenedor, (int) $fila['idContenedor'], "debería quedar asociada al contenedor");
    }

    // Punto 16: toda incidencia nueva genera notificación para admin; si ya
    // viene con cuadrilla asignada (reporte del jefe para su propia cuadrilla),
    // esa cuadrilla también recibe la suya.
    public function testCrearConCuadrillaNotificaAlAdminYALaCuadrilla()
    {
        $controller = new IncidenciaController();
        $id = $controller->crear(new Incidencia(null, 'Contenedor desbordado', 'abierta', null, 'desborde', 'Zona test', date('Y-m-d H:i:s'), $this->idContenedor, $this->idCuadrilla));
        $this->idIncidencia = $id;

        $notificaciones = new NotificacionController();
        $paraAdmin = $notificaciones->obtenerParaAdmin();
        $paraCuadrilla = $notificaciones->obtenerParaCuadrilla($this->idCuadrilla);

        $tieneAdmin = false;
        foreach ($paraAdmin as $fila) {
            if ((int) ($fila['idEntidadNotificacion'] ?? 0) === $id) $tieneAdmin = true;
        }
        $tieneCuadrilla = false;
        foreach ($paraCuadrilla as $fila) {
            if ((int) ($fila['idEntidadNotificacion'] ?? 0) === $id) $tieneCuadrilla = true;
        }

        MiniTest::afirmar($tieneAdmin, "debería notificar al admin al crear cualquier incidencia nueva");
        MiniTest::afirmar($tieneCuadrilla, "debería notificar a la cuadrilla si ya viene asignada al crearla");
    }

    // Asignar cuadrilla vía modificar() (el flujo real de asignarCuadrillaAIncidencia()
    // en model.js) debería notificar a la cuadrilla recién asignada.
    public function testModificarAsignarCuadrillaNotificaALaCuadrilla()
    {
        $controller = new IncidenciaController();
        $id = $controller->crear(new Incidencia(null, 'Residuos fuera de lugar', 'abierta', null, 'otro', 'Zona test', date('Y-m-d H:i:s'), $this->idContenedor, null));
        $this->idIncidencia = $id;

        $controller->modificar(new Incidencia($id, 'Residuos fuera de lugar', 'abierta', null, 'otro', 'Zona test', date('Y-m-d H:i:s'), $this->idContenedor, $this->idCuadrilla));

        $notificaciones = new NotificacionController();
        $paraCuadrilla = $notificaciones->obtenerParaCuadrilla($this->idCuadrilla);

        $tieneAsignacion = false;
        foreach ($paraCuadrilla as $fila) {
            if ((int) ($fila['idEntidadNotificacion'] ?? 0) === $id && $fila['tipoNotificacion'] === 'incidencia_asignada') $tieneAsignacion = true;
        }

        MiniTest::afirmar($tieneAsignacion, "debería notificar a la cuadrilla cuando se le asigna la incidencia por PUT");
    }

    // Pasar a "resuelta" vía modificar() debería notificar al admin; no repetirlo
    // si ya estaba resuelta (evita rebotar notificaciones por otros cambios).
    public function testModificarAResueltaNotificaAlAdminUnaSolaVez()
    {
        $controller = new IncidenciaController();
        $id = $controller->crear(new Incidencia(null, 'Contenedor dañado', 'abierta', null, 'daño', 'Zona test', date('Y-m-d H:i:s'), $this->idContenedor, null));
        $this->idIncidencia = $id;

        $controller->modificar(new Incidencia($id, 'Contenedor dañado', 'resuelta', null, 'daño', 'Zona test', date('Y-m-d H:i:s'), $this->idContenedor, null));
        // Un segundo PUT que no cambia el estado (ya estaba resuelta) no debería notificar de nuevo.
        $controller->modificar(new Incidencia($id, 'Contenedor dañado (editado)', 'resuelta', null, 'daño', 'Zona test', date('Y-m-d H:i:s'), $this->idContenedor, null));

        $notificaciones = new NotificacionController();
        $paraAdmin = $notificaciones->obtenerParaAdmin();

        $vecesNotificadaResuelta = 0;
        foreach ($paraAdmin as $fila) {
            if ((int) ($fila['idEntidadNotificacion'] ?? 0) === $id && $fila['tipoNotificacion'] === 'incidencia_resuelta') $vecesNotificadaResuelta++;
        }

        MiniTest::afirmarIgual(1, $vecesNotificadaResuelta, "debería notificar al admin la resolución exactamente una vez");
    }

    // Fase 1 punto 4 (auditoría 08/10/2026): zonaDeCuadrilla() es la pieza que
    // permite que index.php deje de confiar en la zonaIncidencia que manda el
    // cliente cuando un jefe crea una incidencia para su propia cuadrilla --
    // la deriva de la ruta real asignada en vez de aceptar texto arbitrario.
    public function testZonaDeCuadrillaDevuelveLaZonaDeLaRutaAsignada()
    {
        $zona = 'Zona test ruta ' . uniqid();
        $this->conexion->prepare("INSERT INTO ruta (zonaRuta, recorridoRuta, frecuenciaDeRecoleccionRuta, horarioRuta) VALUES (?, ?, ?, ?)")
            ->execute([$zona, 'recorrido test', 'diaria', '08:00']);
        $idRuta = (int) $this->conexion->lastInsertId();

        $nombreCuadrilla = 'Cuadrilla test zona ' . uniqid();
        $this->conexion->prepare("INSERT INTO cuadrilla (nombreCuadrilla, idRuta) VALUES (?, ?)")->execute([$nombreCuadrilla, $idRuta]);
        $stmtCuadrilla = $this->conexion->prepare("SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = ?");
        $stmtCuadrilla->execute([$nombreCuadrilla]);
        $idCuadrillaConRuta = (int) $stmtCuadrilla->fetchColumn();

        $controller = new IncidenciaController();
        $zonaObtenida = $controller->zonaDeCuadrilla($idCuadrillaConRuta);

        MiniTest::afirmarIgual($zona, $zonaObtenida, "debería traer la zonaRuta real de la ruta asignada a la cuadrilla");

        // Limpieza propia -- no toca $this->idCuadrilla (la de antes()), así
        // que despues() no se pisa con esto.
        $this->conexion->prepare("DELETE FROM cuadrilla WHERE idCuadrilla = ?")->execute([$idCuadrillaConRuta]);
        $this->conexion->prepare("DELETE FROM ruta WHERE idRuta = ?")->execute([$idRuta]);
    }

    public function testZonaDeCuadrillaDevuelveNullSinCuadrillaOSinRutaAsignada()
    {
        $controller = new IncidenciaController();

        MiniTest::afirmarIgual(null, $controller->zonaDeCuadrilla(null), "sin idCuadrilla no debería ni consultar la base");
        // $this->idCuadrilla (de antes()) no tiene idRuta asignado -- zonaRuta
        // debería volver null, no romper por el JOIN sin coincidencias.
        MiniTest::afirmarIgual(null, $controller->zonaDeCuadrilla($this->idCuadrilla), "cuadrilla sin ruta asignada debería devolver null, no romper");
    }

    // Antes esto se perdía: resolucionIncidencia/fechaResolucionIncidencia no
    // tenían columna en la base ni se mandaban en el UPDATE, así que quedaban
    // en memoria del lado del cliente y se perdían al recargar la página.
    public function testModificarPersisteLaResolucion()
    {
        $controller = new IncidenciaController();
        $id = $controller->crear(new Incidencia(null, 'Contenedor desbordado', 'abierta', null, 'desborde', 'Zona test', date('Y-m-d H:i:s'), $this->idContenedor, null));
        $this->idIncidencia = $id;

        $fechaResolucion = date('Y-m-d H:i:s');
        $controller->modificar(new Incidencia($id, 'Contenedor desbordado', 'resuelta', null, 'desborde', 'Zona test', date('Y-m-d H:i:s'), $this->idContenedor, null, 'Se vació el contenedor y se reforzó la frecuencia de recolección.', $fechaResolucion));

        $fila = $controller->obtenerPorId($id);
        MiniTest::afirmarIgual('Se vació el contenedor y se reforzó la frecuencia de recolección.', $fila['resolucionIncidencia'] ?? null, "debería guardar el detalle de la resolución");
        MiniTest::afirmar(!empty($fila['fechaResolucionIncidencia']), "debería guardar la fecha de resolución");
    }
}
