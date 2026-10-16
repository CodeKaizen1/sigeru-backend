<?php
require_once __DIR__ . "/../Application/Controller/VertederoController.php";
require_once __DIR__ . "/../Application/Model/Vertedero.php";
require_once __DIR__ . "/../Configuration/Conexion.php";

// CRUD real de vertedero contra la base que apunte el .env de esta carpeta.
// Mismo patrón que CentroDeAcopio/PlantaDeProcesamiento: crear() arma primero la fila
// base en "instalacion".
class VertederoControllerTest
{
    private $conexion;

    public function antes()
    {
        $this->conexion = (new Conexion())->conectar();
    }

    private function buscarIdPorNombre($nombre)
    {
        $stmt = $this->conexion->prepare("SELECT idInstalacion FROM instalacion WHERE nombreInstalacion = ?");
        $stmt->execute([$nombre]);
        return (int) $stmt->fetchColumn();
    }

    public function testCrearYLeer()
    {
        $nombre = 'Vertedero Test ' . uniqid();
        $controller = new VertederoController();
        $controller->crear(new Vertedero(null, $nombre, 'Montevideo', 5000, 'operativo', 'mixto', null, null, '10 años', 'relleno sanitario'));

        $id = $this->buscarIdPorNombre($nombre);
        $fila = $controller->obtenerPorId($id);

        MiniTest::afirmarIgual('10 años', $fila['vidaUtil'] ?? null, "debería guardar la vida útil tal cual");
        MiniTest::afirmarIgual('relleno sanitario', $fila['tipoDeDispocicionVertedero'] ?? null, "debería guardar el tipo de disposición tal cual");

        $controller->eliminar($id);
    }

    public function testModificarActualizaAmbasTablas()
    {
        $nombre = 'Vertedero Mod ' . uniqid();
        $controller = new VertederoController();
        $controller->crear(new Vertedero(null, $nombre, 'Montevideo', 5000, 'operativo', 'mixto', null, null, '10 años', 'relleno sanitario'));
        $id = $this->buscarIdPorNombre($nombre);

        $controller->modificar(new Vertedero($id, $nombre, 'Canelones', 6000, 'cerrado', 'mixto', null, null, '2 años', 'incineración'));
        $fila = $controller->obtenerPorId($id);

        MiniTest::afirmarIgual('Canelones', $fila['ubicacionInstalacion'] ?? null, "debería haber actualizado la fila base de instalacion");
        MiniTest::afirmarIgual('cerrado', $fila['estadoOperativoInstalacion'] ?? null, "debería haber actualizado el estado operativo");
        MiniTest::afirmarIgual('2 años', $fila['vidaUtil'] ?? null, "debería haber actualizado la vida útil");

        $controller->eliminar($id);
    }

    public function testEliminarCascadea()
    {
        $nombre = 'Vertedero Borrar ' . uniqid();
        $controller = new VertederoController();
        $controller->crear(new Vertedero(null, $nombre, 'Montevideo', 5000, 'operativo', 'mixto', null, null, '10 años', 'relleno sanitario'));
        $id = $this->buscarIdPorNombre($nombre);

        $controller->eliminar($id);
        MiniTest::afirmarIgual(false, $controller->obtenerPorId($id), "no debería encontrarlo después de borrarlo");
    }
}
