<?php
// Captcha real del formulario público de incidencia (pedido de Matías,
// 16/10/2026) -- antes el checkbox "No soy un robot" era 100% decorativo
// del lado del cliente (ver landing/js/app.js), sin ninguna verificación
// real. Esta clase valida el token de Cloudflare Turnstile contra su
// endpoint "siteverify" -- lo que mande el cliente nunca alcanza solo,
// mismo criterio que ya se usa para tipoIncidencia/zonaIncidencia en
// index.php (nunca confiar en el body de un POST público sin sesión).
class VerificadorCaptcha
{
    private $secretKey;

    public function __construct()
    {
        $env = self::cargarEnv(__DIR__ . "/.env");
        $this->secretKey = getenv("TURNSTILE_SECRET_KEY") ?: ($env["TURNSTILE_SECRET_KEY"] ?? "");
    }

    // Mismo parser simple que Conexion.php/Mailer.php (CLAVE=valor por línea).
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

    // Sin TURNSTILE_SECRET_KEY en el .env no hay forma de verificar nada
    // contra Cloudflare todavía (falta que Matías se registre y la
    // complete) -- el llamador decide qué hacer en ese caso (ver
    // verificar() más abajo: por ahora se deja pasar, para no romper el
    // formulario público mientras no esté configurado).
    public function configurado()
    {
        return $this->secretKey !== "";
    }

    // Devuelve true si el token es válido, false si no lo es o si no se
    // pudo verificar. $token es lo que mandó el cliente (turnstileToken en
    // el body); $ipRemota es opcional (Cloudflare la usa para su propio
    // análisis de riesgo, pero no es obligatoria).
    //
    // Si TURNSTILE_SECRET_KEY no está configurado todavía: deja pasar (log
    // de aviso), igual que Mailer::enviar() hace con SMTP_USER/SMTP_PASS --
    // así el formulario público sigue funcionando mientras se termina de
    // dar de alta en Cloudflare. Si SÍ está configurado pero la
    // verificación falla (token inválido, vencido, reusado, o la llamada a
    // Cloudflare no responde): rechaza. A diferencia del caso "sin
    // configurar", acá SÍ hay una protección activa, así que una falla de
    // red no debe abrir la puerta en silencio.
    public function verificar($token, $ipRemota = null)
    {
        if (!$this->configurado()) {
            error_log("VerificadorCaptcha: TURNSTILE_SECRET_KEY no configurado en .env, se deja pasar el reporte sin verificar captcha");
            return true;
        }

        if ($token === null || $token === '') {
            return false;
        }

        $campos = [
            'secret' => $this->secretKey,
            'response' => $token,
        ];
        if ($ipRemota !== null && $ipRemota !== '') {
            $campos['remoteip'] = $ipRemota;
        }

        $ch = curl_init('https://challenges.cloudflare.com/turnstile/v0/siteverify');
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($campos));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, 5);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);

        $respuestaCruda = curl_exec($ch);
        $errorCurl = curl_error($ch);
        curl_close($ch);

        if ($respuestaCruda === false) {
            error_log("VerificadorCaptcha: no se pudo contactar a Cloudflare (siteverify): {$errorCurl}");
            return false;
        }

        $respuesta = json_decode($respuestaCruda, true);
        if (!is_array($respuesta)) {
            error_log("VerificadorCaptcha: respuesta inesperada de Cloudflare (siteverify): {$respuestaCruda}");
            return false;
        }

        return (bool) ($respuesta['success'] ?? false);
    }
}
?>
