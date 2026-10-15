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

    // Punto 14 de la Fase 2: sin intentos (o por debajo del límite) no hay
    // nada que desbloquear, el tiempo restante es 0.
    public function testSegundosHastaDesbloqueoEsCeroSinIntentosSuficientes()
    {
        $controller = new IntentoLoginFallidoController();
        $controller->registrarFallido($this->email);
        $controller->registrarFallido($this->email);

        MiniTest::afirmarIgual(0, $controller->segundosHastaDesbloqueo($this->email, 15, 5), "con menos intentos que el límite no debería haber espera");
    }

    // Con exactamente el límite de intentos, todos recién registrados (hace
    // ~0 segundos), el tiempo restante debería ser prácticamente la ventana
    // completa (15 minutos = 900s) -- se permite un margen chico por el
    // tiempo real que tarda en ejecutarse el test.
    public function testSegundosHastaDesbloqueoCercaDeLaVentanaCompletaConIntentosRecientes()
    {
        $controller = new IntentoLoginFallidoController();
        for ($i = 0; $i < 5; $i++) {
            $controller->registrarFallido($this->email);
        }

        $segundos = $controller->segundosHastaDesbloqueo($this->email, 15, 5);
        MiniTest::afirmar($segundos > 895 && $segundos <= 900, "con 5 intentos recién hechos, debería faltar casi la ventana completa (895-900s), dio $segundos");
    }

    // El tiempo de espera lo marca el intento "límite-ésimo" más reciente (el
    // más viejo de los últimos 5), no el más antiguo de todos -- si hay un
    // intento extra de hace 1 hora (ya fuera de la ventana de 15 minutos) no
    // debería alargar la espera.
    public function testSegundosHastaDesbloqueoIgnoraIntentosFueraDeLaVentana()
    {
        $this->conexion->prepare(
            "INSERT INTO intentoLoginFallido (emailIntentoLoginFallido, fechaIntentoLoginFallido) VALUES (?, DATE_SUB(NOW(), INTERVAL 1 HOUR))"
        )->execute([$this->email]);

        $controller = new IntentoLoginFallidoController();
        for ($i = 0; $i < 5; $i++) {
            $controller->registrarFallido($this->email);
        }

        $segundos = $controller->segundosHastaDesbloqueo($this->email, 15, 5);
        MiniTest::afirmar($segundos > 895 && $segundos <= 900, "el intento de hace 1 hora no debería contar para la espera, dio $segundos");
    }
}
