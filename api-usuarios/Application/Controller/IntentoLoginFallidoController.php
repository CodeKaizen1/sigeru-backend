<?php
require_once __DIR__ . "/../Configuration/Conexion.php";

// Rate limiting del login (ítem 11 de seguridad, 06/10/2026): registra cada
// intento de login fallido y permite consultar cuántos hubo recientemente
// para un email, para poder bloquear el login un rato sin tener que
// bloquear la cuenta en sí. Usado solo desde el endpoint especial "login"
// de index.php -- no se expone por el router genérico (mismo criterio que
// PasswordResetController, que tampoco pasa por $recursos).
class IntentoLoginFallidoController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    public function registrarFallido($email)
    {
        $sql = "INSERT INTO intentoLoginFallido (emailIntentoLoginFallido) VALUES (?)";
        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$email]);
    }

    // Cuenta los intentos fallidos de ese email en los últimos $minutos minutos.
    public function contarFallidosRecientes($email, $minutos = 15)
    {
        $sql = "SELECT COUNT(*) AS cantidad FROM intentoLoginFallido
                WHERE emailIntentoLoginFallido = ?
                AND fechaIntentoLoginFallido >= DATE_SUB(NOW(), INTERVAL ? MINUTE)";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$email, $minutos]);

        return (int) $stmt->fetch(PDO::FETCH_ASSOC)['cantidad'];
    }

    // Se llama tras un login exitoso (contraseña correcta): ese email ya
    // demostró que la conoce, así que no tiene sentido seguir contando
    // intentos viejos en su contra.
    public function limpiarPorEmail($email)
    {
        $sql = "DELETE FROM intentoLoginFallido WHERE emailIntentoLoginFallido = ?";
        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$email]);
    }
}
?>
