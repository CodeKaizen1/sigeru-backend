<?php
require_once __DIR__ . "/../Application/Controller/PlantaDeProcesamientoController.php";
require_once __DIR__ . "/../Application/Model/PlantaDeProcesamiento.php";
require_once __DIR__ . "/../Configuration/Conexion.php";

// CRUD real de plantaDeProcesamiento contra la base que apunte el .env de esta carpeta.
// Mismo patrón que CentroDeAcopio: crear() arma primero la fila base en "instalacion".
class PlantaDeProcesamientoControllerTest
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
        $nombre = 'Planta Test ' . uniqid();
        $controller = new PlantaDeProcesamientoController();
        $controller->crear(new PlantaDeProcesamiento(null, $nombre, 'Montevideo', 1000, 'operativa', 'organico', null, null, 600, 'compostaje'));

        $id = $this->buscarIdPorNombre($nombre);
        $fila = $controller->obtenerPorId($id);

        MiniTest::afirmarIgual('compostaje', $fila['tipoDeProcesoPlantaDeProcesamiento'] ?? null, "debería guardar el tipo de proceso tal cual");
        MiniTest::afirmarIgual(600.0, (float) $fila['capacidadPlantaDeProcesamiento'], "debería guardar la capacidad de la planta tal cual");

        $controller->eliminar($id);
    }

    public function testModificarActualizaAmbasTablas()
    {
        $nombre = 'Planta Mod ' . uniqid();
        $controller = new PlantaDeProcesamientoController();
        $controller->crear(new PlantaDeProcesamiento(null, $nombre, 'Montevideo', 1000, 'operativa', 'organico', null, null, 600, 'compostaje'));
        $id = $this->buscarIdPorNombre($nombre);

        $controller->modificar(new PlantaDeProcesamiento($id, $nombre, 'Canelones', 1200, 'operativa', 'organico', null, null, 900, 'incineración'));
        $fila = $controller->obtenerPorId($id);

        MiniTest::afirmarIgual('Canelones', $fila['ubicacionInstalacion'] ?? null, "debería haber actualizado la fila base de instalacion");
        MiniTest::afirmarIgual('incineración', $fila['tipoDeProcesoPlantaDeProcesamiento'] ?? null, "debería haber actualizado el tipo de proceso");

        $controller->eliminar($id);
    }

    public function testEliminarCascadea()
    {
        $nombre = 'Planta Borrar ' . uniqid();
        $controller = new PlantaDeProcesamientoController();
        $controller->crear(new PlantaDeProcesamiento(null, $nombre, 'Montevideo', 1000, 'operativa', 'organico', null, null, 600, 'compostaje'));
        $id = $this->buscarIdPorNombre($nombre);

        $controller->eliminar($id);
        MiniTest::afirmarIgual(false, $controller->obtenerPorId($id), "no debería encontrarla después de borrarla");
    }
}
