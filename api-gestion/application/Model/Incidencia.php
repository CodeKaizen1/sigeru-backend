<?php

class Incidencia
{
    private $idIncidencia;
    private $descripcionIncidencia;
    private $estadoIncidencia;
    private $emailResponsableIncidencia;
    private $tipoIncidencia;
    private $zonaIncidencia;
    private $fechaReporte;
    private $idContenedor;
    private $idCuadrilla;
    private $resolucionIncidencia;
    private $fechaResolucionIncidencia;

    public function __construct($idIncidencia, $descripcionIncidencia, $estadoIncidencia, $emailResponsableIncidencia, $tipoIncidencia, $zonaIncidencia, $fechaReporte, $idContenedor, $idCuadrilla, $resolucionIncidencia = null, $fechaResolucionIncidencia = null)
    {
        $this->idIncidencia = $idIncidencia;
        $this->descripcionIncidencia = $descripcionIncidencia;
        $this->estadoIncidencia = $estadoIncidencia;
        $this->emailResponsableIncidencia = $emailResponsableIncidencia;
        $this->tipoIncidencia = $tipoIncidencia;
        $this->zonaIncidencia = $zonaIncidencia;
        $this->fechaReporte = $fechaReporte;
        $this->idContenedor = $idContenedor;
        $this->idCuadrilla = $idCuadrilla;
        $this->resolucionIncidencia = $resolucionIncidencia;
        $this->fechaResolucionIncidencia = $fechaResolucionIncidencia;
    }

        public function getIdIncidencia()
    {
        return $this->idIncidencia;
    }

    public function setIdIncidencia($idIncidencia)
    {
        $this->idIncidencia = $idIncidencia;
    }

    public function getDescripcionIncidencia()
    {
        return $this->descripcionIncidencia;
    }

    public function setDescripcionIncidencia($descripcionIncidencia)
    {
        $this->descripcionIncidencia = $descripcionIncidencia;
    }

    public function getEstadoIncidencia()
    {
        return $this->estadoIncidencia;
    }

    public function setEstadoIncidencia($estadoIncidencia)
    {
        $this->estadoIncidencia = $estadoIncidencia;
    }

    public function getEmailResponsableIncidencia()
    {
        return $this->emailResponsableIncidencia;
    }

    public function setEmailResponsableIncidencia($emailResponsableIncidencia)
    {
        $this->emailResponsableIncidencia = $emailResponsableIncidencia;
    }

    public function getTipoIncidencia()
    {
        return $this->tipoIncidencia;
    }

    public function setTipoIncidencia($tipoIncidencia)
    {
        $this->tipoIncidencia = $tipoIncidencia;
    }

    public function getZonaIncidencia()
    {
        return $this->zonaIncidencia;
    }

    public function setZonaIncidencia($zonaIncidencia)
    {
        $this->zonaIncidencia = $zonaIncidencia;
    }

    public function getFechaReporte()
    {
        return $this->fechaReporte;
    }

    public function setFechaReporte($fechaReporte)
    {
        $this->fechaReporte = $fechaReporte;
    }

    public function getIdContenedor()
    {
        return $this->idContenedor;
    }

    public function setIdContenedor($idContenedor)
    {
        $this->idContenedor = $idContenedor;
    }

    public function getIdCuadrilla()
    {
        return $this->idCuadrilla;
    }

    public function setIdCuadrilla($idCuadrilla)
    {
        $this->idCuadrilla = $idCuadrilla;
    }

    public function getResolucionIncidencia()
    {
        return $this->resolucionIncidencia;
    }

    public function setResolucionIncidencia($resolucionIncidencia)
    {
        $this->resolucionIncidencia = $resolucionIncidencia;
    }

    public function getFechaResolucionIncidencia()
    {
        return $this->fechaResolucionIncidencia;
    }

    public function setFechaResolucionIncidencia($fechaResolucionIncidencia)
    {
        $this->fechaResolucionIncidencia = $fechaResolucionIncidencia;
    }
}
?>