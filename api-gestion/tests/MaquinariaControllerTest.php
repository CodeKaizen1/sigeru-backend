<?php
require_once __DIR__ . "/../Application/Controller/MaquinariaController.php";
require_once __DIR__ . "/../Application/Model/Maquinaria.php";
require_once __DIR__ . "/../Configuration/Conexion.php";

// CRUD real de maquinaria + obtenerPorInstalacion(), contra la base que apunte el .env
// de esta carpeta. idInstalacion es opcional (nullable), así que los tests no
// necesitan crear una instalación de prueba.
class MaquinariaControllerTest
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
            $this->conexion->prepare("DELETE FROM maquinaria WHERE idMaquinaria = ?")->execute([$this->idCreado]);
        }
    }

    private function buscarIdPorTipo($tipo)
    {
        $stmt = $this->conexion->prepare("SELECT idMaquinaria FROM maquinaria WHERE tipoDeMaquinaria = ?");
        $stmt->execute([$tipo]);
        return (int) $stmt->fetchColumn();
    }

    public function testCrearYLeer()
    {
        $tipo = 'Compactadora Test ' . uniqid();
        $controller = new MaquinariaController();
        $controller->crear(new Maquinaria(null, $tipo, 'operativa', 'disponible', null));

        $this->idCreado = $this->buscarIdPorTipo($tipo);
        $fila = $controller->obtenerPorId($this->idCreado);

        MiniTest::afirmarIgual($tipo, $fila['tipoDeMaquinaria'] ?? null, "debería guardar el tipo tal cual");
        MiniTest::afirmarIgual(null, $fila['idInstalacion'], "sin instalación asignada, debería quedar null");
    }

    public function testObtenerPorInstalacionNoEncuentraSinAsignar()
    {
        $resultado = (new MaquinariaController())->obtenerPorInstalacion(999999);
        MiniTest::afirmarIgual([], $resultado, "una instalación inexistente no debería devolver maquinaria");
    }

    public function testModificar()
    {
        $tipo = 'Compactadora Mod ' . uniqid();
        $controller = new MaquinariaController();
        $controller->crear(new Maquinaria(null, $tipo, 'operativa', 'disponible', null));
        $this->idCreado = $this->buscarIdPorTipo($tipo);

        $controller->modificar(new Maquinaria($this->idCreado, $tipo, 'en reparación', 'no disponible', null));
        $fila = $controller->obtenerPorId($this->idCreado);

        MiniTest::afirmarIgual('en reparación', $fila['estadoMaquinaria'] ?? null, "el estado debería haber cambiado");
        MiniTest::afirmarIgual('no disponible', $fila['disponibilidadMaquinaria'] ?? null, "la disponibilidad debería haber cambiado");
    }

    public function testEliminar()
    {
        $tipo = 'Compactadora Borrar ' . uniqid();
        $controller = new MaquinariaController();
        $controller->crear(new Maquinaria(null, $tipo, 'operativa', 'disponible', null));
        $id = $this->buscarIdPorTipo($tipo);

        $controller->eliminar($id);
        MiniTest::afirmarIgual(false, $controller->obtenerPorId($id), "no debería encontrarla después de borrarla");
    }
}
