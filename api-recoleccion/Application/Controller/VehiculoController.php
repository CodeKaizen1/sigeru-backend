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

    // DEF-VEH-001: la proteccion para no borrar un camion con ruta en curso solo
    // existia en el frontend (camionTieneRutaAsignada(), en
    // cuadrillas-camiones-rutas.js) -- quien llamara directo al endpoint de
    // borrado la salteaba por completo. Se agrega aca, del lado del servidor,
    // uniendo vehiculo -> cuadrilla (por chofer) -> ruta.
    public function tieneRutaEnCurso($idVehiculo)
    {
        $sql = "SELECT COUNT(*) FROM vehiculo v
                JOIN cuadrilla c ON c.idChofer = v.idChofer
                JOIN ruta r ON r.idRuta = c.idRuta
                WHERE v.idVehiculo = ? AND r.estadoRuta = 'en curso'";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$idVehiculo]);

        return $stmt->fetchColumn() > 0;
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