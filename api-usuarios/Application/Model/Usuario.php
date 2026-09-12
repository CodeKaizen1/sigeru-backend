<?php
class Usuario
{
    protected $cedulaUsuario;
    protected $nombreUsuario;
    protected $apellidoUsuario;
    protected $calleUsuario;
    protected $numeroPuertaUsuario;
    protected $numeroApartamentoUsuario;
    protected $emailUsuario;
    protected $telefonoUsuario;
    protected $fechaNacimientoUsuario;
    protected $estadoUsuario;
    protected $rolUsuario;

    public function __construct($cedulaUsuario, $nombreUsuario, $apellidoUsuario, $calleUsuario, $numeroPuertaUsuario, $numeroApartamentoUsuario, $emailUsuario, $telefonoUsuario, $fechaNacimientoUsuario, $estadoUsuario, $rolUsuario)
    {
        $this->cedulaUsuario = $cedulaUsuario;
        $this->nombreUsuario = $nombreUsuario;
        $this->apellidoUsuario = $apellidoUsuario;
        $this->calleUsuario = $calleUsuario;
        $this->numeroPuertaUsuario = $numeroPuertaUsuario;
        $this->numeroApartamentoUsuario = $numeroApartamentoUsuario;
        $this->emailUsuario = $emailUsuario;
        $this->telefonoUsuario = $telefonoUsuario;
        $this->fechaNacimientoUsuario = $fechaNacimientoUsuario;
        $this->estadoUsuario = $estadoUsuario;
        $this->rolUsuario = $rolUsuario;
    }

    public function getCedulaUsuario()
    {
        return $this->cedulaUsuario;
    }

    public function setCedulaUsuario($cedulaUsuario)
    {
        $this->cedulaUsuario = $cedulaUsuario;
    }

    public function getNombreUsuario()
    {
        return $this->nombreUsuario;
    }

    public function setNombreUsuario($nombreUsuario)
    {
        $this->nombreUsuario = $nombreUsuario;
    }

    public function getApellidoUsuario()
    {
        return $this->apellidoUsuario;
    }

    public function setApellidoUsuario($apellidoUsuario)
    {
        $this->apellidoUsuario = $apellidoUsuario;
    }

    public function getCalleUsuario()
    {
        return $this->calleUsuario;
    }
    public function setCalleUsuario($calleUsuario)
    {
        $this->calleUsuario = $calleUsuario;
    }

    public function getNumeroPuertaUsuario()
    {
        return $this->numeroPuertaUsuario;
    }
    public function setNumeroPuertaUsuario($numeroPuertaUsuario)
    {
        $this->numeroPuertaUsuario = $numeroPuertaUsuario;
    }

    public function getNumeroApartamentoUsuario()
    {
        return $this->numeroApartamentoUsuario;
    }
    public function setNumeroApartamentoUsuario($numeroApartamentoUsuario)
    {
        $this->numeroApartamentoUsuario = $numeroApartamentoUsuario;
    }

    public function getEmailUsuario()
    {
        return $this->emailUsuario;
    }

    public function setEmailUsuario($emailUsuario)
    {
        $this->emailUsuario = $emailUsuario;
    }

    public function getTelefonoUsuario()
    {
        return $this->telefonoUsuario;
    }

    public function setTelefonoUsuario($telefonoUsuario)
    {
        $this->telefonoUsuario = $telefonoUsuario;
    }

    public function getFechaNacimientoUsuario()
    {
        return $this->fechaNacimientoUsuario;
    }

    public function setFechaNacimientoUsuario($fechaNacimientoUsuario)
    {
        $this->fechaNacimientoUsuario = $fechaNacimientoUsuario;
    }

    public function getEstadoUsuario()
    {
        return $this->estadoUsuario;
    }

    public function setEstadoUsuario($estadoUsuario)
    {
        $this->estadoUsuario = $estadoUsuario;
    }

    public function getRolUsuario()
    {
        return $this->rolUsuario;
    }

    public function setRolUsuario($rolUsuario)
    {
        $this->rolUsuario = $rolUsuario;
    }
}
?>
