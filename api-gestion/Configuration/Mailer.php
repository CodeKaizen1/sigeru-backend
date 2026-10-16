<?php
require_once __DIR__ . "/../vendor/PHPMailer/Exception.php";
require_once __DIR__ . "/../vendor/PHPMailer/PHPMailer.php";
require_once __DIR__ . "/../vendor/PHPMailer/SMTP.php";

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception as PHPMailerException;

// Envía la confirmación OPCIONAL del reporte público de incidencia (pedido
// de Matías, 16/10/2026) -- mismo PHPMailer vendorizado a mano que ya usa
// api-usuarios/Application/Configuration/Mailer.php para "Recuperar
// contraseña" (duplicado a propósito en vez de compartido entre las 2
// APIs, mismo criterio que Conexion.php: son proyectos/carpetas
// independientes y no vale la pena acoplarlos por esto). Las credenciales
// SMTP se leen del .env propio de api-gestion (ver .env.example).
//
// DIFERENCIA DELIBERADA con la de api-usuarios: esa SÍ logea la dirección
// del destinatario en error_log() si el envío falla (tiene sentido ahí,
// es la cuenta real del usuario, ya guardada en la base). Esta NO -- el
// email que llega acá (emailConfirmacion, ver index.php) es justamente el
// que se pidió que NUNCA quede guardado en ningún lado para no acumular
// datos personales sin necesidad real (protección de datos personales);
// lo mínimo es no dejarlo ni siquiera en un log de errores del servidor.
class Mailer
{
    private $host;
    private $puerto;
    private $usuario;
    private $password;
    private $nombreRemitente;

    public function __construct()
    {
        $env = self::cargarEnv(__DIR__ . "/.env");

        $this->host = getenv("SMTP_HOST") ?: ($env["SMTP_HOST"] ?? "smtp.gmail.com");
        $this->puerto = (int) (getenv("SMTP_PORT") ?: ($env["SMTP_PORT"] ?? 587));
        $this->usuario = getenv("SMTP_USER") ?: ($env["SMTP_USER"] ?? "");
        $this->password = getenv("SMTP_PASS") ?: ($env["SMTP_PASS"] ?? "");
        $this->nombreRemitente = getenv("SMTP_FROM_NAME") ?: ($env["SMTP_FROM_NAME"] ?? "SiGeRU");
    }

    private static function cargarEnv($ruta)
    {
        $valores = [];
        if (!file_exists($ruta)) return $valores;

        foreach (file($ruta, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) as $linea) {
            $linea = trim($linea);
            if ($linea === "" || str_starts_with($linea, "#") || !str_contains($linea, "=")) continue;

            [$clave, $valor] = explode("=", $linea, 2);
            $valores[trim($clave)] = trim($valor);
        }

        return $valores;
    }

    public function configurado()
    {
        return $this->usuario !== "" && $this->password !== "";
    }

    // Devuelve true/false, nunca lanza -- un problema de mail no debe
    // impedir que la incidencia haya quedado creada (eso ya pasó antes de
    // llamar a esto, ver index.php). A propósito NO se incluye el email
    // del destinatario en ningún mensaje de error_log (ver comentario de
    // la clase).
    public function enviar($destinatarioEmail, $asunto, $cuerpoHtml)
    {
        if (!$this->configurado()) {
            error_log("Mailer (api-gestion): SMTP_USER/SMTP_PASS no configurados en .env, no se envió el mail de confirmación de incidencia");
            return false;
        }

        $mail = new PHPMailer(true);
        try {
            $mail->isSMTP();
            $mail->Host = $this->host;
            $mail->SMTPAuth = true;
            $mail->Username = $this->usuario;
            $mail->Password = $this->password;
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
            $mail->Port = $this->puerto;
            $mail->CharSet = "UTF-8";

            $mail->setFrom($this->usuario, $this->nombreRemitente);
            $mail->addAddress($destinatarioEmail);

            $mail->isHTML(true);
            $mail->Subject = $asunto;
            $mail->Body = $cuerpoHtml;
            $mail->AltBody = strip_tags($cuerpoHtml);

            $mail->send();
            return true;
        } catch (PHPMailerException $e) {
            error_log("Mailer (api-gestion): fallo al enviar la confirmación de una incidencia (detalle del destinatario omitido a propósito, ver comentario de la clase)");
            return false;
        }
    }
}
?>
