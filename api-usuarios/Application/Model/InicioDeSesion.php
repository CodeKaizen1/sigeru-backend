<?php
class InicioDeSesion
{
    protected $idUsuarioInicioDeSesion;
    protected $contraseniaUsuarioInicioDeSesion;

    public function __construct($idUsuarioInicioDeSesion, $contraseniaUsuarioInicioDeSesion)
    {
        $this->idUsuarioInicioDeSesion = $idUsuarioInicioDeSesion;
        $this->contraseniaUsuarioInicioDeSesion = $contraseniaUsuarioInicioDeSesion;
    }

    public function getIdUsuarioInicioDeSesion()
    {
        return $this->idUsuarioInicioDeSesion;
    }

    public function setIdUsuarioInicioDeSesion($idUsuarioInicioDeSesion)
    {
        $this->idUsuarioInicioDeSesion = $idUsuarioInicioDeSesion;
    }

    public function getContraseniaUsuarioInicioDeSesion()
    {
        return $this->contraseniaUsuarioInicioDeSesion;
    }

    public function setContraseniaUsuarioInicioDeSesion($contraseniaUsuarioInicioDeSesion)
    {
        $this->contraseniaUsuarioInicioDeSesion = $contraseniaUsuarioInicioDeSesion;
    }
}
?>