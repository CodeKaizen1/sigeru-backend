<?php
require_once __DIR__ . "/../../configuration/Conexion.php";
require_once __DIR__ . "/../Model/Contenedor.php";

class ContenedorController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    public function crear($contenedor)
    {
        $sql = "INSERT INTO contenedor (idContenedor, ubicacionContenedor, estadoContenedor, capacidadContenedor, tipoResiduoContenedor, latitudContenedor, longitudContenedor) VALUES (?, ?, ?, ?, ?, ?, ?)";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$contenedor->getIdContenedor(), $contenedor->getUbicacionContenedor(), $contenedor->getEstadoContenedor(), $contenedor->getCapacidadContenedor(), $contenedor->getTipoResiduoContenedor(), $contenedor->getLatitudContenedor(), $contenedor->getLongitudContenedor()]);
    }

    public function obtenerTodos()
    {
        $sql = "SELECT * FROM contenedor";

        $stmt = $this->conexion->query($sql);

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerPorId($idContenedor)
    {
        $sql = "SELECT * FROM contenedor WHERE idContenedor = ?";

        $stmt = $this->conexion->prepare($sql);

        $stmt->execute([$idContenedor]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function modificar($contenedor)
    {
        $sql = "UPDATE contenedor SET ubicacionContenedor = ?, estadoContenedor = ?, capacidadContenedor = ?, tipoResiduoContenedor = ?, latitudContenedor = ?, longitudContenedor = ? WHERE idContenedor = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$contenedor->getUbicacionContenedor(), $contenedor->getEstadoContenedor(), $contenedor->getCapacidadContenedor(), $contenedor->getTipoResiduoContenedor(), $contenedor->getLatitudContenedor(), $contenedor->getLongitudContenedor(), $contenedor->getIdContenedor()]);
    }

    public function eliminar($idContenedor)
    {
        $sql = "DELETE FROM contenedor WHERE idContenedor = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$idContenedor]);
    }
}
?>