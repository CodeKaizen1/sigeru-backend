<?php
require_once __DIR__ . "/../Configuration/Conexion.php";
require_once __DIR__ . "/../Model/OperarioDeCuadrilla.php";

class OperarioDeCuadrillaController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    public function crear($operario)
    {
        $sql = "INSERT INTO operarioDeCuadrilla (idOperarioDeCuadrilla, cedulaUsuario, estadoOperarioDeCuadrilla, cargoOperarioDeCuadrilla, turnoOperarioDeCuadrilla, horaInicioOperarioDeCuadrilla, horaFinOperarioDeCuadrilla, licenciaDeConducirOperarioDeCuadrilla, idCuadrilla) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$operario->getIdOperarioDeCuadrilla(), $operario->getCedulaUsuario(), $operario->getEstadoOperarioDeCuadrilla(), $operario->getCargoOperarioDeCuadrilla(), $operario->getTurnoOperarioDeCuadrilla(), $operario->getHoraInicioOperarioDeCuadrilla(), $operario->getHoraFinOperarioDeCuadrilla(), $operario->getLicenciaDeConducirOperarioDeCuadrilla(), $operario->getIdCuadrilla()]);
    }

    public function obtenerTodos()
    {
        $sql = "SELECT * FROM operarioDeCuadrilla";

        $stmt = $this->conexion->query($sql);

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerPorId($idOperarioDeCuadrilla)
    {
        $sql = "SELECT * FROM operarioDeCuadrilla WHERE idOperarioDeCuadrilla = ?";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$idOperarioDeCuadrilla]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function obtenerPorCuadrilla($idCuadrilla)
    {
        $sql = "SELECT * FROM operarioDeCuadrilla WHERE idCuadrilla = ?";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$idCuadrilla]);

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function modificar($operario)
    {
        $sql = "UPDATE operarioDeCuadrilla SET cedulaUsuario = ?, estadoOperarioDeCuadrilla = ?, cargoOperarioDeCuadrilla = ?, turnoOperarioDeCuadrilla = ?, horaInicioOperarioDeCuadrilla = ?, horaFinOperarioDeCuadrilla = ?, licenciaDeConducirOperarioDeCuadrilla = ?, idCuadrilla = ? WHERE idOperarioDeCuadrilla = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$operario->getCedulaUsuario(), $operario->getEstadoOperarioDeCuadrilla(), $operario->getCargoOperarioDeCuadrilla(), $operario->getTurnoOperarioDeCuadrilla(), $operario->getHoraInicioOperarioDeCuadrilla(), $operario->getHoraFinOperarioDeCuadrilla(), $operario->getLicenciaDeConducirOperarioDeCuadrilla(), $operario->getIdCuadrilla(), $operario->getIdOperarioDeCuadrilla()]);
    }

    public function eliminar($idOperarioDeCuadrilla)
    {
        $sql = "DELETE FROM operarioDeCuadrilla WHERE idOperarioDeCuadrilla = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$idOperarioDeCuadrilla]);
    }
}
?>
