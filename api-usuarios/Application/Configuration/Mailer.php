<?php
require_once __DIR__ . "/../../vendor/PHPMailer/Exception.php";
require_once __DIR__ . "/../../vendor/PHPMailer/PHPMailer.php";
require_once __DIR__ . "/../../vendor/PHPMailer/SMTP.php";

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception as PHPMailerException;

// Envía mails reales (hoy solo se usa para recuperación de contraseña) por
// SMTP de Gmail, usando PHPMailer vendorizado a mano en
// api-usuarios/vendor/PHPMailer (el proyecto no usa Composer - mismo
// criterio que Leaflet en sigeru-frontend: self-hosted, sin paquete
// externo en runtime). Las credenciales se leen del mismo .env que ya usa
// Conexion.php para la base (ver .env.example para la plantilla) - nunca
// quedan escritas en el código.
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

        $this->host = $env["SMTP_HOST"] ?? "smtp.gmail.com";
        $this->puerto = isset($env["SMTP_PORT"]) ? (int) $env["SMTP_PORT"] : 587;
        $this->usuario = $env["SMTP_USER"] ?? "";
        $this->password = $env["SMTP_PASS"] ?? "";
        $this->nombreRemitente = $env["SMTP_FROM_NAME"] ?? "SiGeRU";
    }

    // Mismo parser simple que Conexion.php (una variable por línea,
    // CLAVE=valor). Duplicado a propósito en vez de compartido: son 2
    // archivos de configuración independientes y no vale la pena acoplarlos
    // por 10 líneas de parsing.
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

    // Sin usuario/contraseña SMTP cargados en el .env no hay forma de
    // autenticarse contra Gmail -- el llamador puede chequear esto antes de
    // intentar mandar nada, o confiar en que enviar() devuelva false.
    public function configurado()
    {
        return $this->usuario !== "" && $this->password !== "";
    }

    // URL base del frontend-usuarios, para armar links dentro del cuerpo de
    // los mails (hoy solo el de reseteo de contraseña). Mismo .env;
    // default pensado para una instalación XAMPP típica de este proyecto
    // (frontend-usuarios como hermano directo de api-usuarios en htdocs).
    public function urlFrontendUsuarios()
    {
        $env = self::cargarEnv(__DIR__ . "/.env");
        return rtrim($env["FRONTEND_USUARIOS_URL"] ?? "http://localhost/frontend-usuarios", "/");
    }

    // Devuelve true si el servidor SMTP aceptó el mail, false si no (sin
    // configurar, o Gmail lo rechazó). Nunca lanza -- un problema de mail
    // no debe tirar abajo el endpoint que lo llama; el detalle del error
    // queda en error_log(), nunca en la respuesta al cliente.
    public function enviar($destinatarioEmail, $asunto, $cuerpoHtml)
    {
        if (!$this->configurado()) {
            error_log("Mailer: SMTP_USER/SMTP_PASS no configurados en .env, no se envió el mail a {$destinatarioEmail}");
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
            error_log("Mailer: fallo al enviar a {$destinatarioEmail}: " . $mail->ErrorInfo);
            return false;
        }
    }
}
?>
