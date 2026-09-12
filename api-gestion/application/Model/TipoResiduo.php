<?php
class TipoResiduo
{
    private $idTipoResiduo;
    private $nombreTipoResiduo;
    private $descripcionTipoResiduo;
    private $esReciclableTipoResiduo;

    public function __construct($idTipoResiduo, $nombreTipoResiduo, $descripcionTipoResiduo, $esReciclableTipoResiduo)
    {
        $this->idTipoResiduo = $idTipoResiduo;
        $this->nombreTipoResiduo = $nombreTipoResiduo;
        $this->descripcionTipoResiduo = $descripcionTipoResiduo;
        $this->esReciclableTipoResiduo = $esReciclableTipoResiduo;
    }

    public function getIdTipoResiduo()
    {
        return $this->idTipoResiduo;
    }

    public function setIdTipoResiduo($idTipoResiduo)
    {
        $this->idTipoResiduo = $idTipoResiduo;
    }

    public function getNombreTipoResiduo()
    {
        return $this->nombreTipoResiduo;
    }

    public function setNombreTipoResiduo($nombreTipoResiduo)
    {
        $this->nombreTipoResiduo = $nombreTipoResiduo;
    }

    public function getDescripcionTipoResiduo()
    {
        return $this->descripcionTipoResiduo;
    }

    public function setDescripcionTipoResiduo($descripcionTipoResiduo)
    {
        $this->descripcionTipoResiduo = $descripcionTipoResiduo;
    }

    public function getEsReciclableTipoResiduo()
    {
        return $this->esReciclableTipoResiduo;
    }

    public function setEsReciclableTipoResiduo($esReciclableTipoResiduo)
    {
        $this->esReciclableTipoResiduo = $esReciclableTipoResiduo;
    }
}
?>
