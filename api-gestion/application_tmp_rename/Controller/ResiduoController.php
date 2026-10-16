<?php
require_once __DIR__ . "/../../configuration/Conexion.php";
require_once __DIR__ . "/../Model/Residuo.php";

class ResiduoController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    public function crear($residuo)
    {
        $sql = "INSERT INTO residuo (pesoResiduo, fechaResiduo) VALUES (?, ?)";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$residuo->getPesoResiduo(), $residuo->getFechaResiduo()]);
    }

    public function obtenerTodos()
    {
        $sql = "SELECT * FROM residuo";

        return $this->conexion->query($sql)->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerPorId($idResiduo)
    {
        $sql = "SELECT * FROM residuo WHERE idResiduo = ?";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$idResiduo]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function modificar($residuo)
    {
        $sql = "UPDATE residuo SET pesoResiduo = ?, fechaResiduo = ? WHERE idResiduo = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$residuo->getPesoResiduo(), $residuo->getFechaResiduo(), $residuo->getIdResiduo()]);
    }

    public function eliminar($idResiduo)
    {
        $sql = "DELETE FROM residuo WHERE idResiduo = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$idResiduo]);
    }
}
?>
