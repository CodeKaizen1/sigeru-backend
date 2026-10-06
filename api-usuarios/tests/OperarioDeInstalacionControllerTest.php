<?php
require_once __DIR__ . "/../Application/Controller/OperarioDeInstalacionController.php";
require_once __DIR__ . "/../Application/Model/OperarioDeInstalacion.php";
require_once __DIR__ . "/../Application/Configuration/Conexion.php";

// CRUD real de operarioDeInstalacion contra la base que apunte el .env de esta carpeta.
// La tabla usa cedulaUsuario como PK propia (no un id autoincremental aparte) y es FK
// a usuario (ON DELETE CASCADE) -- cada test crea su propio usuario de prueba y lo
// borra en despues(), lo que cascadea y limpia la fila de operarioDeInstalacion.
// instalacionAsignada se deja en null para no depender de que exista una instalación.
class OperarioDeInstalacionControllerTest
{
    private $conexion;
    private $cedula;

    public function antes()
    {
        $this->conexion = (new Conexion())->conectar();
        $this->cedula = 'TI' . substr(uniqid(), -8);
        $this->conexion->prepare(
            "INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, estadoUsuario, rolUsuario) VALUES (?, 'Test', 'Instalacion', 'activo', 'operarioDeInstalacion')"
        )->execute([$this->cedula]);
    }

    public function despues()
    {
        $this->conexion->prepare("DELETE FROM usuario WHERE cedulaUsuario = ?")->execute([$this->cedula]);
    }

    public function testCrearYLeer()
    {
        $controller = new OperarioDeInstalacionController();
        $controller->crear(new OperarioDeInstalacion($this->cedula, 'Test', 'Instalacion', null, null, null, null, null, null, 'activo', 'operarioDeInstalacion', 'mañana', null, 'activo', 'operario'));

        $fila = $controller->obtenerPorId($this->cedula);

        MiniTest::afirmarIgual('mañana', $fila['turnoOperarioDeInstalacion'] ?? null, "debería guardar el turno tal cual");
        MiniTest::afirmarIgual('operario', $fila['cargoOperarioDeInstalacion'] ?? null, "debería guardar el cargo tal cual");
        MiniTest::afirmarIgual(null, $fila['instalacionAsignada'], "sin instalación asignada, debería quedar null");
    }

    public function testModificar()
    {
        $controller = new OperarioDeInstalacionController();
        $controller->crear(new OperarioDeInstalacion($this->cedula, 'Test', 'Instalacion', null, null, null, null, null, null, 'activo', 'operarioDeInstalacion', 'mañana', null, 'activo', 'operario'));

        $controller->modificar(new OperarioDeInstalacion($this->cedula, 'Test', 'Instalacion', null, null, null, null, null, null, 'activo', 'operarioDeInstalacion', 'noche', null, 'inactivo', 'jefe'));
        $fila = $controller->obtenerPorId($this->cedula);

        MiniTest::afirmarIgual('noche', $fila['turnoOperarioDeInstalacion'] ?? null, "el turno debería haber cambiado");
        MiniTest::afirmarIgual('jefe', $fila['cargoOperarioDeInstalacion'] ?? null, "el cargo debería haber cambiado");
    }

    public function testEliminar()
    {
        $controller = new OperarioDeInstalacionController();
        $controller->crear(new OperarioDeInstalacion($this->cedula, 'Test', 'Instalacion', null, null, null, null, null, null, 'activo', 'operarioDeInstalacion', 'mañana', null, 'activo', 'operario'));

        $controller->eliminar($this->cedula);
        MiniTest::afirmarIgual(false, $controller->obtenerPorId($this->cedula), "no debería encontrarlo después de borrarlo");
    }
}
