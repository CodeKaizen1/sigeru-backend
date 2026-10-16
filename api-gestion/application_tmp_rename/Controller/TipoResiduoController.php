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

        // (int) acá es necesario: PDO con parámetros bindeados por posición convierte
        // un bool false a '' (string vacío) antes de mandarlo a MySQL, y la columna es
        // BOOLEAN (TINYINT) -- eso tiraba "Incorrect integer value: ''" al intentar
        // guardar un tipo de residuo marcado como NO reciclable (hallado al escribir
        // los tests unitarios de este controller, Fase 5, 06/10/2026).
        return $stmt->execute([$tipoResiduo->getNombreTipoResiduo(), $tipoResiduo->getDescripcionTipoResiduo(), (int) $tipoResiduo->getEsReciclableTipoResiduo()]);
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

        // (int) acá por el mismo motivo que en crear(): evita que un bool false se
        // bindee como '' y rompa la columna BOOLEAN.
        return $stmt->execute([$tipoResiduo->getNombreTipoResiduo(), $tipoResiduo->getDescripcionTipoResiduo(), (int) $tipoResiduo->getEsReciclableTipoResiduo(), $tipoResiduo->getIdTipoResiduo()]);
    }

    public function eliminar($idTipoResiduo)
    {
        $sql = "DELETE FROM tipoResiduo WHERE idTipoResiduo = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$idTipoResiduo]);
    }
}
?>
