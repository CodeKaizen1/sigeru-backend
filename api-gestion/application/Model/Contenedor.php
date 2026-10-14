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
    // idRuta/ordenRutaContenedor (14/10/2026, 01_code.sql seccion 12): a que
    // ruta puntual pertenece este contenedor y en que posicion de esa ruta
    // se recolecta -- se completan desde "Nueva ruta" en el panel de admin,
    // no son campos que tipee el admin en el alta/edicion normal de un
    // contenedor suelto. NULL-ables: un contenedor sin ruta asignada
    // simplemente no aparece en ningun panel de chofer/jefe/operario.
    private $idRuta;
    private $ordenRutaContenedor;

    public function __construct($idContenedor, $ubicacionContenedor, $estadoContenedor, $capacidadContenedor, $tipoResiduoContenedor, $latitudContenedor = null, $longitudContenedor = null, $zonaContenedor = null, $municipioContenedor = null, $idRuta = null, $ordenRutaContenedor = null)
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
        $this->idRuta = $idRuta;
        $this->ordenRutaContenedor = $ordenRutaContenedor;
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

    public function getIdRuta()
    {
        return $this->idRuta;
    }

    public function setIdRuta($idRuta)
    {
        $this->idRuta = $idRuta;
    }

    public function getOrdenRutaContenedor()
    {
        return $this->ordenRutaContenedor;
    }

    public function setOrdenRutaContenedor($ordenRutaContenedor)
    {
        $this->ordenRutaContenedor = $ordenRutaContenedor;
    }
}
?>
