<?php
require_once __DIR__ . "/../Application/Controller/UsuarioController.php";
require_once __DIR__ . "/../Application/Model/Usuario.php";
require_once __DIR__ . "/../Application/Configuration/Conexion.php";

// CRUD real de usuario + obtenerPorEmail(), contra la base que apunte el .env de esta carpeta.
class UsuarioControllerTest
{
    private $conexion;
    private $cedula;
    private $email;

    public function antes()
    {
        $this->conexion = (new Conexion())->conectar();
        $this->cedula = 'TU' . substr(uniqid(), -8);
        $this->email = 'test.usuario.' . uniqid() . '@sigeru.local';
    }

    public function despues()
    {
        $this->conexion->prepare("DELETE FROM usuario WHERE cedulaUsuario = ?")->execute([$this->cedula]);
    }

    public function testCrearYLeer()
    {
        $controller = new UsuarioController();
        $controller->crear(new Usuario($this->cedula, 'Test', 'Unitario', 'Calle Falsa', '123', null, $this->email, '099123456', '1990-01-01', 'activo', 'vecino'));

        $fila = $controller->obtenerPorId($this->cedula);

        MiniTest::afirmarIgual('Test', $fila['nombreUsuario'] ?? null, "debería guardar el nombre tal cual");
        MiniTest::afirmarIgual($this->email, $fila['emailUsuario'] ?? null, "debería guardar el email tal cual");
        MiniTest::afirmarIgual('activo', $fila['estadoUsuario'] ?? null, "debería guardar el estado tal cual");
    }

    public function testModificar()
    {
        $controller = new UsuarioController();
        $controller->crear(new Usuario($this->cedula, 'Test', 'Unitario', 'Calle Falsa', '123', null, $this->email, '099123456', '1990-01-01', 'activo', 'vecino'));

        $controller->modificar(new Usuario($this->cedula, 'Test', 'Modificado', 'Calle Falsa', '123', null, $this->email, '099999999', '1990-01-01', 'inactivo', 'vecino'));
        $fila = $controller->obtenerPorId($this->cedula);

        MiniTest::afirmarIgual('Modificado', $fila['apellidoUsuario'] ?? null, "el apellido debería haber cambiado");
        MiniTest::afirmarIgual('inactivo', $fila['estadoUsuario'] ?? null, "el estado debería haber cambiado");
    }

    public function testObtenerPorEmailEncuentraElUsuario()
    {
        $controller = new UsuarioController();
        $controller->crear(new Usuario($this->cedula, 'Test', 'Unitario', 'Calle Falsa', '123', null, $this->email, '099123456', '1990-01-01', 'activo', 'vecino'));

        $fila = $controller->obtenerPorEmail($this->email);
        MiniTest::afirmarIgual($this->cedula, $fila['cedulaUsuario'] ?? null, "debería encontrar el usuario por su email");
    }

    public function testEliminar()
    {
        $controller = new UsuarioController();
        $controller->crear(new Usuario($this->cedula, 'Test', 'Unitario', 'Calle Falsa', '123', null, $this->email, '099123456', '1990-01-01', 'activo', 'vecino'));

        $controller->eliminar($this->cedula);
        MiniTest::afirmarIgual(false, $controller->obtenerPorId($this->cedula), "no debería encontrarlo después de borrarlo");
    }
}
