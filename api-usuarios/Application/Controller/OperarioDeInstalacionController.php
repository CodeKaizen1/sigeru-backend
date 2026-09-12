<?php
require_once __DIR__ . "/../Configuration/Conexion.php";
require_once __DIR__ . "/../Model/OperarioDeInstalacion.php";

class OperarioDeInstalacionController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    public function crear($operario)
    {
        $sql = "INSERT INTO operarioDeInstalacion (cedulaUsuario, turnoOperarioDeInstalacion, instalacionAsignada, estadoOperarioDeInstalacion, cargoOperarioDeInstalacion) VALUES (?, ?, ?, ?, ?)";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$operario->getCedulaUsuario(), $operario->getTurnoOperarioDeInstalacion(), $operario->getInstalacionAsignada(), $operario->getEstadoOperarioDeInstalacion(), $operario->getCargoOperarioDeInstalacion()]);
    }

    public function obtenerTodos()
    {
        $sql = "SELECT * FROM operarioDeInstalacion";

        return $this->conexion->query($sql)->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerPorId($cedulaUsuario)
    {
        $sql = "SELECT * FROM operarioDeInstalacion WHERE cedulaUsuario = ?";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$cedulaUsuario]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function modificar($operario)
    {
        $sql = "UPDATE operarioDeInstalacion SET turnoOperarioDeInstalacion = ?, instalacionAsignada = ?, estadoOperarioDeInstalacion = ?, cargoOperarioDeInstalacion = ? WHERE cedulaUsuario = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$operario->getTurnoOperarioDeInstalacion(), $operario->getInstalacionAsignada(), $operario->getEstadoOperarioDeInstalacion(), $operario->getCargoOperarioDeInstalacion(), $operario->getCedulaUsuario()]);
    }

    public function eliminar($cedulaUsuario)
    {
        $sql = "DELETE FROM operarioDeInstalacion WHERE cedulaUsuario = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$cedulaUsuario]);
    }
}
?>