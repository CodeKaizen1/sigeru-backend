<?php
class Residuo
{
    private $idResiduo;
    private $pesoResiduo;
    private $fechaResiduo;

    public function __construct($idResiduo, $pesoResiduo, $fechaResiduo)
    {
        $this->idResiduo = $idResiduo;
        $this->pesoResiduo = $pesoResiduo;
        $this->fechaResiduo = $fechaResiduo;
    }

    public function getIdResiduo()
    {
        return $this->idResiduo;
    }

    public function setIdResiduo($idResiduo)
    {
        $this->idResiduo = $idResiduo;
    }

    public function getPesoResiduo()
    {
        return $this->pesoResiduo;
    }

    public function setPesoResiduo($pesoResiduo)
    {
        $this->pesoResiduo = $pesoResiduo;
    }

    public function getFechaResiduo()
    {
        return $this->fechaResiduo;
    }

    public function setFechaResiduo($fechaResiduo)
    {
        $this->fechaResiduo = $fechaResiduo;
    }
}
?>
