<?php
class Contenedor
{
    private $idContenedor;
    private $ubicacionContenedor;
    private $estadoContenedor;
    private $capacidadContenedor;
    private $tipoResiduoContenedor;
    // Coordenadas para el mapa interactivo (entrega final) -- NULL-ables,
    // un contenedor sin coordenadas cargadas simplemente no aparece ahi.
    private $latitudContenedor;
    private $longitudContenedor;

    public function __construct($idContenedor, $ubicacionContenedor, $estadoContenedor, $capacidadContenedor, $tipoResiduoContenedor, $latitudContenedor = null, $longitudContenedor = null)
    {
        $this->idContenedor = $idContenedor;
        $this->ubicacionContenedor = $ubicacionContenedor;
        $this->estadoContenedor = $estadoContenedor;
        $this->capacidadContenedor = $capacidadContenedor;
        $this->tipoResiduoContenedor = $tipoResiduoContenedor;
        $this->latitudContenedor = $latitudContenedor;
        $this->longitudContenedor = $longitudContenedor;
    }

    public function getIdContenedor()
    {
        return $this->idContenedor;
    }

    public function setIdContenedor($idContenedor)
    {
        $this->idContenedor = $idContenedor;
    }

    public function getUbicacionContenedor()
    {
        return $this->ubicacionContenedor;
    }

    public function setUbicacionContenedor($ubicacionContenedor)
    {
        $this->ubicacionContenedor = $ubicacionContenedor;
    }

    public function getEstadoContenedor()
    {
        return $this->estadoContenedor;
    }

    public function setEstadoContenedor($estadoContenedor)
    {
        $this->estadoContenedor = $estadoContenedor;
    }

    public function getCapacidadContenedor()
    {
        return $this->capacidadContenedor;
    }

    public function setCapacidadContenedor($capacidadContenedor)
    {
        $this->capacidadContenedor = $capacidadContenedor;
    }

    public function getTipoResiduoContenedor()
    {
        return $this->tipoResiduoContenedor;
    }

    public function setTipoResiduoContenedor($tipoResiduoContenedor)
    {
        $this->tipoResiduoContenedor = $tipoResiduoContenedor;
    }

    public function getLatitudContenedor()
    {
        return $this->latitudContenedor;
    }

    public function setLatitudContenedor($latitudContenedor)
    {
        $this->latitudContenedor = $latitudContenedor;
    }

    public function getLongitudContenedor()
    {
        return $this->longitudContenedor;
    }

    public function setLongitudContenedor($longitudContenedor)
    {
        $this->longitudContenedor = $longitudContenedor;
    }
}
?>
