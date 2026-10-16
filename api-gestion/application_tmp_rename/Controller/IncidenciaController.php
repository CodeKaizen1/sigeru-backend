<?php
require_once __DIR__ . "/../../configuration/Conexion.php";
require_once __DIR__ . "/../Model/Incidencia.php";
require_once __DIR__ . "/NotificacionController.php";

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
        $sql = "INSERT INTO incidencia (idIncidencia, descripcionIncidencia, estadoIncidencia, emailResponsableIncidencia, tipoIncidencia, zonaIncidencia, fechaReporte, idContenedor, idCuadrilla, resolucionIncidencia, fechaResolucionIncidencia) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $stmt = $this->conexion->prepare($sql);

        $ok = $stmt->execute([$incidencia->getIdIncidencia(), $incidencia->getDescripcionIncidencia(), $incidencia->getEstadoIncidencia(), $incidencia->getEmailResponsableIncidencia(), $incidencia->getTipoIncidencia(), $incidencia->getZonaIncidencia(), $incidencia->getFechaReporte(), $incidencia->getIdContenedor(), $incidencia->getIdCuadrilla(), $incidencia->getResolucionIncidencia(), $incidencia->getFechaResolucionIncidencia()]);

        if (!$ok) {
            return false;
        }

        $idNueva = (int) $this->conexion->lastInsertId();

        // Punto 16: notificaciones reales. El admin se entera de toda incidencia
        // nueva; si ya viene con cuadrilla asignada (reporte hecho por un jefe
        // para su propia cuadrilla, ver crearIncidenciaDesdeCuadrilla() en
        // model.js), esa cuadrilla también se entera de una.
        $notificaciones = new NotificacionController();
        $notificaciones->crearParaAdmin('incidencia_nueva', 'Nueva incidencia: ' . $incidencia->getTipoIncidencia() . ' (' . $incidencia->getZonaIncidencia() . ')', $idNueva);

        $idCuadrilla = $incidencia->getIdCuadrilla();
        if ($idCuadrilla !== null && $idCuadrilla !== '') {
            $notificaciones->crearParaCuadrilla($idCuadrilla, 'incidencia_nueva', 'Se te asignó una nueva incidencia: ' . $incidencia->getTipoIncidencia(), $idNueva);
        }

        return $idNueva;
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
        // Se lee el estado "antes" para poder comparar después del UPDATE y
        // decidir qué notificaciones disparar (punto 16) -- ni la asignación de
        // cuadrilla ni el pasaje a "resuelta" vienen marcados aparte en el body,
        // así que la única forma de detectarlos es diffear contra la fila previa.
        $anterior = $this->obtenerPorId($incidencia->getIdIncidencia());

        $sql = "UPDATE incidencia SET descripcionIncidencia = ?, estadoIncidencia = ?, emailResponsableIncidencia = ?, tipoIncidencia = ?, zonaIncidencia = ?, fechaReporte = ?, idContenedor = ?, idCuadrilla = ?, resolucionIncidencia = ?, fechaResolucionIncidencia = ? WHERE idIncidencia = ?";

        $stmt = $this->conexion->prepare($sql);

        $ok = $stmt->execute([$incidencia->getDescripcionIncidencia(), $incidencia->getEstadoIncidencia(), $incidencia->getEmailResponsableIncidencia(), $incidencia->getTipoIncidencia(), $incidencia->getZonaIncidencia(), $incidencia->getFechaReporte(), $incidencia->getIdContenedor(), $incidencia->getIdCuadrilla(), $incidencia->getResolucionIncidencia(), $incidencia->getFechaResolucionIncidencia(), $incidencia->getIdIncidencia()]);

        if ($ok && $anterior !== false) {
            $notificaciones = new NotificacionController();

            $idCuadrillaAnterior = $anterior['idCuadrilla'] ?? null;
            $idCuadrillaNueva = $incidencia->getIdCuadrilla();
            $huboAsignacionNueva = $idCuadrillaNueva !== null && $idCuadrillaNueva !== ''
                && (string) $idCuadrillaNueva !== (string) $idCuadrillaAnterior;

            if ($huboAsignacionNueva) {
                $notificaciones->crearParaCuadrilla($idCuadrillaNueva, 'incidencia_asignada', 'Se te asignó una incidencia: ' . $incidencia->getTipoIncidencia(), $incidencia->getIdIncidencia());
            }

            $estadoAnterior = $anterior['estadoIncidencia'] ?? null;
            if ($incidencia->getEstadoIncidencia() === 'resuelta' && $estadoAnterior !== 'resuelta') {
                $notificaciones->crearParaAdmin('incidencia_resuelta', 'Incidencia resuelta: ' . $incidencia->getTipoIncidencia() . ' (' . $incidencia->getZonaIncidencia() . ')', $incidencia->getIdIncidencia());
            }
        }

        return $ok;
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

    // Zona real de la ruta asignada a la cuadrilla (join cuadrilla -> ruta),
    // para que cuando un jefe reporta una incidencia para su propia cuadrilla
    // la zonaIncidencia se derive server-side, igual que ya se hacía con el
    // reporte público vía el contenedor. No confiar en el zonaIncidencia que
    // mande el cliente (auditoria 08/10/2026, punto 4 de la Fase 1).
    public function zonaDeCuadrilla($idCuadrilla)
    {
        if ($idCuadrilla === null || $idCuadrilla === '') {
            return null;
        }

        $sql = "SELECT r.zonaRuta FROM cuadrilla c
                JOIN ruta r ON r.idRuta = c.idRuta
                WHERE c.idCuadrilla = ?";
        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$idCuadrilla]);

        $zona = $stmt->fetchColumn();
        return $zona !== false ? $zona : null;
    }
}
?>