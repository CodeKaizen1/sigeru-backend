<?php
require_once __DIR__ . "/OperarioDeInstalacion.php";

// No suma columnas nuevas: el cargo ya vive en operarioDeInstalacion.
class JefeInstalacion extends OperarioDeInstalacion
{
    public function __construct($cedulaUsuario, $nombreUsuario, $apellidoUsuario, $calleUsuario, $numeroPuertaUsuario, $numeroApartamentoUsuario, $emailUsuario, $telefonoUsuario, $fechaNacimientoUsuario, $estadoUsuario, $rolUsuario, $turnoOperarioDeInstalacion, $instalacionAsignada, $estadoOperarioDeInstalacion, $cargoOperarioDeInstalacion)
    {
        parent::__construct($cedulaUsuario, $nombreUsuario, $apellidoUsuario, $calleUsuario, $numeroPuertaUsuario, $numeroApartamentoUsuario, $emailUsuario, $telefonoUsuario, $fechaNacimientoUsuario, $estadoUsuario, $rolUsuario, $turnoOperarioDeInstalacion, $instalacionAsignada, $estadoOperarioDeInstalacion, $cargoOperarioDeInstalacion);
    }
}
?>
