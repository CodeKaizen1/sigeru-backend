<?php
class Cuadrilla
{
    private $idCuadrilla;
    private $nombreCuadrilla;
    private $idChofer;
    private $idJefeCuadrilla;
    private $idRuta;
    // Alta/baja administrativa de la cuadrilla. Default "activa".
    private $estadoCuadrilla;

    public function __construct($idCuadrilla, $nombreCuadrilla, $idChofer, $idJefeCuadrilla, $idRuta, $estadoCuadrilla = 'activa')
    {
        $this->idCuadrilla = $idCuadrilla;
        $this->nombreCuadrilla = $nombreCuadrilla;
        $this->idChofer = $idChofer;
        $this->idJefeCuadrilla = $idJefeCuadrilla;
        $this->idRuta = $idRuta;
        $this->estadoCuadrilla = $estadoCuadrilla ?? 'activa';
    }

    public function getIdCuadrilla()
    {
        return $this->idCuadrilla;
    }

    public function setIdCuadrilla($idCuadrilla)
    {
        $this->idCuadrilla = $idCuadrilla;
    }

    public function getNombreCuadrilla()
    {
        return $this->nombreCuadrilla;
    }

    public function setNombreCuadrilla($nombreCuadrilla)
    {
        $this->nombreCuadrilla = $nombreCuadrilla;
    }

    public function getIdChofer()
    {
        return $this->idChofer;
    }

    public function setIdChofer($idChofer)
    {
        $this->idChofer = $idChofer;
    }

    public function getIdJefeCuadrilla()
    {
        return $this->idJefeCuadrilla;
    }

    public function setIdJefeCuadrilla($idJefeCuadrilla)
    {
        $this->idJefeCuadrilla = $idJefeCuadrilla;
    }

    public function getIdRuta()
    {
        return $this->idRuta;
    }

    public function setIdRuta($idRuta)
    {
        $this->idRuta = $idRuta;
    }

    public function getEstadoCuadrilla()
    {
        return $this->estadoCuadrilla;
    }

    public function setEstadoCuadrilla($estadoCuadrilla)
    {
        $this->estadoCuadrilla = $estadoCuadrilla;
    }
}
?>
