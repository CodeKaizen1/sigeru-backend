<?php
require_once __DIR__ . "/../Application/Controller/CentroDeAcopioController.php";
require_once __DIR__ . "/../Application/Model/CentroDeAcopio.php";
require_once __DIR__ . "/../Configuration/Conexion.php";

// CRUD real de centroDeAcopio contra la base que apunte el .env de esta carpeta.
// crear() crea primero la fila base en "instalacion" y luego la de centroDeAcopio;
// eliminar() borra la de "instalacion" y la de centroDeAcopio cascadea.
class CentroDeAcopioControllerTest
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
        $nombre = 'Centro Test ' . uniqid();
        $controller = new CentroDeAcopioController();
        $controller->crear(new CentroDeAcopio(null, $nombre, 'Montevideo', 300, 'operativa', 'reciclable', null, null, 'plásticos y vidrio', 150));

        $id = $this->buscarIdPorNombre($nombre);
        $fila = $controller->obtenerPorId($id);

        MiniTest::afirmarIgual($nombre, $fila['nombreInstalacion'] ?? null, "debería guardar el nombre (de la fila base instalacion) tal cual");
        MiniTest::afirmarIgual('plásticos y vidrio', $fila['clasificacionDeResiduoCentroDeAcopio'] ?? null, "debería guardar la clasificación tal cual");
        MiniTest::afirmarIgual(150.0, (float) $fila['capacidadCentroDeAcopio'], "debería guardar la capacidad del centro tal cual");

        // eliminar() borra la instalación, y centroDeAcopio tiene que cascadear.
        $controller->eliminar($id);
    }

    public function testModificarActualizaAmbasTablas()
    {
        $nombre = 'Centro Mod ' . uniqid();
        $controller = new CentroDeAcopioController();
        $controller->crear(new CentroDeAcopio(null, $nombre, 'Montevideo', 300, 'operativa', 'reciclable', null, null, 'plásticos', 150));
        $id = $this->buscarIdPorNombre($nombre);

        $controller->modificar(new CentroDeAcopio($id, $nombre, 'Canelones', 400, 'operativa', 'reciclable', null, null, 'papel y cartón', 220));
        $fila = $controller->obtenerPorId($id);

        MiniTest::afirmarIgual('Canelones', $fila['ubicacionInstalacion'] ?? null, "debería haber actualizado la fila base de instalacion");
        MiniTest::afirmarIgual('papel y cartón', $fila['clasificacionDeResiduoCentroDeAcopio'] ?? null, "debería haber actualizado la clasificación");

        $controller->eliminar($id);
    }

    public function testEliminarCascadea()
    {
        $nombre = 'Centro Borrar ' . uniqid();
        $controller = new CentroDeAcopioController();
        $controller->crear(new CentroDeAcopio(null, $nombre, 'Montevideo', 300, 'operativa', 'reciclable', null, null, 'plásticos', 150));
        $id = $this->buscarIdPorNombre($nombre);

        $controller->eliminar($id);
        MiniTest::afirmarIgual(false, $controller->obtenerPorId($id), "no debería encontrarlo después de borrarlo");

        $stmt = $this->conexion->prepare("SELECT COUNT(*) FROM instalacion WHERE idInstalacion = ?");
        $stmt->execute([$id]);
        MiniTest::afirmarIgual(0, (int) $stmt->fetchColumn(), "la fila base de instalacion también debería haberse borrado");
    }
}
