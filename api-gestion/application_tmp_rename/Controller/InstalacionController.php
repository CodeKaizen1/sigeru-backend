<?php
require_once __DIR__ . "/../../configuration/Conexion.php";
require_once __DIR__ . "/../Model/Instalacion.php";

class InstalacionController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    public function crear($instalacion)
    {
        $sql = "INSERT INTO instalacion (idInstalacion, nombreInstalacion, ubicacionInstalacion, capacidadInstalacion, estadoOperativoInstalacion, tipoResiduoInstalacion, latitudInstalacion, longitudInstalacion) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$instalacion->getIdInstalacion(), $instalacion->getNombreInstalacion(), $instalacion->getUbicacionInstalacion(), $instalacion->getCapacidadInstalacion(), $instalacion->getEstadoOperativoInstalacion(), $instalacion->getTipoResiduoInstalacion(), $instalacion->getLatitudInstalacion(), $instalacion->getLongitudInstalacion()]);
    }

    public function obtenerTodos()
    {
        $sql = "SELECT * FROM instalacion";

        $stmt = $this->conexion->query($sql);

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerPorId($idInstalacion)
    {
        $sql = "SELECT * FROM instalacion WHERE idInstalacion = ?";

        $stmt = $this->conexion->prepare($sql);

        $stmt->execute([$idInstalacion]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function modificar($instalacion)
    {
        $sql = "UPDATE instalacion SET nombreInstalacion = ?, ubicacionInstalacion = ?, capacidadInstalacion = ?, estadoOperativoInstalacion = ?, tipoResiduoInstalacion = ?, latitudInstalacion = ?, longitudInstalacion = ? WHERE idInstalacion = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$instalacion->getNombreInstalacion(), $instalacion->getUbicacionInstalacion(), $instalacion->getCapacidadInstalacion(), $instalacion->getEstadoOperativoInstalacion(), $instalacion->getTipoResiduoInstalacion(), $instalacion->getLatitudInstalacion(), $instalacion->getLongitudInstalacion(), $instalacion->getIdInstalacion()]);
    }

    public function eliminar($idInstalacion)
    {
        $sql = "DELETE FROM instalacion WHERE idInstalacion = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$idInstalacion]);
    }
}
?>