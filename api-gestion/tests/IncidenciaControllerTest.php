<?php
require_once __DIR__ . "/../application/Controller/IncidenciaController.php";
require_once __DIR__ . "/../application/Model/Incidencia.php";
require_once __DIR__ . "/../application/Controller/ContenedorController.php";
require_once __DIR__ . "/../application/Model/Contenedor.php";
require_once __DIR__ . "/../configuration/Conexion.php";

// Reporte de incidencia real, contra la base que apunte el .env de esta carpeta.
class IncidenciaControllerTest
{
    private $conexion;
    private $idContenedor;
    private $idIncidencia;

    public function antes()
    {
        $this->conexion = (new Conexion())->conectar();
        $ubicacion = 'Contenedor de prueba ' . uniqid();
        (new ContenedorController())->crear(new Contenedor(null, $ubicacion, 'operativo', 1100, 'organico'));

        // El controller abre su propia conexión PDO, distinta de la de este
        // test - lastInsertId() es por conexión, así que hay que buscar el
        // id por un dato único en vez de confiar en lastInsertId() acá.
        $stmt = $this->conexion->prepare("SELECT idContenedor FROM contenedor WHERE ubicacionContenedor = ?");
        $stmt->execute([$ubicacion]);
        $this->idContenedor = (int) $stmt->fetchColumn();
    }

    public function despues()
    {
        if ($this->idIncidencia) {
            $this->conexion->prepare("DELETE FROM incidencia WHERE idIncidencia = ?")->execute([$this->idIncidencia]);
        }
        $this->conexion->prepare("DELETE FROM contenedor WHERE idContenedor = ?")->execute([$this->idContenedor]);
    }

    public function testCrearDevuelveElIdNuevo()
    {
        $controller = new IncidenciaController();
        $id = $controller->crear(new Incidencia(null, 'Huele mal', 'abierta', 'vecino@x.com', 'olor', 'Zona test', date('Y-m-d H:i:s'), $this->idContenedor, null));
        $this->idIncidencia = $id;

        MiniTest::afirmar(is_int($id) && $id > 0, "debería devolver un id entero positivo");

        $fila = $controller->obtenerPorId($id);
        MiniTest::afirmarIgual('abierta', $fila['estadoIncidencia'] ?? null, "queda abierta como se mandó");
        MiniTest::afirmarIgual($this->idContenedor, (int) $fila['idContenedor'], "debería quedar asociada al contenedor");
    }
}
