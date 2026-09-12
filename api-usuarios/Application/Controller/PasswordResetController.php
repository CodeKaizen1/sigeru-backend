<?php
require_once __DIR__ . "/../Configuration/Conexion.php";
require_once __DIR__ . "/../Model/PasswordReset.php";

// Usado desde los endpoints especiales recuperarPassword/restablecerPassword de index.php.
class PasswordResetController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    // Genera un token random de un solo uso, válido por 1 hora, y borra el anterior de ese usuario.
    public function crear($cedulaUsuario)
    {
        $this->eliminarPorCedula($cedulaUsuario);

        $token = bin2hex(random_bytes(32));
        $expira = date('Y-m-d H:i:s', strtotime('+1 hour'));

        $sql = "INSERT INTO passwordReset (cedulaUsuario, tokenPasswordReset, expiraPasswordReset) VALUES (?, ?, ?)";
        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$cedulaUsuario, $token, $expira]);

        return $token;
    }

    public function buscarPorToken($token)
    {
        $sql = "SELECT * FROM passwordReset WHERE tokenPasswordReset = ?";
        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$token]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function eliminar($idPasswordReset)
    {
        $sql = "DELETE FROM passwordReset WHERE idPasswordReset = ?";
        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$idPasswordReset]);
    }

    public function eliminarPorCedula($cedulaUsuario)
    {
        $sql = "DELETE FROM passwordReset WHERE cedulaUsuario = ?";
        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$cedulaUsuario]);
    }
}
?>
