<?php
require_once __DIR__ . "/../Application/Controller/IntentoLoginFallidoController.php";
require_once __DIR__ . "/../Application/Configuration/Conexion.php";

// Pruebas del rate limiting de login (ítem 11 de seguridad) contra una base
// real (la que apunte el .env de esta carpeta). Usa un email de prueba
// fuera de cualquier dato real y lo limpia antes/después de cada test,
// mismo criterio que InicioDeSesionControllerTest.
class IntentoLoginFallidoControllerTest
{
    private $conexion;
    private $email = 'test.rate.limit@sigeru.local';
    private $otroEmail = 'test.rate.limit.otro@sigeru.local';

    public function antes()
    {
        $this->conexion = (new Conexion())->conectar();
        $this->limpiar();
    }

    public function despues()
    {
        $this->limpiar();
    }

    private function limpiar()
    {
        $this->conexion->prepare("DELETE FROM intentoLoginFallido WHERE emailIntentoLoginFallido IN (?, ?)")->execute([$this->email, $this->otroEmail]);
    }

    public function testContarFallidosRecientesEmpiezaEnCero()
    {
        $controller = new IntentoLoginFallidoController();
        MiniTest::afirmarIgual(0, $controller->contarFallidosRecientes($this->email), "sin intentos previos, el contador arranca en 0");
    }

    public function testRegistrarFallidoIncrementaElContador()
    {
        $controller = new IntentoLoginFallidoController();
        $controller->registrarFallido($this->email);
        $controller->registrarFallido($this->email);
        $controller->registrarFallido($this->email);

        MiniTest::afirmarIgual(3, $controller->contarFallidosRecientes($this->email), "3 intentos registrados deberían contar 3");
    }

    public function testNoCuentaIntentosDeOtroEmail()
    {
        $controller = new IntentoLoginFallidoController();
        $controller->registrarFallido($this->email);
        $controller->registrarFallido($this->otroEmail);

        MiniTest::afirmarIgual(1, $controller->contarFallidosRecientes($this->email), "no debería contar intentos de otro email");
    }

    public function testNoCuentaIntentosFueraDeLaVentana()
    {
        // Simula un intento de hace 1 hora, insertado directo (registrarFallido siempre usa NOW()).
        $this->conexion->prepare(
            "INSERT INTO intentoLoginFallido (emailIntentoLoginFallido, fechaIntentoLoginFallido) VALUES (?, DATE_SUB(NOW(), INTERVAL 1 HOUR))"
        )->execute([$this->email]);

        $controller = new IntentoLoginFallidoController();
        MiniTest::afirmarIgual(0, $controller->contarFallidosRecientes($this->email, 15), "un intento de hace 1 hora no debería contar en una ventana de 15 minutos");
    }

    public function testLimpiarPorEmailReiniciaElContador()
    {
        $controller = new IntentoLoginFallidoController();
        $controller->registrarFallido($this->email);
        $controller->registrarFallido($this->email);
        $controller->limpiarPorEmail($this->email);

        MiniTest::afirmarIgual(0, $controller->contarFallidosRecientes($this->email), "limpiarPorEmail debería dejar el contador en 0");
    }
}
