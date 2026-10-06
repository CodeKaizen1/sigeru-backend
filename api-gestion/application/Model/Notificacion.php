<?php

class Notificacion
{
    private $idNotificacion;
    private $destinatarioTipoNotificacion;
    private $idCuadrillaNotificacion;
    private $tipoNotificacion;
    private $mensajeNotificacion;
    private $idEntidadNotificacion;

    // fechaNotificacion y leidaNotificacion no entran acá: la columna los
    // completa sola (DEFAULT CURRENT_TIMESTAMP / DEFAULT FALSE) -- ver 01_code.sql.
    public function __construct($idNotificacion, $destinatarioTipoNotificacion, $idCuadrillaNotificacion, $tipoNotificacion, $mensajeNotificacion, $idEntidadNotificacion)
    {
        $this->idNotificacion = $idNotificacion;
        $this->destinatarioTipoNotificacion = $destinatarioTipoNotificacion;
        $this->idCuadrillaNotificacion = $idCuadrillaNotificacion;
        $this->tipoNotificacion = $tipoNotificacion;
        $this->mensajeNotificacion = $mensajeNotificacion;
        $this->idEntidadNotificacion = $idEntidadNotificacion;
    }

    public function getIdNotificacion()
    {
        return $this->idNotificacion;
    }

    public function setIdNotificacion($idNotificacion)
    {
        $this->idNotificacion = $idNotificacion;
    }

    public function getDestinatarioTipoNotificacion()
    {
        return $this->destinatarioTipoNotificacion;
    }

    public function setDestinatarioTipoNotificacion($destinatarioTipoNotificacion)
    {
        $this->destinatarioTipoNotificacion = $destinatarioTipoNotificacion;
    }

    public function getIdCuadrillaNotificacion()
    {
        return $this->idCuadrillaNotificacion;
    }

    public function setIdCuadrillaNotificacion($idCuadrillaNotificacion)
    {
        $this->idCuadrillaNotificacion = $idCuadrillaNotificacion;
    }

    public function getTipoNotificacion()
    {
        return $this->tipoNotificacion;
    }

    public function setTipoNotificacion($tipoNotificacion)
    {
        $this->tipoNotificacion = $tipoNotificacion;
    }

    public function getMensajeNotificacion()
    {
        return $this->mensajeNotificacion;
    }

    public function setMensajeNotificacion($mensajeNotificacion)
    {
        $this->mensajeNotificacion = $mensajeNotificacion;
    }

    public function getIdEntidadNotificacion()
    {
        return $this->idEntidadNotificacion;
    }

    public function setIdEntidadNotificacion($idEntidadNotificacion)
    {
        $this->idEntidadNotificacion = $idEntidadNotificacion;
    }
}
?>
