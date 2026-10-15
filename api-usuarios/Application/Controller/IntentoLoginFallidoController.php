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

    // Punto 14 de la Fase 2 (auditoría 08/10/2026): cuántos segundos faltan
    // para que el login de ese email se destrabe, para que el 429 pueda
    // mostrar una cuenta regresiva real (mismo patrón que ya usa "Recuperar
    // contraseña", pero con el tiempo REAL que falta en vez de un número fijo).
    // El bloqueo se levanta quando el intento fallido "límite-ésimo" más
    // reciente (el más viejo de los últimos $limite) sale de la ventana de
    // $minutos -- no cuando TODOS los intentos salen de la ventana. Si no hay
    // suficientes intentos para estar bloqueado, devuelve 0.
    public function segundosHastaDesbloqueo($email, $minutos = 15, $limite = 5)
    {
        // $minutos y $limite son constantes propias (nunca vienen del request),
        // así que se inlinean como enteros -- MySQL no acepta un placeholder
        // parametrizado en LIMIT/OFFSET de forma confiable vía PDO. El único
        // valor que viene de afuera ($email) sigue yendo parametrizado.
        $minutos = (int) $minutos;
        $offset = max(0, (int) $limite - 1);

        $sql = "SELECT GREATEST(0, ($minutos * 60) - TIMESTAMPDIFF(SECOND, fechaIntentoLoginFallido, NOW())) AS segundos
                FROM intentoLoginFallido
                WHERE emailIntentoLoginFallido = ?
                AND fechaIntentoLoginFallido >= DATE_SUB(NOW(), INTERVAL $minutos MINUTE)
                ORDER BY fechaIntentoLoginFallido DESC
                LIMIT 1 OFFSET $offset";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$email]);

        $fila = $stmt->fetch(PDO::FETCH_ASSOC);
        return $fila ? (int) $fila['segundos'] : 0;
    }
}
?>
