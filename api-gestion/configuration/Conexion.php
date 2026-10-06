<?php
class Conexion
{
    private $hostConexion;
    private $dbnameConexion;
    private $usuarioConexion;
    private $passwordConexion;

    public function __construct()
    {
        // Credenciales desde .env (ver .env.example), con localhost/root/sin
        // contraseña como respaldo. En Docker, docker-compose.yml pasa las
        // credenciales como variables de entorno reales en vez de un .env
        // montado (ítem 11 de seguridad, 06/10/2026) - getenv() tiene
        // prioridad sobre el .env, que sigue siendo el único camino para XAMPP.
        $env = self::cargarEnv(__DIR__ . "/.env");

        $this->hostConexion = getenv("DB_HOST") ?: ($env["DB_HOST"] ?? "localhost");
        $this->dbnameConexion = getenv("DB_NAME") ?: ($env["DB_NAME"] ?? "SiGeRU");
        $this->usuarioConexion = getenv("DB_USER") ?: ($env["DB_USER"] ?? "root");
        $this->passwordConexion = getenv("DB_PASS") ?: ($env["DB_PASS"] ?? "");
    }

    // Lee un .env simple (CLAVE=valor por línea).
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

    public function conectar()
    {
        try {
            $conexion = new PDO("mysql:host=".$this->hostConexion.";dbname=".$this->dbnameConexion.";charset=utf8", $this->usuarioConexion, $this->passwordConexion);

            $conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            return $conexion;
        } catch(PDOException $e) {
            echo "Error de conexión: ".$e->getMessage();
        }
    }
}
