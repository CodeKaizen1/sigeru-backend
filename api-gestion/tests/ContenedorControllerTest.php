<?php
require_once __DIR__ . "/../application/Controller/ContenedorController.php";
require_once __DIR__ . "/../application/Model/Contenedor.php";
require_once __DIR__ . "/../configuration/Conexion.php";

// CRUD real de contenedor contra la base que apunte el .env de esta carpeta.
class ContenedorControllerTest
{
    private $conexion;
    private $idCreado;

    public function antes()
    {
        $this->conexion = (new Conexion())->conectar();
    }

    public function despues()
    {
        if ($this->idCreado) {
            $this->conexion->prepare("DELETE FROM contenedor WHERE idContenedor = ?")->execute([$this->idCreado]);
        }
    }

    // Busca por la ubicación (única en este test) en vez de lastInsertId():
    // ese id es por conexión PDO, y el controller abre la suya propia,
    // distinta de la de este test.
    private function buscarIdPorUbicacion($ubicacion)
    {
        $stmt = $this->conexion->prepare("SELECT idContenedor FROM contenedor WHERE ubicacionContenedor = ?");
        $stmt->execute([$ubicacion]);
        return (int) $stmt->fetchColumn();
    }

    public function testCrearYLeer()
    {
        $ubicacion = 'Test Unitario ' . uniqid();
        $controller = new ContenedorController();
        $controller->crear(new Contenedor(null, $ubicacion, 'operativo', 1100, 'organico'));

        $this->idCreado = $this->buscarIdPorUbicacion($ubicacion);
        $fila = $controller->obtenerPorId($this->idCreado);

        MiniTest::afirmarIgual($ubicacion, $fila['ubicacionContenedor'] ?? null, "debería guardar la ubicación tal cual");
        MiniTest::afirmarIgual(1100.0, (float) $fila['capacidadContenedor'], "la capacidad debería quedar como se mandó (columna DECIMAL, MySQL la devuelve con decimales)");
    }

    public function testEliminar()
    {
        $ubicacion = 'Para borrar ' . uniqid();
        $controller = new ContenedorController();
        $controller->crear(new Contenedor(null, $ubicacion, 'operativo', 500, 'reciclable'));
        $id = $this->buscarIdPorUbicacion($ubicacion);

        MiniTest::afirmar($id > 0, "tiene que haber encontrado el contenedor recién creado");
        $controller->eliminar($id);
        MiniTest::afirmarIgual(false, $controller->obtenerPorId($id), "no debería encontrarlo después de borrarlo");
    }
}
