<?php
require_once __DIR__ . "/../Application/Controller/PasswordResetController.php";
require_once __DIR__ . "/../Application/Configuration/Conexion.php";

// Tests reales de PasswordResetController contra la base que apunte el .env de esta
// carpeta. cedulaUsuario es FK a usuario (ON DELETE CASCADE): cada test crea su propio
// usuario de prueba y lo borra en despues(), lo que cascadea y limpia cualquier fila
// de passwordReset asociada.
class PasswordResetControllerTest
{
    private $conexion;
    private $cedula;

    public function antes()
    {
        $this->conexion = (new Conexion())->conectar();
        $this->cedula = 'TP' . substr(uniqid(), -8);
        $this->conexion->prepare(
            "INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, estadoUsuario, rolUsuario) VALUES (?, 'Test', 'Reset', 'activo', 'vecino')"
        )->execute([$this->cedula]);
    }

    public function despues()
    {
        $this->conexion->prepare("DELETE FROM usuario WHERE cedulaUsuario = ?")->execute([$this->cedula]);
    }

    public function testCrearGeneraUnTokenValidoPorUnaHora()
    {
        $controller = new PasswordResetController();
        $token = $controller->crear($this->cedula);

        MiniTest::afirmar(strlen($token) === 64, "el token debería ser hexadecimal de 64 caracteres (32 bytes random)");

        $fila = $controller->buscarPorToken($token);
        MiniTest::afirmarIgual($this->cedula, $fila['cedulaUsuario'] ?? null, "el token debería quedar asociado a la cédula correcta");

        $minutosHastaExpirar = (strtotime($fila['expiraPasswordReset']) - time()) / 60;
        MiniTest::afirmar($minutosHastaExpirar > 55 && $minutosHastaExpirar <= 60, "debería expirar en aproximadamente 1 hora (vino en $minutosHastaExpirar minutos)");
    }

    public function testCrearDeNuevoBorraElTokenAnterior()
    {
        $controller = new PasswordResetController();
        $tokenViejo = $controller->crear($this->cedula);
        $tokenNuevo = $controller->crear($this->cedula);

        MiniTest::afirmar($tokenViejo !== $tokenNuevo, "cada llamada debería generar un token distinto");
        MiniTest::afirmarIgual(false, $controller->buscarPorToken($tokenViejo), "el token anterior no debería seguir siendo válido");
        MiniTest::afirmar($controller->buscarPorToken($tokenNuevo) !== false, "el token nuevo sí debería encontrarse");
    }

    public function testBuscarPorTokenInexistenteNoEncuentraNada()
    {
        $controller = new PasswordResetController();
        MiniTest::afirmarIgual(false, $controller->buscarPorToken('token-que-no-existe'), "un token inexistente no debería encontrar nada");
    }

    public function testEliminarPorCedula()
    {
        $controller = new PasswordResetController();
        $token = $controller->crear($this->cedula);

        $controller->eliminarPorCedula($this->cedula);
        MiniTest::afirmarIgual(false, $controller->buscarPorToken($token), "no debería encontrarlo después de borrarlo por cédula");
    }
}
