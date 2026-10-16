<?php
require_once __DIR__ . "/../Application/Controller/ResiduoController.php";
require_once __DIR__ . "/../Application/Model/Residuo.php";
require_once __DIR__ . "/../Configuration/Conexion.php";

// CRUD real de residuo contra la base que apunte el .env de esta carpeta. Es una tabla
// simple sin FK, así que se identifica la fila de prueba por un peso único.
class ResiduoControllerTest
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
            $this->conexion->prepare("DELETE FROM residuo WHERE idResiduo = ?")->execute([$this->idCreado]);
        }
    }

    private function buscarIdPorPeso($peso)
    {
        $stmt = $this->conexion->prepare("SELECT idResiduo FROM residuo WHERE pesoResiduo = ?");
        $stmt->execute([$peso]);
        return (int) $stmt->fetchColumn();
    }

    public function testCrearYLeer()
    {
        $peso = round(mt_rand(1000, 999999) / 100, 2);
        $controller = new ResiduoController();
        $controller->crear(new Residuo(null, $peso, '2026-10-06 10:00:00'));

        $this->idCreado = $this->buscarIdPorPeso($peso);
        $fila = $controller->obtenerPorId($this->idCreado);

        MiniTest::afirmarIgual($peso, (float) $fila['pesoResiduo'], "debería guardar el peso tal cual");
    }

    public function testModificar()
    {
        $peso = round(mt_rand(1000, 999999) / 100, 2);
        $controller = new ResiduoController();
        $controller->crear(new Residuo(null, $peso, '2026-10-06 10:00:00'));
        $this->idCreado = $this->buscarIdPorPeso($peso);

        $pesoNuevo = $peso + 50;
        $controller->modificar(new Residuo($this->idCreado, $pesoNuevo, '2026-10-06 12:00:00'));
        $fila = $controller->obtenerPorId($this->idCreado);

        MiniTest::afirmarIgual($pesoNuevo, (float) $fila['pesoResiduo'], "el peso debería haber cambiado");
    }

    public function testEliminar()
    {
        $peso = round(mt_rand(1000, 999999) / 100, 2);
        $controller = new ResiduoController();
        $controller->crear(new Residuo(null, $peso, '2026-10-06 10:00:00'));
        $id = $this->buscarIdPorPeso($peso);

        $controller->eliminar($id);
        MiniTest::afirmarIgual(false, $controller->obtenerPorId($id), "no debería encontrarlo después de borrarlo");
    }
}
