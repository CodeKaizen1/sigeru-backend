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
    // Barrio y municipio (entrega final, enriquecimiento de los contenedores
    // oficiales IMM) -- tambien NULL-ables: un contenedor creado a mano desde
    // el panel de admin puede no tenerlos.
    private $zonaContenedor;
    private $municipioContenedor;

    public function __construct($idContenedor, $ubicacionContenedor, $estadoContenedor, $capacidadContenedor, $tipoResiduoContenedor, $latitudContenedor = null, $longitudContenedor = null, $zonaContenedor = null, $municipioContenedor = null)
    {
        $this->idContenedor = $idContenedor;
        $this->ubicacionContenedor = $ubicacionContenedor;
        $this->estadoContenedor = $estadoContenedor;
        $this->capacidadContenedor = $capacidadContenedor;
        $this->tipoResiduoContenedor = $tipoResiduoContenedor;
        $this->latitudContenedor = $latitudContenedor;
        $this->longitudContenedor = $longitudContenedor;
        $this->zonaContenedor = $zonaContenedor;
        $this->municipioContenedor = $municipioContenedor;
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

    public function getZonaContenedor()
    {
        return $this->zonaContenedor;
    }

    public function setZonaContenedor($zonaContenedor)
    {
        $this->zonaContenedor = $zonaContenedor;
    }

    public function getMunicipioContenedor()
    {
        return $this->municipioContenedor;
    }

    public function setMunicipioContenedor($municipioContenedor)
    {
        $this->municipioContenedor = $municipioContenedor;
    }
}
?>
