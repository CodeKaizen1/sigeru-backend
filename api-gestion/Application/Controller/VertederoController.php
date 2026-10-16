<?php
require_once __DIR__ . "/../../Configuration/Conexion.php";
require_once __DIR__ . "/../Model/Vertedero.php";

class VertederoController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    // Crea primero la fila base en "instalacion" (PK AUTO_INCREMENT) y con ese id inserta en vertedero.
    public function crear($vertedero)
    {
        $sqlInstalacion = "INSERT INTO instalacion (nombreInstalacion, ubicacionInstalacion, capacidadInstalacion, estadoOperativoInstalacion, tipoResiduoInstalacion, latitudInstalacion, longitudInstalacion) VALUES (?, ?, ?, ?, ?, ?, ?)";
        $stmtInstalacion = $this->conexion->prepare($sqlInstalacion);
        $stmtInstalacion->execute([$vertedero->getNombreInstalacion(), $vertedero->getUbicacionInstalacion(), $vertedero->getCapacidadInstalacion(), $vertedero->getEstadoOperativoInstalacion(), $vertedero->getTipoResiduoInstalacion(), $vertedero->getLatitudInstalacion(), $vertedero->getLongitudInstalacion()]);

        $vertedero->setIdInstalacion((int) $this->conexion->lastInsertId());

        $sql = "INSERT INTO vertedero (idInstalacion, vidaUtil, tipoDeDispocicionVertedero) VALUES (?, ?, ?)";
        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$vertedero->getIdInstalacion(), $vertedero->getVidaUtil(), $vertedero->getTipoDeDispocicionVertedero()]);
    }

    public function obtenerTodos()
    {
        $sql = "SELECT i.*, v.vidaUtil, v.tipoDeDispocicionVertedero
                FROM vertedero v
                JOIN instalacion i ON i.idInstalacion = v.idInstalacion";

        return $this->conexion->query($sql)->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerPorId($idInstalacion)
    {
        $sql = "SELECT i.*, v.vidaUtil, v.tipoDeDispocicionVertedero
                FROM vertedero v
                JOIN instalacion i ON i.idInstalacion = v.idInstalacion
                WHERE v.idInstalacion = ?";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$idInstalacion]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function modificar($vertedero)
    {
        $sqlInstalacion = "UPDATE instalacion SET nombreInstalacion = ?, ubicacionInstalacion = ?, capacidadInstalacion = ?, estadoOperativoInstalacion = ?, tipoResiduoInstalacion = ?, latitudInstalacion = ?, longitudInstalacion = ? WHERE idInstalacion = ?";
        $stmtInstalacion = $this->conexion->prepare($sqlInstalacion);
        $stmtInstalacion->execute([$vertedero->getNombreInstalacion(), $vertedero->getUbicacionInstalacion(), $vertedero->getCapacidadInstalacion(), $vertedero->getEstadoOperativoInstalacion(), $vertedero->getTipoResiduoInstalacion(), $vertedero->getLatitudInstalacion(), $vertedero->getLongitudInstalacion(), $vertedero->getIdInstalacion()]);

        $sql = "UPDATE vertedero SET vidaUtil = ?, tipoDeDispocicionVertedero = ? WHERE idInstalacion = ?";
        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$vertedero->getVidaUtil(), $vertedero->getTipoDeDispocicionVertedero(), $vertedero->getIdInstalacion()]);
    }

    // ON DELETE CASCADE borra la fila de vertedero al borrar la de "instalacion".
    public function eliminar($idInstalacion)
    {
        $sql = "DELETE FROM instalacion WHERE idInstalacion = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$idInstalacion]);
    }
}
?>
