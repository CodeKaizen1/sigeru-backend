<?php
require_once __DIR__ . "/../../Configuration/Conexion.php";
require_once __DIR__ . "/../Model/Cuadrilla.php";
require_once __DIR__ . "/VehiculoController.php";

class CuadrillaController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    // Deriva el camión de un chofer buscando en "vehiculo"; cuadrilla.idVehiculo es una columna en desuso.
    private function derivarIdVehiculo($idChofer)
    {
        if ($idChofer === null) {
            return null;
        }

        $vehiculoController = new VehiculoController();
        $vehiculo = $vehiculoController->obtenerPorChofer($idChofer);

        return $vehiculo ? $vehiculo['idVehiculo'] : null;
    }

    public function crear($cuadrilla)
    {
        $idVehiculo = $this->derivarIdVehiculo($cuadrilla->getIdChofer());

        $sql = "INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla, idVehiculo, idRuta, estadoCuadrilla) VALUES (?, ?, ?, ?, ?, ?)";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$cuadrilla->getNombreCuadrilla(), $cuadrilla->getIdChofer(), $cuadrilla->getIdJefeCuadrilla(), $idVehiculo, $cuadrilla->getIdRuta(), $cuadrilla->getEstadoCuadrilla() ?? 'activa']);
    }

    // idVehiculo se resuelve con JOIN a vehiculo.idChofer, no desde la columna cuadrilla.idVehiculo.
    public function obtenerTodos()
    {
        $sql = "SELECT c.idCuadrilla, c.nombreCuadrilla, c.idChofer, c.idJefeCuadrilla, v.idVehiculo, c.idRuta, c.estadoCuadrilla
                FROM cuadrilla c
                LEFT JOIN vehiculo v ON v.idChofer = c.idChofer";

        return $this->conexion->query($sql)->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerPorId($idCuadrilla)
    {
        $sql = "SELECT c.idCuadrilla, c.nombreCuadrilla, c.idChofer, c.idJefeCuadrilla, v.idVehiculo, c.idRuta, c.estadoCuadrilla
                FROM cuadrilla c
                LEFT JOIN vehiculo v ON v.idChofer = c.idChofer
                WHERE c.idCuadrilla = ?";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$idCuadrilla]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function modificar($cuadrilla)
    {
        $idVehiculo = $this->derivarIdVehiculo($cuadrilla->getIdChofer());

        $sql = "UPDATE cuadrilla SET nombreCuadrilla = ?, idChofer = ?, idJefeCuadrilla = ?, idVehiculo = ?, idRuta = ?, estadoCuadrilla = ? WHERE idCuadrilla = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$cuadrilla->getNombreCuadrilla(), $cuadrilla->getIdChofer(), $cuadrilla->getIdJefeCuadrilla(), $idVehiculo, $cuadrilla->getIdRuta(), $cuadrilla->getEstadoCuadrilla() ?? 'activa', $cuadrilla->getIdCuadrilla()]);
    }

    public function eliminar($idCuadrilla)
    {
        $sql = "DELETE FROM cuadrilla WHERE idCuadrilla = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$idCuadrilla]);
    }

    // Confirma que la ruta pertenece a una cuadrilla liderada por ese jefe (recibe la cédula, no el id interno).
    public function idRutaPerteneceAJefe($idRuta, $cedulaJefe)
    {
        if ($idRuta === null || $idRuta === '' || $cedulaJefe === null) {
            return false;
        }

        $sql = "SELECT COUNT(*) FROM cuadrilla c
                JOIN operarioDeCuadrilla o ON o.idOperarioDeCuadrilla = c.idJefeCuadrilla
                WHERE c.idRuta = ? AND o.cedulaUsuario = ?";
        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$idRuta, $cedulaJefe]);

        return $stmt->fetchColumn() > 0;
    }
}
?>
