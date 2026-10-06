<?php
require_once __DIR__ . "/../Application/Controller/CuadrillaController.php";
require_once __DIR__ . "/../Application/Model/Cuadrilla.php";
require_once __DIR__ . "/../Configuration/Conexion.php";

// CRUD real de cuadrilla contra la base que apunte el .env de esta carpeta. Los tests
// dejan idChofer/idJefeCuadrilla/idVehiculo/idRuta en null (son FKs nullable) para no
// depender de que existan filas en operarioDeCuadrilla/vehiculo/ruta.
class CuadrillaControllerTest
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
            $this->conexion->prepare("DELETE FROM cuadrilla WHERE idCuadrilla = ?")->execute([$this->idCreado]);
        }
    }

    private function buscarIdPorNombre($nombre)
    {
        $stmt = $this->conexion->prepare("SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = ?");
        $stmt->execute([$nombre]);
        return (int) $stmt->fetchColumn();
    }

    public function testCrearQuedaActivaPorDefecto()
    {
        $nombre = 'Cuadrilla Test ' . uniqid();
        $controller = new CuadrillaController();
        $controller->crear(new Cuadrilla(null, $nombre, null, null, null, null));

        $this->idCreado = $this->buscarIdPorNombre($nombre);
        $fila = $controller->obtenerPorId($this->idCreado);

        MiniTest::afirmarIgual($nombre, $fila['nombreCuadrilla'] ?? null, "debería guardar el nombre tal cual");
        MiniTest::afirmarIgual('activa', $fila['estadoCuadrilla'] ?? null, "sin estado explícito, debería quedar 'activa' por defecto");
        MiniTest::afirmarIgual(null, $fila['idVehiculo'], "sin chofer asignado, no debería derivar ningún vehículo");
    }

    public function testModificar()
    {
        $nombre = 'Cuadrilla Mod ' . uniqid();
        $controller = new CuadrillaController();
        $controller->crear(new Cuadrilla(null, $nombre, null, null, null, null));
        $this->idCreado = $this->buscarIdPorNombre($nombre);

        $controller->modificar(new Cuadrilla($this->idCreado, $nombre, null, null, null, null, 'baja'));
        $fila = $controller->obtenerPorId($this->idCreado);

        MiniTest::afirmarIgual('baja', $fila['estadoCuadrilla'] ?? null, "el estado debería haber cambiado a baja");
    }

    public function testIdRutaPerteneceAJefeSinDatosEsFalse()
    {
        $resultado = (new CuadrillaController())->idRutaPerteneceAJefe(999999, '00000000');
        MiniTest::afirmarIgual(false, $resultado, "sin ninguna cuadrilla real, no debería encontrar coincidencia");
    }

    public function testEliminar()
    {
        $nombre = 'Cuadrilla Borrar ' . uniqid();
        $controller = new CuadrillaController();
        $controller->crear(new Cuadrilla(null, $nombre, null, null, null, null));
        $id = $this->buscarIdPorNombre($nombre);

        $controller->eliminar($id);
        MiniTest::afirmarIgual(false, $controller->obtenerPorId($id), "no debería encontrarla después de borrarla");
    }
}
