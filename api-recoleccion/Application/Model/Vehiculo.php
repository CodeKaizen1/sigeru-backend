<?php
class Vehiculo
{
    private $idVehiculo;
    private $matriculaVehiculo;
    private $marcaVehiculo;
    private $modeloVehiculo;
    private $anioVehiculo;
    private $disponibilidadVehiculo;
    private $capacidadVehiculo;
    private $mantenimientoVehiculo;
    private $idChofer;

    // idChofer: relación oficial camión-chofer.
    public function __construct($idVehiculo, $matriculaVehiculo, $marcaVehiculo, $modeloVehiculo, $anioVehiculo, $disponibilidadVehiculo, $capacidadVehiculo, $mantenimientoVehiculo, $idChofer = null)
    {
        $this->idVehiculo = $idVehiculo;
        $this->matriculaVehiculo = $matriculaVehiculo;
        $this->marcaVehiculo = $marcaVehiculo;
        $this->modeloVehiculo = $modeloVehiculo;
        $this->anioVehiculo = $anioVehiculo;
        $this->disponibilidadVehiculo = $disponibilidadVehiculo;
        $this->capacidadVehiculo = $capacidadVehiculo;
        $this->mantenimientoVehiculo = $mantenimientoVehiculo;
        $this->idChofer = $idChofer;
    }

    public function getIdVehiculo()
    {
        return $this->idVehiculo;
    }

    public function setIdVehiculo($idVehiculo)
    {
        $this->idVehiculo = $idVehiculo;
    }

    public function getMatriculaVehiculo()
    {
        return $this->matriculaVehiculo;
    }

    public function setMatriculaVehiculo($matriculaVehiculo)
    {
        $this->matriculaVehiculo = $matriculaVehiculo;
    }

    public function getMarcaVehiculo()
    {
        return $this->marcaVehiculo;
    }

    public function setMarcaVehiculo($marcaVehiculo)
    {
        $this->marcaVehiculo = $marcaVehiculo;
    }

    public function getModeloVehiculo()
    {
        return $this->modeloVehiculo;
    }

    public function setModeloVehiculo($modeloVehiculo)
    {
        $this->modeloVehiculo = $modeloVehiculo;
    }

    public function getAnioVehiculo()
    {
        return $this->anioVehiculo;
    }

    public function setAnioVehiculo($anioVehiculo)
    {
        $this->anioVehiculo = $anioVehiculo;
    }

    public function getDisponibilidadVehiculo()
    {
        return $this->disponibilidadVehiculo;
    }

    public function setDisponibilidadVehiculo($disponibilidadVehiculo)
    {
        $this->disponibilidadVehiculo = $disponibilidadVehiculo;
    }

    public function getCapacidadVehiculo()
    {
        return $this->capacidadVehiculo;
    }

    public function setCapacidadVehiculo($capacidadVehiculo)
    {
        $this->capacidadVehiculo = $capacidadVehiculo;
    }

    public function getMantenimientoVehiculo()
    {
        return $this->mantenimientoVehiculo;
    }

    public function setMantenimientoVehiculo($mantenimientoVehiculo)
    {
        $this->mantenimientoVehiculo = $mantenimientoVehiculo;
    }

    public function getIdChofer()
    {
        return $this->idChofer;
    }

    public function setIdChofer($idChofer)
    {
        $this->idChofer = $idChofer;
    }
}
?>