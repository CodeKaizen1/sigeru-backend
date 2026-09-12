<?php
require_once __DIR__ . "/../../configuration/Conexion.php";
require_once __DIR__ . "/../Model/Incidencia.php";

class IncidenciaController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    // Devuelve el idIncidencia recién generado (o false si falló), a diferencia de los demás crear().
    public function crear($incidencia)
    {
        $sql = "INSERT INTO incidencia (idIncidencia, descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $stmt = $this->conexion->prepare($sql);

        $ok = $stmt->execute([$incidencia->getIdIncidencia(), $incidencia->getDescripcionIncidencia(), $incidencia->getEstadoIncidencia(), $incidencia->getEmailResponsableIncidencia(), $incidencia->getTipoIncidencia(), $incidencia->getZonaIncidencia(), $incidencia->getFechaReporte(), $incidencia->getIdContenedor(), $incidencia->getIdCuadrilla()]);

        if (!$ok) {
            return false;
        }

        return (int) $this->conexion->lastInsertId();
    }


    public function obtenerTodos()
    {
        $sql = "SELECT * FROM incidencia";

        $stmt = $this->conexion->query($sql);

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerPorId($idIncidencia)
    {
        $sql = "SELECT * FROM incidencia WHERE idIncidencia = ?";

        $stmt = $this->conexion->prepare($sql);

        $stmt->execute([$idIncidencia]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function modificar($incidencia)
    {
        $sql = "UPDATE incidencia SET descripcionIncidencia = ?, estadoIncidencia = ?, emailResponsableIncidencia = ?, tipoIncidencia = ?, zonaIncidencia = ?, fechaReporte = ?, idContenedor = ?, idCuadrilla = ? WHERE idIncidencia = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$incidencia->getDescripcionIncidencia(), $incidencia->getEstadoIncidencia(), $incidencia->getEmailResponsableIncidencia(), $incidencia->getTipoIncidencia(), $incidencia->getZonaIncidencia(), $incidencia->getFechaReporte(), $incidencia->getIdContenedor(), $incidencia->getIdCuadrilla(), $incidencia->getIdIncidencia()]);
    }

    public function eliminar($idIncidencia)
    {
        $sql = "DELETE FROM incidencia WHERE idIncidencia = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$idIncidencia]);
    }

    // Verifica que la cuadrilla sea liderada por el jefe con esa cédula (join contra
    // operarioDeCuadrilla, porque cuadrilla.idJefeCuadrilla no es la cédula directamente).
    public function idCuadrillaPerteneceAJefe($idCuadrilla, $cedulaJefe)
    {
        if ($idCuadrilla === null || $idCuadrilla === '' || $cedulaJefe === null) {
            return false;
        }

        $sql = "SELECT COUNT(*) FROM cuadrilla c
                JOIN operarioDeCuadrilla o ON o.idOperarioDeCuadrilla = c.idJefeCuadrilla
                WHERE c.idCuadrilla = ? AND o.cedulaUsuario = ?";
        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$idCuadrilla, $cedulaJefe]);

        return $stmt->fetchColumn() > 0;
    }
}
?>