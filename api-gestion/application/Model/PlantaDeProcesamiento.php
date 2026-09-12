<?php
class PlantaDeProcesamiento extends Instalacion
{
    private $capacidadPlantaDeProcesamiento;
    private $tipoDeProcesoPlantaDeProcesamiento;

    public function __construct($idInstalacion, $nombreInstalacion, $ubicacionInstalacion, $capacidadInstalacion, $estadoOperativoInstalacion, $tipoResiduoInstalacion, $latitudInstalacion, $longitudInstalacion, $capacidadPlantaDeProcesamiento, $tipoDeProcesoPlantaDeProcesamiento)
    {
        parent::__construct($idInstalacion, $nombreInstalacion, $ubicacionInstalacion, $capacidadInstalacion, $estadoOperativoInstalacion, $tipoResiduoInstalacion, $latitudInstalacion, $longitudInstalacion);

        $this->capacidadPlantaDeProcesamiento = $capacidadPlantaDeProcesamiento;
        $this->tipoDeProcesoPlantaDeProcesamiento = $tipoDeProcesoPlantaDeProcesamiento;
    }

    public function getCapacidadPlantaDeProcesamiento()
    {
        return $this->capacidadPlantaDeProcesamiento;
    }

    public function setCapacidadPlantaDeProcesamiento($capacidadPlantaDeProcesamiento)
    {
        $this->capacidadPlantaDeProcesamiento = $capacidadPlantaDeProcesamiento;
    }

    public function getTipoDeProcesoPlantaDeProcesamiento()
    {
        return $this->tipoDeProcesoPlantaDeProcesamiento;
    }

    public function setTipoDeProcesoPlantaDeProcesamiento($tipoDeProcesoPlantaDeProcesamiento)
    {
        $this->tipoDeProcesoPlantaDeProcesamiento = $tipoDeProcesoPlantaDeProcesamiento;
    }
}
?>