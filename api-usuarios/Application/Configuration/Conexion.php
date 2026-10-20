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
        //
        // Ítem 11 de seguridad (06/10/2026): cuando esto corre adentro de
        // Docker, docker-compose.yml le pasa las credenciales al contenedor
        // como variables de entorno reales (en vez de montar un .env con la
        // contraseña adentro) - getenv() tiene prioridad sobre el .env de
        // este archivo, que sigue siendo el único camino para XAMPP.
        $env = self::cargarEnv(__DIR__ . "/.env");

        $this->hostConexion = getenv("DB_HOST") ?: ($env["DB_HOST"] ?? "localhost");
        $this->dbnameConexion = getenv("DB_NAME") ?: ($env["DB_NAME"] ?? "SiGeRU");
        $this->usuarioConexion = getenv("DB_USER") ?: ($env["DB_USER"] ?? "root");
        $this->passwordConexion = getenv("DB_PASS") ?: ($env["DB_PASS"] ?? "");
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
        // Ítem crítico de la auditoría de cierre (19/10/2026): antes esto
        // atrapaba la PDOException acá mismo y la imprimía con
        // $e->getMessage() directo al cliente -- eso puede filtrar detalles
        // internos (host, nombre de la base, hasta fragmentos de la
        // contraseña en el mensaje de error de conexión). Ahora se deja
        // que la excepción suba sin atrapar: el catch(Throwable) genérico
        // de cada index.php ya la loguea en el servidor y responde un 500
        // con un mensaje genérico al cliente.
        $conexion = new PDO("mysql:host=".$this->hostConexion.";dbname=".$this->dbnameConexion.";charset=utf8", $this->usuarioConexion, $this->passwordConexion);

        $conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        return $conexion;
    }
}
