<?php
class Conexion
{
    private $hostConexion;
    private $dbnameConexion;
    private $usuarioConexion;
    private $passwordConexion;

    public function __construct()
    {
        // Credenciales desde .env; si no existe, usa valores por defecto de desarrollo local.
        $env = self::cargarEnv(__DIR__ . "/.env");

        $this->hostConexion = $env["DB_HOST"] ?? "localhost";
        $this->dbnameConexion = $env["DB_NAME"] ?? "SiGeRU";
        $this->usuarioConexion = $env["DB_USER"] ?? "root";
        $this->passwordConexion = $env["DB_PASS"] ?? "";
    }

    // Lee un .env simple (una variable por línea, CLAVE=valor; ignora líneas vacías o con #).
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
