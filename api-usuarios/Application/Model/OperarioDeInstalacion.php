<?php
class OperarioDeInstalacion extends Usuario
{
    protected $turnoOperarioDeInstalacion;
    protected $instalacionAsignada;
    protected $estadoOperarioDeInstalacion;
    protected $cargoOperarioDeInstalacion;

    public function __construct($cedulaUsuario, $nombreUsuario, $apellidoUsuario, $calleUsuario, $numeroPuertaUsuario, $numeroApartamentoUsuario, $emailUsuario, $telefonoUsuario, $fechaNacimientoUsuario, $estadoUsuario, $rolUsuario, $turnoOperarioDeInstalacion, $instalacionAsignada, $estadoOperarioDeInstalacion, $cargoOperarioDeInstalacion)
    {
        parent::__construct($cedulaUsuario, $nombreUsuario, $apellidoUsuario, $calleUsuario, $numeroPuertaUsuario, $numeroApartamentoUsuario, $emailUsuario, $telefonoUsuario, $fechaNacimientoUsuario, $estadoUsuario, $rolUsuario);

        $this->turnoOperarioDeInstalacion = $turnoOperarioDeInstalacion;
        $this->instalacionAsignada = $instalacionAsignada;
        $this->estadoOperarioDeInstalacion = $estadoOperarioDeInstalacion;
        $this->cargoOperarioDeInstalacion = $cargoOperarioDeInstalacion;
    }

    public function getTurnoOperarioDeInstalacion()
    {
        return $this->turnoOperarioDeInstalacion;
    }

    public function setTurnoOperarioDeInstalacion($turnoOperarioDeInstalacion)
    {
        $this->turnoOperarioDeInstalacion = $turnoOperarioDeInstalacion;
    }

    public function getInstalacionAsignada()
    {
        return $this->instalacionAsignada;
    }

    public function setInstalacionAsignada($instalacionAsignada)
    {
        $this->instalacionAsignada = $instalacionAsignada;
    }

    public function getEstadoOperarioDeInstalacion()
    {
        return $this->estadoOperarioDeInstalacion;
    }

    public function setEstadoOperarioDeInstalacion($estadoOperarioDeInstalacion)
    {
        $this->estadoOperarioDeInstalacion = $estadoOperarioDeInstalacion;
    }

    public function getCargoOperarioDeInstalacion()
    {
        return $this->cargoOperarioDeInstalacion;
    }

    public function setCargoOperarioDeInstalacion($cargoOperarioDeInstalacion)
    {
        $this->cargoOperarioDeInstalacion = $cargoOperarioDeInstalacion;
    }
}
?>
