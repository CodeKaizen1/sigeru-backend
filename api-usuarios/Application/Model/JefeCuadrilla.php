<?php
require_once __DIR__ . "/OperarioDeCuadrilla.php";

// No suma columnas nuevas: el cargo ("jefe") ya vive en operarioDeCuadrilla.
class JefeCuadrilla extends OperarioDeCuadrilla
{
    public function __construct($cedulaUsuario, $nombreUsuario, $apellidoUsuario, $calleUsuario, $numeroPuertaUsuario, $numeroApartamentoUsuario, $emailUsuario, $telefonoUsuario, $fechaNacimientoUsuario, $estadoUsuario, $rolUsuario, $idOperarioDeCuadrilla, $estadoOperarioDeCuadrilla, $cargoOperarioDeCuadrilla, $turnoOperarioDeCuadrilla, $horaInicioOperarioDeCuadrilla, $horaFinOperarioDeCuadrilla, $licenciaDeConducirOperarioDeCuadrilla, $idCuadrilla)
    {
        parent::__construct($cedulaUsuario, $nombreUsuario, $apellidoUsuario, $calleUsuario, $numeroPuertaUsuario, $numeroApartamentoUsuario, $emailUsuario, $telefonoUsuario, $fechaNacimientoUsuario, $estadoUsuario, $rolUsuario, $idOperarioDeCuadrilla, $estadoOperarioDeCuadrilla, $cargoOperarioDeCuadrilla, $turnoOperarioDeCuadrilla, $horaInicioOperarioDeCuadrilla, $horaFinOperarioDeCuadrilla, $licenciaDeConducirOperarioDeCuadrilla, $idCuadrilla);
    }
}
?>
