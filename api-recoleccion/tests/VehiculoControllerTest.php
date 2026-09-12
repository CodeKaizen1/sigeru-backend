<?php
require_once __DIR__ . "/../Application/Controller/VehiculoController.php";
require_once __DIR__ . "/../Application/Model/Vehiculo.php";
require_once __DIR__ . "/../Configuration/Conexion.php";

// CRUD real de vehiculo + obtenerPorChofer(), contra la base que apunte el
// .env de esta carpeta.
class VehiculoControllerTest
{
    private $conexion;
    private $matricula;
    private $idCreado;
    private $cedulaChofer = '90000002';
    private $idOperarioChofer;

    public function antes()
    {
        $this->conexion = (new Conexion())->conectar();
        $this->matricula = 'TEST-' . uniqid();
    }

    public function despues()
    {
        if ($this->idCreado) {
            $this->conexion->prepare("DELETE FROM vehiculo WHERE idVehiculo = ?")->execute([$this->idCreado]);
        }
        // Borrar el usuario cascadea a su fila de operarioDeCuadrilla (ON DELETE CASCADE).
        $this->conexion->prepare("DELETE FROM usuario WHERE cedulaUsuario = ?")->execute([$this->cedulaChofer]);
    }

    // idChofer de vehiculo apunta a operarioDeCuadrilla.idOperarioDeCuadrilla
    // (no a la cédula), y esa tabla exige una fila real en "usuario" antes.
    private function crearChoferDePrueba()
    {
        $this->conexion->prepare(
            "INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, estadoUsuario, rolUsuario) VALUES (?, 'Test', 'Chofer', 'activo', 'chofer')"
        )->execute([$this->cedulaChofer]);
        $this->conexion->prepare(
            "INSERT INTO operarioDeCuadrilla (cedulaUsuario, cargoOperarioDeCuadrilla) VALUES (?, 'chofer')"
        )->execute([$this->cedulaChofer]);
        $this->idOperarioChofer = (int) $this->conexion->lastInsertId();
    }

    private function buscarIdPorMatricula()
    {
        $stmt = $this->conexion->prepare("SELECT idVehiculo FROM vehiculo WHERE matriculaVehiculo = ?");
        $stmt->execute([$this->matricula]);
        return (int) $stmt->fetchColumn();
    }

    public function testCrearSinChofer()
    {
        $controller = new VehiculoController();
        $controller->crear(new Vehiculo(null, $this->matricula, 'Volvo', 'FH', 2020, 'disponible', 8000, 'al día'));
        $this->idCreado = $this->buscarIdPorMatricula();

        $fila = $controller->obtenerPorId($this->idCreado);
        MiniTest::afirmarIgual(null, $fila['idChofer'], "sin chofer asignado, idChofer debería quedar null");
    }

    public function testObtenerPorChoferEncuentraElCamionAsignado()
    {
        $this->crearChoferDePrueba();

        $controller = new VehiculoController();
        $controller->crear(new Vehiculo(null, $this->matricula, 'Volvo', 'FH', 2020, 'disponible', 8000, 'al día', $this->idOperarioChofer));
        $this->idCreado = $this->buscarIdPorMatricula();

        $camion = $controller->obtenerPorChofer($this->idOperarioChofer);
        MiniTest::afirmarIgual($this->idCreado, (int) $camion['idVehiculo'], "debería encontrar el camión de ese chofer");
    }
}
