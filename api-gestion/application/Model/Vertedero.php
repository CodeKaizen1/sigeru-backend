<?php
class Vertedero extends Instalacion
{
    private $vidaUtil;
    private $tipoDeDispocicionVertedero;

    public function __construct($idInstalacion, $nombreInstalacion, $ubicacionInstalacion, $capacidadInstalacion, $estadoOperativoInstalacion, $tipoResiduoInstalacion, $latitudInstalacion, $longitudInstalacion, $vidaUtil, $tipoDeDispocicionVertedero)
    {
        parent::__construct($idInstalacion, $nombreInstalacion, $ubicacionInstalacion, $capacidadInstalacion, $estadoOperativoInstalacion, $tipoResiduoInstalacion, $latitudInstalacion, $longitudInstalacion);

        $this->vidaUtil = $vidaUtil;
        $this->tipoDeDispocicionVertedero = $tipoDeDispocicionVertedero;
    }

    public function getVidaUtil()
    {
        return $this->vidaUtil;
    }

    public function setVidaUtil($vidaUtil)
    {
        $this->vidaUtil = $vidaUtil;
    }

    public function getTipoDeDispocicionVertedero()
    {
        return $this->tipoDeDispocicionVertedero;
    }

    public function setTipoDeDispocicionVertedero($tipoDeDispocicionVertedero)
    {
        $this->tipoDeDispocicionVertedero = $tipoDeDispocicionVertedero;
    }
}
?>