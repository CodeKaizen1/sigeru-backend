<?php
require_once __DIR__ . "/../../configuration/Conexion.php";
require_once __DIR__ . "/../Model/TipoResiduo.php";

class TipoResiduoController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    public function crear($tipoResiduo)
    {
        $sql = "INSERT INTO tipoResiduo (nombreTipoResiduo, descripcionTipoResiduo, esReciclableTipoResiduo) VALUES (?, ?, ?)";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$tipoResiduo->getNombreTipoResiduo(), $tipoResiduo->getDescripcionTipoResiduo(), $tipoResiduo->getEsReciclableTipoResiduo()]);
    }

    public function obtenerTodos()
    {
        $sql = "SELECT * FROM tipoResiduo";

        return $this->conexion->query($sql)->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerPorId($idTipoResiduo)
    {
        $sql = "SELECT * FROM tipoResiduo WHERE idTipoResiduo = ?";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$idTipoResiduo]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function modificar($tipoResiduo)
    {
        $sql = "UPDATE tipoResiduo SET nombreTipoResiduo = ?, descripcionTipoResiduo = ?, esReciclableTipoResiduo = ? WHERE idTipoResiduo = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$tipoResiduo->getNombreTipoResiduo(), $tipoResiduo->getDescripcionTipoResiduo(), $tipoResiduo->getEsReciclableTipoResiduo(), $tipoResiduo->getIdTipoResiduo()]);
    }

    public function eliminar($idTipoResiduo)
    {
        $sql = "DELETE FROM tipoResiduo WHERE idTipoResiduo = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$idTipoResiduo]);
    }
}
?>
