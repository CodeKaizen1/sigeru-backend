<?php
require_once __DIR__ . "/../Configuration/Conexion.php";
require_once __DIR__ . "/../Model/SolicitudDeUsuario.php";

class SolicitudDeUsuarioController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    // Alta pública: hashea la contraseña antes de guardarla.
    public function crear($solicitud)
    {
        $hash = password_hash($solicitud->getContraseniaSolicitud(), PASSWORD_DEFAULT);

        $sql = "INSERT INTO solicitudDeUsuario (cedulaUsuario, nombreUsuario, apellidoUsuario, direccionCompletaUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, contraseniaSolicitud, rolSolicitado, estadoSolicitud) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$solicitud->getCedulaUsuario(), $solicitud->getNombreUsuario(), $solicitud->getApellidoUsuario(), $solicitud->getDireccionCompletaUsuario(), $solicitud->getEmailUsuario(), $solicitud->getTelefonoUsuario(), $solicitud->getFechaNacimientoUsuario(), $hash, $solicitud->getRolSolicitado(), $solicitud->getEstadoSolicitud() ?? 'pendiente']);
    }

    public function obtenerTodos()
    {
        $sql = "SELECT * FROM solicitudDeUsuario";

        return $this->conexion->query($sql)->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerPorId($idSolicitud)
    {
        $sql = "SELECT * FROM solicitudDeUsuario WHERE idSolicitud = ?";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$idSolicitud]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function obtenerPendientes()
    {
        $sql = "SELECT * FROM solicitudDeUsuario WHERE estadoSolicitud = 'pendiente'";

        return $this->conexion->query($sql)->fetchAll(PDO::FETCH_ASSOC);
    }

    // Punto 5 de la auditoría 08/10/2026: se usa al registrar, para que dos
    // solicitudes pendientes no terminen con el mismo emailUsuario. Solo mira
    // "pendiente" a propósito -- una rechazada no debería bloquear que esa
    // persona intente de nuevo con el mismo email.
    public function obtenerPendientePorEmail($emailUsuario)
    {
        $sql = "SELECT * FROM solicitudDeUsuario WHERE emailUsuario = ? AND estadoSolicitud = 'pendiente'";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$emailUsuario]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // No re-hashea contraseniaSolicitud: ese campo ya llega hasheado desde crear().
    public function modificar($solicitud)
    {
        $sql = "UPDATE solicitudDeUsuario SET nombreUsuario = ?, apellidoUsuario = ?, direccionCompletaUsuario = ?, emailUsuario = ?, telefonoUsuario = ?, fechaNacimientoUsuario = ?, contraseniaSolicitud = ?, rolSolicitado = ?, estadoSolicitud = ?, motivoRechazo = ?, fechaRechazo = ? WHERE idSolicitud = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$solicitud->getNombreUsuario(), $solicitud->getApellidoUsuario(), $solicitud->getDireccionCompletaUsuario(), $solicitud->getEmailUsuario(), $solicitud->getTelefonoUsuario(), $solicitud->getFechaNacimientoUsuario(), $solicitud->getContraseniaSolicitud(), $solicitud->getRolSolicitado(), $solicitud->getEstadoSolicitud(), $solicitud->getMotivoRechazo(), $solicitud->getFechaRechazo(), $solicitud->getIdSolicitud()]);
    }

    public function eliminar($idSolicitud)
    {
        $sql = "DELETE FROM solicitudDeUsuario WHERE idSolicitud = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$idSolicitud]);
    }
}
?>
