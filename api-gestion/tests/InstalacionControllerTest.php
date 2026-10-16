<?php
require_once __DIR__ . "/../Application/Controller/InstalacionController.php";
require_once __DIR__ . "/../Application/Model/Instalacion.php";
require_once __DIR__ . "/../Configuration/Conexion.php";

// CRUD real de instalacion contra la base que apunte el .env de esta carpeta.
class InstalacionControllerTest
{
    private $conexion;
    private $idCreado;

    public function antes()
    {
        $this->conexion = (new Conexion())->conectar();
    }

    public function despues()
    {
        if ($this->idCreado) {
            $this->conexion->prepare("DELETE FROM instalacion WHERE idInstalacion = ?")->execute([$this->idCreado]);
        }
    }

    private function buscarIdPorNombre($nombre)
    {
        $stmt = $this->conexion->prepare("SELECT idInstalacion FROM instalacion WHERE nombreInstalacion = ?");
        $stmt->execute([$nombre]);
        return (int) $stmt->fetchColumn();
    }

    public function testCrearYLeer()
    {
        $nombre = 'Instalacion Test ' . uniqid();
        $controller = new InstalacionController();
        $controller->crear(new Instalacion(null, $nombre, 'Montevideo', 500, 'operativa', 'organico', -34.9011, -56.1645));

        $this->idCreado = $this->buscarIdPorNombre($nombre);
        $fila = $controller->obtenerPorId($this->idCreado);

        MiniTest::afirmarIgual($nombre, $fila['nombreInstalacion'] ?? null, "debería guardar el nombre tal cual");
        MiniTest::afirmarIgual('operativa', $fila['estadoOperativoInstalacion'] ?? null, "debería guardar el estado operativo tal cual");
    }

    public function testModificar()
    {
        $nombre = 'Instalacion Mod ' . uniqid();
        $controller = new InstalacionController();
        $controller->crear(new Instalacion(null, $nombre, 'Montevideo', 500, 'operativa', 'organico', -34.9011, -56.1645));
        $this->idCreado = $this->buscarIdPorNombre($nombre);

        $controller->modificar(new Instalacion($this->idCreado, $nombre, 'Canelones', 750, 'en mantenimiento', 'reciclable', -34.5, -56.0));
        $fila = $controller->obtenerPorId($this->idCreado);

        MiniTest::afirmarIgual('Canelones', $fila['ubicacionInstalacion'] ?? null, "la ubicación debería haber cambiado");
        MiniTest::afirmarIgual('en mantenimiento', $fila['estadoOperativoInstalacion'] ?? null, "el estado debería haber cambiado");
    }

    public function testEliminar()
    {
        $nombre = 'Instalacion Borrar ' . uniqid();
        $controller = new InstalacionController();
        $controller->crear(new Instalacion(null, $nombre, 'Montevideo', 500, 'operativa', 'organico', null, null));
        $id = $this->buscarIdPorNombre($nombre);

        MiniTest::afirmar($id > 0, "tiene que haber encontrado la instalación recién creada");
        $controller->eliminar($id);
        MiniTest::afirmarIgual(false, $controller->obtenerPorId($id), "no debería encontrarla después de borrarla");
    }
}
