<?php
require_once __DIR__ . "/../Application/Controller/TipoResiduoController.php";
require_once __DIR__ . "/../Application/Model/TipoResiduo.php";
require_once __DIR__ . "/../Configuration/Conexion.php";

// CRUD real de tipoResiduo contra la base que apunte el .env de esta carpeta.
class TipoResiduoControllerTest
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
            $this->conexion->prepare("DELETE FROM tipoResiduo WHERE idTipoResiduo = ?")->execute([$this->idCreado]);
        }
    }

    private function buscarIdPorNombre($nombre)
    {
        $stmt = $this->conexion->prepare("SELECT idTipoResiduo FROM tipoResiduo WHERE nombreTipoResiduo = ?");
        $stmt->execute([$nombre]);
        return (int) $stmt->fetchColumn();
    }

    public function testCrearYLeer()
    {
        $nombre = 'Tipo Test ' . uniqid();
        $controller = new TipoResiduoController();
        $controller->crear(new TipoResiduo(null, $nombre, 'Residuo de prueba', true));

        $this->idCreado = $this->buscarIdPorNombre($nombre);
        $fila = $controller->obtenerPorId($this->idCreado);

        MiniTest::afirmarIgual($nombre, $fila['nombreTipoResiduo'] ?? null, "debería guardar el nombre tal cual");
        MiniTest::afirmarIgual(1, (int) $fila['esReciclableTipoResiduo'], "debería guardar que es reciclable");
    }

    public function testModificar()
    {
        $nombre = 'Tipo Mod ' . uniqid();
        $controller = new TipoResiduoController();
        $controller->crear(new TipoResiduo(null, $nombre, 'Descripción original', false));
        $this->idCreado = $this->buscarIdPorNombre($nombre);

        $controller->modificar(new TipoResiduo($this->idCreado, $nombre, 'Descripción nueva', true));
        $fila = $controller->obtenerPorId($this->idCreado);

        MiniTest::afirmarIgual('Descripción nueva', $fila['descripcionTipoResiduo'] ?? null, "la descripción debería haber cambiado");
        MiniTest::afirmarIgual(1, (int) $fila['esReciclableTipoResiduo'], "esReciclable debería haber cambiado a true");
    }

    public function testEliminar()
    {
        $nombre = 'Tipo Borrar ' . uniqid();
        $controller = new TipoResiduoController();
        $controller->crear(new TipoResiduo(null, $nombre, 'A borrar', false));
        $id = $this->buscarIdPorNombre($nombre);

        $controller->eliminar($id);
        MiniTest::afirmarIgual(false, $controller->obtenerPorId($id), "no debería encontrarlo después de borrarlo");
    }
}
