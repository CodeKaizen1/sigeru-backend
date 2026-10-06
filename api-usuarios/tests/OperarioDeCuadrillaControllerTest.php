<?php
require_once __DIR__ . "/../Application/Controller/OperarioDeCuadrillaController.php";
require_once __DIR__ . "/../Application/Model/OperarioDeCuadrilla.php";
require_once __DIR__ . "/../Application/Configuration/Conexion.php";

// CRUD real de operarioDeCuadrilla + obtenerPorCuadrilla(), contra la base que apunte
// el .env de esta carpeta. cedulaUsuario es FK a usuario (ON DELETE CASCADE): cada test
// crea su propio usuario de prueba y lo borra en despues(), lo que cascadea y limpia
// la fila de operarioDeCuadrilla sin necesidad de borrarla aparte.
class OperarioDeCuadrillaControllerTest
{
    private $conexion;
    private $cedula;

    public function antes()
    {
        $this->conexion = (new Conexion())->conectar();
        $this->cedula = 'TO' . substr(uniqid(), -8);
        $this->conexion->prepare(
            "INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, estadoUsuario, rolUsuario) VALUES (?, 'Test', 'Operario', 'activo', 'operarioDeCuadrilla')"
        )->execute([$this->cedula]);
    }

    public function despues()
    {
        $this->conexion->prepare("DELETE FROM usuario WHERE cedulaUsuario = ?")->execute([$this->cedula]);
    }

    private function buscarIdPorCedula()
    {
        $stmt = $this->conexion->prepare("SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = ?");
        $stmt->execute([$this->cedula]);
        return (int) $stmt->fetchColumn();
    }

    public function testCrearYLeer()
    {
        $controller = new OperarioDeCuadrillaController();
        $controller->crear(new OperarioDeCuadrilla($this->cedula, 'Test', 'Operario', null, null, null, null, null, null, 'activo', 'operarioDeCuadrilla', null, 'activo', 'peon', 'mañana', '06:00:00', '14:00:00', null, null));

        $id = $this->buscarIdPorCedula();
        $fila = $controller->obtenerPorId($id);

        MiniTest::afirmarIgual('peon', $fila['cargoOperarioDeCuadrilla'] ?? null, "debería guardar el cargo tal cual");
        MiniTest::afirmarIgual('mañana', $fila['turnoOperarioDeCuadrilla'] ?? null, "debería guardar el turno tal cual");
        MiniTest::afirmarIgual(null, $fila['idCuadrilla'], "sin cuadrilla asignada, idCuadrilla debería quedar null");
    }

    public function testObtenerPorCuadrillaNoEncuentraSinAsignar()
    {
        $controller = new OperarioDeCuadrillaController();
        $controller->crear(new OperarioDeCuadrilla($this->cedula, 'Test', 'Operario', null, null, null, null, null, null, 'activo', 'operarioDeCuadrilla', null, 'activo', 'chofer', 'tarde', '14:00:00', '22:00:00', 'B', null));

        $resultado = $controller->obtenerPorCuadrilla(999999);
        MiniTest::afirmarIgual([], $resultado, "una cuadrilla inexistente no debería devolver operarios");
    }

    public function testModificar()
    {
        $controller = new OperarioDeCuadrillaController();
        $controller->crear(new OperarioDeCuadrilla($this->cedula, 'Test', 'Operario', null, null, null, null, null, null, 'activo', 'operarioDeCuadrilla', null, 'activo', 'peon', 'mañana', '06:00:00', '14:00:00', null, null));
        $id = $this->buscarIdPorCedula();

        $controller->modificar(new OperarioDeCuadrilla($this->cedula, 'Test', 'Operario', null, null, null, null, null, null, 'activo', 'operarioDeCuadrilla', $id, 'inactivo', 'jefe', 'noche', '22:00:00', '06:00:00', null, null));
        $fila = $controller->obtenerPorId($id);

        MiniTest::afirmarIgual('jefe', $fila['cargoOperarioDeCuadrilla'] ?? null, "el cargo debería haber cambiado");
        MiniTest::afirmarIgual('inactivo', $fila['estadoOperarioDeCuadrilla'] ?? null, "el estado debería haber cambiado");
    }

    public function testEliminar()
    {
        $controller = new OperarioDeCuadrillaController();
        $controller->crear(new OperarioDeCuadrilla($this->cedula, 'Test', 'Operario', null, null, null, null, null, null, 'activo', 'operarioDeCuadrilla', null, 'activo', 'peon', 'mañana', '06:00:00', '14:00:00', null, null));
        $id = $this->buscarIdPorCedula();

        $controller->eliminar($id);
        MiniTest::afirmarIgual(false, $controller->obtenerPorId($id), "no debería encontrarlo después de borrarlo");
    }
}
