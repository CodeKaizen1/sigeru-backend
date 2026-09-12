<?php
require_once __DIR__ . "/../Application/Controller/InicioDeSesion.php";
require_once __DIR__ . "/../Application/Model/InicioDeSesion.php";
require_once __DIR__ . "/../Application/Configuration/Conexion.php";

// Pruebas de login/hasheo contra una base real (la que apunte el .env de
// esta carpeta). Cada test crea su propio usuario de prueba (cédula
// 90000xxx, fuera de cualquier rango real) y lo borra al terminar, para
// poder correr esto sin ensuciar la base de quien lo ejecute.
class InicioDeSesionControllerTest
{
    private $conexion;
    private $cedula = '90000001';
    private $email = 'test.inicio.sesion@sigeru.local';

    public function antes()
    {
        $this->conexion = (new Conexion())->conectar();
        $this->limpiar();
        $this->conexion->prepare(
            "INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, emailUsuario, estadoUsuario, rolUsuario) VALUES (?, 'Test', 'Unitario', ?, 'activo', 'administrador')"
        )->execute([$this->cedula, $this->email]);
    }

    public function despues()
    {
        $this->limpiar();
    }

    private function limpiar()
    {
        $this->conexion->prepare("DELETE FROM inicioDeSesion WHERE idUsuarioInicioDeSesion = ?")->execute([$this->cedula]);
        $this->conexion->prepare("DELETE FROM usuario WHERE cedulaUsuario = ?")->execute([$this->cedula]);
    }

    public function testCrearHasheaLaContrasenia()
    {
        $controller = new InicioDeSesionController();
        $inicio = new InicioDeSesion($this->cedula, 'ClaveDePrueba123');
        $controller->crear($inicio);

        $fila = $controller->obtenerPorId($this->cedula);
        MiniTest::afirmar($fila['contraseniaUsuarioInicioDeSesion'] !== 'ClaveDePrueba123', "no debería quedar en texto plano");
        MiniTest::afirmar(password_verify('ClaveDePrueba123', $fila['contraseniaUsuarioInicioDeSesion']), "el hash tiene que verificar contra la contraseña original");
    }

    public function testLoginCorrecto()
    {
        $controller = new InicioDeSesionController();
        $controller->crear(new InicioDeSesion($this->cedula, 'ClaveDePrueba123'));

        $resultado = $controller->login($this->email, 'ClaveDePrueba123');

        MiniTest::afirmarIgual($this->cedula, $resultado['cedulaUsuario'] ?? null, "debería devolver la cédula");
        MiniTest::afirmarIgual('administrador', $resultado['rol'] ?? null, "debería devolver el rol");
    }

    public function testLoginContraseniaIncorrecta()
    {
        $controller = new InicioDeSesionController();
        $controller->crear(new InicioDeSesion($this->cedula, 'ClaveDePrueba123'));

        MiniTest::afirmarIgual(null, $controller->login($this->email, 'otra-clave'), "contraseña incorrecta debería devolver null");
    }

    public function testLoginEmailInexistente()
    {
        $controller = new InicioDeSesionController();
        MiniTest::afirmarIgual(null, $controller->login('no-existe@sigeru.local', 'lo-que-sea'), "email inexistente debería devolver null");
    }

    public function testLoginCuentaInactiva()
    {
        $this->conexion->prepare("UPDATE usuario SET estadoUsuario = 'inactivo' WHERE cedulaUsuario = ?")->execute([$this->cedula]);
        $controller = new InicioDeSesionController();
        $controller->crear(new InicioDeSesion($this->cedula, 'ClaveDePrueba123'));

        $resultado = $controller->login($this->email, 'ClaveDePrueba123');
        MiniTest::afirmarIgual(true, $resultado['inactivo'] ?? null, "cuenta inactiva debería marcar inactivo=true");
    }

    public function testCrearYaHasheadaNoVuelveAHashear()
    {
        $hashOriginal = password_hash('ClaveYaHasheada', PASSWORD_DEFAULT);
        $controller = new InicioDeSesionController();
        $controller->crear(new InicioDeSesion($this->cedula, $hashOriginal), yaHasheada: true);

        $fila = $controller->obtenerPorId($this->cedula);
        MiniTest::afirmarIgual($hashOriginal, $fila['contraseniaUsuarioInicioDeSesion'], "no debería volver a hashear un hash ya hecho");
    }
}
