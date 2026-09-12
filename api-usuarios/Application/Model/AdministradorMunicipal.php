<?php
class AdministradorMunicipal extends Usuario
{
    protected $idAdministradorMunicipal;
    protected $correoInstaladorMunicipal;

    public function __construct($cedulaUsuario, $nombreUsuario, $apellidoUsuario, $calleUsuario, $numeroPuertaUsuario, $numeroApartamentoUsuario, $emailUsuario, $telefonoUsuario, $fechaNacimientoUsuario, $estadoUsuario, $rolUsuario, $idAdministradorMunicipal, $correoInstaladorMunicipal)
    {
        parent::__construct($cedulaUsuario, $nombreUsuario, $apellidoUsuario, $calleUsuario, $numeroPuertaUsuario, $numeroApartamentoUsuario, $emailUsuario, $telefonoUsuario, $fechaNacimientoUsuario, $estadoUsuario, $rolUsuario);

        $this->idAdministradorMunicipal = $idAdministradorMunicipal;
        $this->correoInstaladorMunicipal = $correoInstaladorMunicipal;
    }

    public function getIdAdministradorMunicipal()
    {
        return $this->idAdministradorMunicipal;
    }

    public function setIdAdministradorMunicipal($idAdministradorMunicipal)
    {
        $this->idAdministradorMunicipal = $idAdministradorMunicipal;
    }

    public function getCorreoInstaladorMunicipal()
    {
        return $this->correoInstaladorMunicipal;
    }

    public function setCorreoInstaladorMunicipal($correoInstaladorMunicipal)
    {
        $this->correoInstaladorMunicipal = $correoInstaladorMunicipal;
    }
}
?>
