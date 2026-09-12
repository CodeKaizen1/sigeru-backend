<?php
require_once __DIR__ . "/../../configuration/Conexion.php";
require_once __DIR__ . "/../Model/PlantaDeProcesamiento.php";

class PlantaDeProcesamientoController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    // Crea primero la fila base en "instalacion" (PK AUTO_INCREMENT) y con ese id inserta en plantaDeProcesamiento.
    public function crear($planta)
    {
        $sqlInstalacion = "INSERT INTO instalacion (nombreInstalacion, ubicacionInstalacion, capacidadInstalacion, estadoOperativoInstalacion, tipoResiduoInstalacion, latitudInstalacion, longitudInstalacion) VALUES (?, ?, ?, ?, ?, ?, ?)";
        $stmtInstalacion = $this->conexion->prepare($sqlInstalacion);
        $stmtInstalacion->execute([$planta->getNombreInstalacion(), $planta->getUbicacionInstalacion(), $planta->getCapacidadInstalacion(), $planta->getEstadoOperativoInstalacion(), $planta->getTipoResiduoInstalacion(), $planta->getLatitudInstalacion(), $planta->getLongitudInstalacion()]);

        $planta->setIdInstalacion((int) $this->conexion->lastInsertId());

        $sql = "INSERT INTO plantaDeProcesamiento (idInstalacion, capacidadPlantaDeProcesamiento, tipoDeProcesoPlantaDeProcesamiento) VALUES (?, ?, ?)";
        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$planta->getIdInstalacion(), $planta->getCapacidadPlantaDeProcesamiento(), $planta->getTipoDeProcesoPlantaDeProcesamiento()]);
    }

    public function obtenerTodos()
    {
        $sql = "SELECT i.*, p.capacidadPlantaDeProcesamiento, p.tipoDeProcesoPlantaDeProcesamiento
                FROM plantaDeProcesamiento p
                JOIN instalacion i ON i.idInstalacion = p.idInstalacion";

        return $this->conexion->query($sql)->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerPorId($idInstalacion)
    {
        $sql = "SELECT i.*, p.capacidadPlantaDeProcesamiento, p.tipoDeProcesoPlantaDeProcesamiento
                FROM plantaDeProcesamiento p
                JOIN instalacion i ON i.idInstalacion = p.idInstalacion
                WHERE p.idInstalacion = ?";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$idInstalacion]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function modificar($planta)
    {
        $sqlInstalacion = "UPDATE instalacion SET nombreInstalacion = ?, ubicacionInstalacion = ?, capacidadInstalacion = ?, estadoOperativoInstalacion = ?, tipoResiduoInstalacion = ?, latitudInstalacion = ?, longitudInstalacion = ? WHERE idInstalacion = ?";
        $stmtInstalacion = $this->conexion->prepare($sqlInstalacion);
        $stmtInstalacion->execute([$planta->getNombreInstalacion(), $planta->getUbicacionInstalacion(), $planta->getCapacidadInstalacion(), $planta->getEstadoOperativoInstalacion(), $planta->getTipoResiduoInstalacion(), $planta->getLatitudInstalacion(), $planta->getLongitudInstalacion(), $planta->getIdInstalacion()]);

        $sql = "UPDATE plantaDeProcesamiento SET capacidadPlantaDeProcesamiento = ?, tipoDeProcesoPlantaDeProcesamiento = ? WHERE idInstalacion = ?";
        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$planta->getCapacidadPlantaDeProcesamiento(), $planta->getTipoDeProcesoPlantaDeProcesamiento(), $planta->getIdInstalacion()]);
    }

    // ON DELETE CASCADE borra la fila de plantaDeProcesamiento al borrar la de "instalacion".
    public function eliminar($idInstalacion)
    {
        $sql = "DELETE FROM instalacion WHERE idInstalacion = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$idInstalacion]);
    }
}
?>
