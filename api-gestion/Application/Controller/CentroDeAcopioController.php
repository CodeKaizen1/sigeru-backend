<?php
require_once __DIR__ . "/../../Configuration/Conexion.php";
require_once __DIR__ . "/../Model/CentroDeAcopio.php";

class CentroDeAcopioController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    // Crea primero la fila base en "instalacion" (PK AUTO_INCREMENT) y con ese id inserta en centroDeAcopio.
    public function crear($centro)
    {
        $sqlInstalacion = "INSERT INTO instalacion (nombreInstalacion, ubicacionInstalacion, capacidadInstalacion, estadoOperativoInstalacion, tipoResiduoInstalacion, latitudInstalacion, longitudInstalacion) VALUES (?, ?, ?, ?, ?, ?, ?)";
        $stmtInstalacion = $this->conexion->prepare($sqlInstalacion);
        $stmtInstalacion->execute([$centro->getNombreInstalacion(), $centro->getUbicacionInstalacion(), $centro->getCapacidadInstalacion(), $centro->getEstadoOperativoInstalacion(), $centro->getTipoResiduoInstalacion(), $centro->getLatitudInstalacion(), $centro->getLongitudInstalacion()]);

        $centro->setIdInstalacion((int) $this->conexion->lastInsertId());

        $sql = "INSERT INTO centroDeAcopio (idInstalacion, clasificacionDeResiduoCentroDeAcopio, capacidadCentroDeAcopio) VALUES (?, ?, ?)";
        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$centro->getIdInstalacion(), $centro->getClasificacionDeResiduoCentroDeAcopio(), $centro->getCapacidadCentroDeAcopio()]);
    }

    public function obtenerTodos()
    {
        $sql = "SELECT i.*, c.clasificacionDeResiduoCentroDeAcopio, c.capacidadCentroDeAcopio
                FROM centroDeAcopio c
                JOIN instalacion i ON i.idInstalacion = c.idInstalacion";

        return $this->conexion->query($sql)->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerPorId($idInstalacion)
    {
        $sql = "SELECT i.*, c.clasificacionDeResiduoCentroDeAcopio, c.capacidadCentroDeAcopio
                FROM centroDeAcopio c
                JOIN instalacion i ON i.idInstalacion = c.idInstalacion
                WHERE c.idInstalacion = ?";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$idInstalacion]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // Actualiza tanto la fila base en "instalacion" como la propia de centroDeAcopio.
    public function modificar($centro)
    {
        $sqlInstalacion = "UPDATE instalacion SET nombreInstalacion = ?, ubicacionInstalacion = ?, capacidadInstalacion = ?, estadoOperativoInstalacion = ?, tipoResiduoInstalacion = ?, latitudInstalacion = ?, longitudInstalacion = ? WHERE idInstalacion = ?";
        $stmtInstalacion = $this->conexion->prepare($sqlInstalacion);
        $stmtInstalacion->execute([$centro->getNombreInstalacion(), $centro->getUbicacionInstalacion(), $centro->getCapacidadInstalacion(), $centro->getEstadoOperativoInstalacion(), $centro->getTipoResiduoInstalacion(), $centro->getLatitudInstalacion(), $centro->getLongitudInstalacion(), $centro->getIdInstalacion()]);

        $sql = "UPDATE centroDeAcopio SET clasificacionDeResiduoCentroDeAcopio = ?, capacidadCentroDeAcopio = ? WHERE idInstalacion = ?";
        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$centro->getClasificacionDeResiduoCentroDeAcopio(), $centro->getCapacidadCentroDeAcopio(), $centro->getIdInstalacion()]);
    }

    // ON DELETE CASCADE borra la fila de centroDeAcopio al borrar la de "instalacion".
    public function eliminar($idInstalacion)
    {
        $sql = "DELETE FROM instalacion WHERE idInstalacion = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$idInstalacion]);
    }
}
?>
