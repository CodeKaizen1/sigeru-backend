<?php
class Conexion
{
    private $hostConexion;
    private $dbnameConexion;
    private $usuarioConexion;
    private $passwordConexion;

    public function __construct()
    {
        // Ítem 12 de la auditoría: antes estas 4 credenciales estaban
        // escritas directo acá abajo. Ahora se leen de un archivo .env (en
        // esta misma carpeta, fuera del control de versiones - ver
        // .gitignore) para que el código nunca tenga la contraseña real
        // escrita adentro. Si el .env no existe todavía en esta máquina,
        // se usan los mismos valores de siempre como respaldo (localhost /
        // root / sin contraseña), así nadie se queda sin poder levantar el
        // proyecto - ver .env.example para la plantilla.
        $env = self::cargarEnv(__DIR__ . "/.env");

        $this->hostConexion = $env["DB_HOST"] ?? "localhost";
        $this->dbnameConexion = $env["DB_NAME"] ?? "SiGeRU";
        $this->usuarioConexion = $env["DB_USER"] ?? "root";
        $this->passwordConexion = $env["DB_PASS"] ?? "";
    }

    // Lee un .env simple (una variable por línea, CLAVE=valor; líneas
    // vacías o que empiezan con # se ignoran) sin depender de ninguna
    // librería externa - el proyecto no usa Composer.
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
