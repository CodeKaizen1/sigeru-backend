<?php
class OperarioDeCuadrilla extends Usuario
{
    protected $idOperarioDeCuadrilla;
    protected $estadoOperarioDeCuadrilla;
    protected $cargoOperarioDeCuadrilla;
    protected $turnoOperarioDeCuadrilla;
    protected $horaInicioOperarioDeCuadrilla;
    protected $horaFinOperarioDeCuadrilla;
    protected $licenciaDeConducirOperarioDeCuadrilla;
    protected $idCuadrilla;

    public function __construct($cedulaUsuario, $nombreUsuario, $apellidoUsuario, $calleUsuario, $numeroPuertaUsuario, $numeroApartamentoUsuario, $emailUsuario, $telefonoUsuario, $fechaNacimientoUsuario, $estadoUsuario, $rolUsuario, $idOperarioDeCuadrilla, $estadoOperarioDeCuadrilla, $cargoOperarioDeCuadrilla, $turnoOperarioDeCuadrilla, $horaInicioOperarioDeCuadrilla, $horaFinOperarioDeCuadrilla, $licenciaDeConducirOperarioDeCuadrilla, $idCuadrilla)
    {
        parent::__construct($cedulaUsuario, $nombreUsuario, $apellidoUsuario, $calleUsuario, $numeroPuertaUsuario, $numeroApartamentoUsuario, $emailUsuario, $telefonoUsuario, $fechaNacimientoUsuario, $estadoUsuario, $rolUsuario);

        $this->idOperarioDeCuadrilla = $idOperarioDeCuadrilla;
        $this->estadoOperarioDeCuadrilla = $estadoOperarioDeCuadrilla;
        $this->cargoOperarioDeCuadrilla = $cargoOperarioDeCuadrilla;
        $this->turnoOperarioDeCuadrilla = $turnoOperarioDeCuadrilla;
        $this->horaInicioOperarioDeCuadrilla = $horaInicioOperarioDeCuadrilla;
        $this->horaFinOperarioDeCuadrilla = $horaFinOperarioDeCuadrilla;
        $this->licenciaDeConducirOperarioDeCuadrilla = $licenciaDeConducirOperarioDeCuadrilla;
        $this->idCuadrilla = $idCuadrilla;
    }

    public function getIdOperarioDeCuadrilla()
    {
        return $this->idOperarioDeCuadrilla;
    }

    public function setIdOperarioDeCuadrilla($idOperarioDeCuadrilla)
    {
        $this->idOperarioDeCuadrilla = $idOperarioDeCuadrilla;
    }

    public function getEstadoOperarioDeCuadrilla()
    {
        return $this->estadoOperarioDeCuadrilla;
    }

    public function setEstadoOperarioDeCuadrilla($estadoOperarioDeCuadrilla)
    {
        $this->estadoOperarioDeCuadrilla = $estadoOperarioDeCuadrilla;
    }

    public function getCargoOperarioDeCuadrilla()
    {
        return $this->cargoOperarioDeCuadrilla;
    }

    public function setCargoOperarioDeCuadrilla($cargoOperarioDeCuadrilla)
    {
        $this->cargoOperarioDeCuadrilla = $cargoOperarioDeCuadrilla;
    }

    public function getTurnoOperarioDeCuadrilla()
    {
        return $this->turnoOperarioDeCuadrilla;
    }

    public function setTurnoOperarioDeCuadrilla($turnoOperarioDeCuadrilla)
    {
        $this->turnoOperarioDeCuadrilla = $turnoOperarioDeCuadrilla;
    }

    public function getHoraInicioOperarioDeCuadrilla()
    {
        return $this->horaInicioOperarioDeCuadrilla;
    }

    public function setHoraInicioOperarioDeCuadrilla($horaInicioOperarioDeCuadrilla)
    {
        $this->horaInicioOperarioDeCuadrilla = $horaInicioOperarioDeCuadrilla;
    }

    public function getHoraFinOperarioDeCuadrilla()
    {
        return $this->horaFinOperarioDeCuadrilla;
    }

    public function setHoraFinOperarioDeCuadrilla($horaFinOperarioDeCuadrilla)
    {
        $this->horaFinOperarioDeCuadrilla = $horaFinOperarioDeCuadrilla;
    }

    public function getLicenciaDeConducirOperarioDeCuadrilla()
    {
        return $this->licenciaDeConducirOperarioDeCuadrilla;
    }

    public function setLicenciaDeConducirOperarioDeCuadrilla($licenciaDeConducirOperarioDeCuadrilla)
    {
        $this->licenciaDeConducirOperarioDeCuadrilla = $licenciaDeConducirOperarioDeCuadrilla;
    }

    public function getIdCuadrilla()
    {
        return $this->idCuadrilla;
    }

    public function setIdCuadrilla($idCuadrilla)
    {
        $this->idCuadrilla = $idCuadrilla;
    }
}
?>
