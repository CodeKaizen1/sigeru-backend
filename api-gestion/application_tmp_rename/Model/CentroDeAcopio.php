<?php
class CentroDeAcopio extends Instalacion
{
    private $clasificacionDeResiduoCentroDeAcopio;
    private $capacidadCentroDeAcopio;

    public function __construct($idInstalacion, $nombreInstalacion, $ubicacionInstalacion, $capacidadInstalacion, $estadoOperativoInstalacion, $tipoResiduoInstalacion, $latitudInstalacion, $longitudInstalacion, $clasificacionDeResiduoCentroDeAcopio, $capacidadCentroDeAcopio)
    {
        parent::__construct($idInstalacion, $nombreInstalacion, $ubicacionInstalacion, $capacidadInstalacion, $estadoOperativoInstalacion, $tipoResiduoInstalacion, $latitudInstalacion, $longitudInstalacion);

        $this->clasificacionDeResiduoCentroDeAcopio = $clasificacionDeResiduoCentroDeAcopio;
        $this->capacidadCentroDeAcopio = $capacidadCentroDeAcopio;
    }

    public function getClasificacionDeResiduoCentroDeAcopio()
    {
        return $this->clasificacionDeResiduoCentroDeAcopio;
    }

    public function setClasificacionDeResiduoCentroDeAcopio($clasificacionDeResiduoCentroDeAcopio)
    {
        $this->clasificacionDeResiduoCentroDeAcopio = $clasificacionDeResiduoCentroDeAcopio;
    }

    public function getCapacidadCentroDeAcopio()
    {
        return $this->capacidadCentroDeAcopio;
    }

    public function setCapacidadCentroDeAcopio($capacidadCentroDeAcopio)
    {
        $this->capacidadCentroDeAcopio = $capacidadCentroDeAcopio;
    }
}
?>