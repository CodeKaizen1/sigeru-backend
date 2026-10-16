<?php
class Instalacion
{
    private $idInstalacion;
    private $nombreInstalacion;
    private $ubicacionInstalacion;
    private $capacidadInstalacion;
    private $estadoOperativoInstalacion;
    private $tipoResiduoInstalacion;
    private $latitudInstalacion;
    private $longitudInstalacion;

    public function __construct($idInstalacion, $nombreInstalacion, $ubicacionInstalacion, $capacidadInstalacion, $estadoOperativoInstalacion, $tipoResiduoInstalacion, $latitudInstalacion, $longitudInstalacion)
    {
        $this->idInstalacion = $idInstalacion;
        $this->nombreInstalacion = $nombreInstalacion;
        $this->ubicacionInstalacion = $ubicacionInstalacion;
        $this->capacidadInstalacion = $capacidadInstalacion;
        $this->estadoOperativoInstalacion = $estadoOperativoInstalacion;
        $this->tipoResiduoInstalacion = $tipoResiduoInstalacion;
        $this->latitudInstalacion = $latitudInstalacion;
        $this->longitudInstalacion = $longitudInstalacion;
    }

    public function getIdInstalacion()
    {
        return $this->idInstalacion;
    }

    public function setIdInstalacion($idInstalacion)
    {
        $this->idInstalacion = $idInstalacion;
    }

    public function getNombreInstalacion()
    {
        return $this->nombreInstalacion;
    }

    public function setNombreInstalacion($nombreInstalacion)
    {
        $this->nombreInstalacion = $nombreInstalacion;
    }

    public function getUbicacionInstalacion()
    {
        return $this->ubicacionInstalacion;
    }

    public function setUbicacionInstalacion($ubicacionInstalacion)
    {
        $this->ubicacionInstalacion = $ubicacionInstalacion;
    }

    public function getCapacidadInstalacion()
    {
        return $this->capacidadInstalacion;
    }

    public function setCapacidadInstalacion($capacidadInstalacion)
    {
        $this->capacidadInstalacion = $capacidadInstalacion;
    }

    public function getEstadoOperativoInstalacion()
    {
        return $this->estadoOperativoInstalacion;
    }

    public function setEstadoOperativoInstalacion($estadoOperativoInstalacion)
    {
        $this->estadoOperativoInstalacion = $estadoOperativoInstalacion;
    }

    public function getTipoResiduoInstalacion()
    {
        return $this->tipoResiduoInstalacion;
    }

    public function setTipoResiduoInstalacion($tipoResiduoInstalacion)
    {
        $this->tipoResiduoInstalacion = $tipoResiduoInstalacion;
    }

    public function getLatitudInstalacion()
    {
        return $this->latitudInstalacion;
    }

    public function setLatitudInstalacion($latitudInstalacion)
    {
        $this->latitudInstalacion = $latitudInstalacion;
    }

    public function getLongitudInstalacion()
    {
        return $this->longitudInstalacion;
    }

    public function setLongitudInstalacion($longitudInstalacion)
    {
        $this->longitudInstalacion = $longitudInstalacion;
    }
}
?>