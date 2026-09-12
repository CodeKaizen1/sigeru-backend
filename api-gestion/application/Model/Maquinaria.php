<?php
class Maquinaria
{
    private $idMaquinaria;
    private $tipoDeMaquinaria;
    private $estadoMaquinaria;
    private $disponibilidadMaquinaria;
    private $idInstalacion;

    public function __construct($idMaquinaria, $tipoDeMaquinaria, $estadoMaquinaria, $disponibilidadMaquinaria, $idInstalacion)
    {
        $this->idMaquinaria = $idMaquinaria;
        $this->tipoDeMaquinaria = $tipoDeMaquinaria;
        $this->estadoMaquinaria = $estadoMaquinaria;
        $this->disponibilidadMaquinaria = $disponibilidadMaquinaria;
        $this->idInstalacion = $idInstalacion;
    }

    public function getIdMaquinaria()
    {
        return $this->idMaquinaria;
    }

    public function setIdMaquinaria($idMaquinaria)
    {
        $this->idMaquinaria = $idMaquinaria;
    }

    public function getTipoDeMaquinaria()
    {
        return $this->tipoDeMaquinaria;
    }

    public function setTipoDeMaquinaria($tipoDeMaquinaria)
    {
        $this->tipoDeMaquinaria = $tipoDeMaquinaria;
    }

    public function getEstadoMaquinaria()
    {
        return $this->estadoMaquinaria;
    }

    public function setEstadoMaquinaria($estadoMaquinaria)
    {
        $this->estadoMaquinaria = $estadoMaquinaria;
    }

    public function getDisponibilidadMaquinaria()
    {
        return $this->disponibilidadMaquinaria;
    }

    public function setDisponibilidadMaquinaria($disponibilidadMaquinaria)
    {
        $this->disponibilidadMaquinaria = $disponibilidadMaquinaria;
    }

    public function getIdInstalacion()
    {
        return $this->idInstalacion;
    }

    public function setIdInstalacion($idInstalacion)
    {
        $this->idInstalacion = $idInstalacion;
    }
}
?>