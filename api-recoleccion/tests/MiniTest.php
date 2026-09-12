<?php
// Arnés de pruebas mínimo, sin dependencias externas (el proyecto no usa
// Composer para el código de producción, así que tampoco lo pide para
// correr los tests). Cada método público que empieza con "test" en una
// clase pasada a MiniTest::correr() se ejecuta como un caso independiente.

class MiniTest
{
    private static int $aserciones = 0;
    private static int $fallos = 0;

    // Registra una aserción booleana; si falla, imprime el mensaje.
    public static function afirmar(bool $condicion, string $mensaje): void
    {
        self::$aserciones++;
        if (!$condicion) {
            self::$fallos++;
            echo "    FALLÓ: $mensaje\n";
        }
    }

    // Compara con === y arma el mensaje de error solo si hace falta.
    public static function afirmarIgual($esperado, $real, string $mensaje): void
    {
        self::afirmar(
            $esperado === $real,
            "$mensaje (esperado " . var_export($esperado, true) . ", vino " . var_export($real, true) . ")"
        );
    }

    // Corre todos los métodos "test*" de cada clase, con antes()/despues() como setup/teardown.
    public static function correr(array $clasesDeTest): int
    {
        foreach ($clasesDeTest as $clase) {
            foreach (get_class_methods($clase) as $metodo) {
                if (!str_starts_with($metodo, 'test')) continue;

                $instancia = new $clase();
                echo "  $clase::$metodo\n";

                if (method_exists($instancia, 'antes')) $instancia->antes();
                try {
                    $instancia->$metodo();
                } catch (\Throwable $e) {
                    self::$fallos++;
                    echo "    EXCEPCIÓN: " . $e->getMessage() . "\n";
                } finally {
                    if (method_exists($instancia, 'despues')) $instancia->despues();
                }
            }
        }

        echo "\n" . self::$aserciones . " aserciones, " . self::$fallos . " fallaron.\n";
        return self::$fallos === 0 ? 0 : 1;
    }
}
