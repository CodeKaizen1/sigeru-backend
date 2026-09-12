<?php
require_once __DIR__ . "/../Application/Controller/RutaController.php";
require_once __DIR__ . "/../Application/Model/Ruta.php";
require_once __DIR__ . "/../Configuration/Conexion.php";

// Confirma que crear() aplica los defaults documentados cuando no se
// mandan estadoRuta/estadoAdminRuta, contra la base que apunte el .env.
class RutaControllerTest
{
    private $conexion;
    private $zona;
    private $idCreado;

    public function antes()
    {
        $this->conexion = (new Conexion())->conectar();
        $this->zona = 'Zona test ' . uniqid();
    }

    public function despues()
    {
        if ($this->idCreado) {
            $this->conexion->prepare("DELETE FROM ruta WHERE idRuta = ?")->execute([$this->idCreado]);
        }
    }

    private function buscarIdPorZona()
    {
        $stmt = $this->conexion->prepare("SELECT idRuta FROM ruta WHERE zonaRuta = ?");
        $stmt->execute([$this->zona]);
        return (int) $stmt->fetchColumn();
    }

    public function testCrearSinEstadosAplicaLosDefaults()
    {
        $controller = new RutaController();
        $controller->crear(new Ruta(null, $this->zona, 'Recorrido de prueba', 'diaria', 'AM'));
        $this->idCreado = $this->buscarIdPorZona();

        $fila = $controller->obtenerPorId($this->idCreado);
        MiniTest::afirmarIgual('sin iniciar', $fila['estadoRuta'], "estadoRuta debería quedar en su default");
        MiniTest::afirmarIgual('activa', $fila['estadoAdminRuta'], "estadoAdminRuta debería quedar en su default");
    }

    public function testCrearConEstadosExplicitosNoLosPisa()
    {
        $controller = new RutaController();
        $controller->crear(new Ruta(null, $this->zona, 'Recorrido de prueba', 'diaria', 'AM', 'en curso', null, null, 'baja'));
        $this->idCreado = $this->buscarIdPorZona();

        $fila = $controller->obtenerPorId($this->idCreado);
        MiniTest::afirmarIgual('en curso', $fila['estadoRuta'], "no debería pisar un estadoRuta explícito");
        MiniTest::afirmarIgual('baja', $fila['estadoAdminRuta'], "no debería pisar un estadoAdminRuta explícito");
    }
}
