<?php
// Model para la tabla passwordReset.
class PasswordReset
{
    private $idPasswordReset;
    private $cedulaUsuario;
    private $tokenPasswordReset;
    private $expiraPasswordReset;

    public function __construct($idPasswordReset, $cedulaUsuario, $tokenPasswordReset, $expiraPasswordReset)
    {
        $this->idPasswordReset = $idPasswordReset;
        $this->cedulaUsuario = $cedulaUsuario;
        $this->tokenPasswordReset = $tokenPasswordReset;
        $this->expiraPasswordReset = $expiraPasswordReset;
    }

    public function getIdPasswordReset()
    {
        return $this->idPasswordReset;
    }

    public function setIdPasswordReset($idPasswordReset)
    {
        $this->idPasswordReset = $idPasswordReset;
    }

    public function getCedulaUsuario()
    {
        return $this->cedulaUsuario;
    }

    public function setCedulaUsuario($cedulaUsuario)
    {
        $this->cedulaUsuario = $cedulaUsuario;
    }

    public function getTokenPasswordReset()
    {
        return $this->tokenPasswordReset;
    }

    public function setTokenPasswordReset($tokenPasswordReset)
    {
        $this->tokenPasswordReset = $tokenPasswordReset;
    }

    public function getExpiraPasswordReset()
    {
        return $this->expiraPasswordReset;
    }

    public function setExpiraPasswordReset($expiraPasswordReset)
    {
        $this->expiraPasswordReset = $expiraPasswordReset;
    }
}
?>
