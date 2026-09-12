<?php
require_once __DIR__ . "/../../Configuration/Conexion.php";
require_once __DIR__ . "/../Model/Vehiculo.php";

class VehiculoController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    public function crear($vehiculo)
    {
        $sql = "INSERT INTO vehiculo (idVehiculo, matriculaVehiculo, marcaVehiculo, modeloVehiculo, anioVehiculo, disponibilidadVehiculo, capacidadVehiculo, mantenimientoVehiculo, idChofer) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$vehiculo->getIdVehiculo(), $vehiculo->getMatriculaVehiculo(), $vehiculo->getMarcaVehiculo(), $vehiculo->getModeloVehiculo(), $vehiculo->getAnioVehiculo(), $vehiculo->getDisponibilidadVehiculo(), $vehiculo->getCapacidadVehiculo(), $vehiculo->getMantenimientoVehiculo(), $vehiculo->getIdChofer()]);
    }

    public function obtenerTodos()
    {
        $sql = "SELECT * FROM vehiculo";

        return $this->conexion->query($sql)->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerPorId($idVehiculo)
    {
        $sql = "SELECT * FROM vehiculo WHERE idVehiculo = ?";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$idVehiculo]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function modificar($vehiculo)
    {
        $sql = "UPDATE vehiculo SET matriculaVehiculo = ?, marcaVehiculo = ?, modeloVehiculo = ?, anioVehiculo = ?, disponibilidadVehiculo = ?, capacidadVehiculo = ?, mantenimientoVehiculo = ?, idChofer = ? WHERE idVehiculo = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$vehiculo->getMatriculaVehiculo(), $vehiculo->getMarcaVehiculo(), $vehiculo->getModeloVehiculo(), $vehiculo->getAnioVehiculo(), $vehiculo->getDisponibilidadVehiculo(), $vehiculo->getCapacidadVehiculo(), $vehiculo->getMantenimientoVehiculo(), $vehiculo->getIdChofer(), $vehiculo->getIdVehiculo()]);
    }

    public function eliminar($idVehiculo)
    {
        $sql = "DELETE FROM vehiculo WHERE idVehiculo = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$idVehiculo]);
    }

    // Camión asignado a un chofer; devuelve false si no tiene ninguno.
    public function obtenerPorChofer($idChofer)
    {
        $sql = "SELECT * FROM vehiculo WHERE idChofer = ?";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$idChofer]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}
?>