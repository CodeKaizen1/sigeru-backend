<?php
class SolicitudDeUsuario
{
    private $idSolicitud;
    private $cedulaUsuario;
    private $nombreUsuario;
    private $apellidoUsuario;
    private $direccionCompletaUsuario;
    private $emailUsuario;
    private $telefonoUsuario;
    private $fechaNacimientoUsuario;
    private $contraseniaSolicitud;
    private $rolSolicitado;
    private $estadoSolicitud;
    private $fechaSolicitud;
    private $motivoRechazo;
    private $fechaRechazo;

    public function __construct($idSolicitud, $cedulaUsuario, $nombreUsuario, $apellidoUsuario, $direccionCompletaUsuario, $emailUsuario, $telefonoUsuario, $fechaNacimientoUsuario, $contraseniaSolicitud, $rolSolicitado, $estadoSolicitud, $fechaSolicitud, $motivoRechazo, $fechaRechazo = null)
    {
        $this->idSolicitud = $idSolicitud;
        $this->cedulaUsuario = $cedulaUsuario;
        $this->nombreUsuario = $nombreUsuario;
        $this->apellidoUsuario = $apellidoUsuario;
        $this->direccionCompletaUsuario = $direccionCompletaUsuario;
        $this->emailUsuario = $emailUsuario;
        $this->telefonoUsuario = $telefonoUsuario;
        $this->fechaNacimientoUsuario = $fechaNacimientoUsuario;
        $this->contraseniaSolicitud = $contraseniaSolicitud;
        $this->rolSolicitado = $rolSolicitado;
        $this->estadoSolicitud = $estadoSolicitud;
        $this->fechaSolicitud = $fechaSolicitud;
        $this->motivoRechazo = $motivoRechazo;
        $this->fechaRechazo = $fechaRechazo;
    }

    public function getIdSolicitud()
    {
        return $this->idSolicitud;
    }

    public function setIdSolicitud($idSolicitud)
    {
        $this->idSolicitud = $idSolicitud;
    }

    public function getCedulaUsuario()
    {
        return $this->cedulaUsuario;
    }

    public function setCedulaUsuario($cedulaUsuario)
    {
        $this->cedulaUsuario = $cedulaUsuario;
    }

    public function getNombreUsuario()
    {
        return $this->nombreUsuario;
    }

    public function setNombreUsuario($nombreUsuario)
    {
        $this->nombreUsuario = $nombreUsuario;
    }

    public function getApellidoUsuario()
    {
        return $this->apellidoUsuario;
    }

    public function setApellidoUsuario($apellidoUsuario)
    {
        $this->apellidoUsuario = $apellidoUsuario;
    }

    public function getDireccionCompletaUsuario()
    {
        return $this->direccionCompletaUsuario;
    }

    public function setDireccionCompletaUsuario($direccionCompletaUsuario)
    {
        $this->direccionCompletaUsuario = $direccionCompletaUsuario;
    }

    public function getEmailUsuario()
    {
        return $this->emailUsuario;
    }

    public function setEmailUsuario($emailUsuario)
    {
        $this->emailUsuario = $emailUsuario;
    }

    public function getTelefonoUsuario()
    {
        return $this->telefonoUsuario;
    }

    public function setTelefonoUsuario($telefonoUsuario)
    {
        $this->telefonoUsuario = $telefonoUsuario;
    }

    public function getFechaNacimientoUsuario()
    {
        return $this->fechaNacimientoUsuario;
    }

    public function setFechaNacimientoUsuario($fechaNacimientoUsuario)
    {
        $this->fechaNacimientoUsuario = $fechaNacimientoUsuario;
    }

    public function getContraseniaSolicitud()
    {
        return $this->contraseniaSolicitud;
    }

    public function setContraseniaSolicitud($contraseniaSolicitud)
    {
        $this->contraseniaSolicitud = $contraseniaSolicitud;
    }

    public function getRolSolicitado()
    {
        return $this->rolSolicitado;
    }

    public function setRolSolicitado($rolSolicitado)
    {
        $this->rolSolicitado = $rolSolicitado;
    }

    public function getEstadoSolicitud()
    {
        return $this->estadoSolicitud;
    }

    public function setEstadoSolicitud($estadoSolicitud)
    {
        $this->estadoSolicitud = $estadoSolicitud;
    }

    public function getFechaSolicitud()
    {
        return $this->fechaSolicitud;
    }

    public function setFechaSolicitud($fechaSolicitud)
    {
        $this->fechaSolicitud = $fechaSolicitud;
    }

    public function getMotivoRechazo()
    {
        return $this->motivoRechazo;
    }

    public function setMotivoRechazo($motivoRechazo)
    {
        $this->motivoRechazo = $motivoRechazo;
    }

    public function getFechaRechazo()
    {
        return $this->fechaRechazo;
    }

    public function setFechaRechazo($fechaRechazo)
    {
        $this->fechaRechazo = $fechaRechazo;
    }
}
?>
