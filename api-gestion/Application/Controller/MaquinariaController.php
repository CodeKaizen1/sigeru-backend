<?php
require_once __DIR__ . "/../../Configuration/Conexion.php";
require_once __DIR__ . "/../Model/Maquinaria.php";

class MaquinariaController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    public function crear($maquinaria)
    {
        $sql = "INSERT INTO maquinaria (idMaquinaria, tipoDeMaquinaria, estadoMaquinaria, disponibilidadMaquinaria, idInstalacion) VALUES (?, ?, ?, ?, ?)";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$maquinaria->getIdMaquinaria(), $maquinaria->getTipoDeMaquinaria(), $maquinaria->getEstadoMaquinaria(), $maquinaria->getDisponibilidadMaquinaria(), $maquinaria->getIdInstalacion()]);
    }

    public function obtenerTodos()
    {
        $sql = "SELECT * FROM maquinaria";

        $stmt = $this->conexion->query($sql);

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerPorId($idMaquinaria)
    {
        $sql = "SELECT * FROM maquinaria WHERE idMaquinaria = ?";

        $stmt = $this->conexion->prepare($sql);

        $stmt->execute([$idMaquinaria]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function obtenerPorInstalacion($idInstalacion)
    {
        $sql = "SELECT * FROM maquinaria WHERE idInstalacion = ?";

        $stmt = $this->conexion->prepare($sql);

        $stmt->execute([$idInstalacion]);

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function modificar($maquinaria)
    {
        $sql = "UPDATE maquinaria SET tipoDeMaquinaria = ?, estadoMaquinaria = ?, disponibilidadMaquinaria = ?, idInstalacion = ? WHERE idMaquinaria = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$maquinaria->getTipoDeMaquinaria(), $maquinaria->getEstadoMaquinaria(), $maquinaria->getDisponibilidadMaquinaria(), $maquinaria->getIdInstalacion(), $maquinaria->getIdMaquinaria()]);
    }

    public function eliminar($idMaquinaria)
    {
        $sql = "DELETE FROM maquinaria WHERE idMaquinaria = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$idMaquinaria]);
    }
}
?>