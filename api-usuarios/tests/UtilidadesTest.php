<?php
require_once __DIR__ . "/../Application/Utilidades.php";

// Pruebas de las funciones puras del router (sin sesión ni base de datos).
class UtilidadesTest
{
    public function testValidarCamposObligatoriosSinFaltantes()
    {
        $faltantes = validarCamposObligatorios(['nombreUsuario' => 'Ana', 'apellidoUsuario' => 'Pérez'], ['nombreUsuario', 'apellidoUsuario']);
        MiniTest::afirmarIgual([], $faltantes, "no debería faltar nada");
    }

    public function testValidarCamposObligatoriosConFaltantes()
    {
        $faltantes = validarCamposObligatorios(['nombreUsuario' => 'Ana'], ['nombreUsuario', 'apellidoUsuario']);
        MiniTest::afirmarIgual(['apellidoUsuario'], $faltantes, "apellidoUsuario no vino");
    }

    public function testValidarCamposObligatoriosCampoVacioCuentaComoFaltante()
    {
        $faltantes = validarCamposObligatorios(['nombreUsuario' => ''], ['nombreUsuario']);
        MiniTest::afirmarIgual(['nombreUsuario'], $faltantes, "un string vacío tiene que contar como faltante");
    }

    public function testSoloCambianCamposPermitidosCuandoSoloCambiaLoPermitido()
    {
        $actual = ['emailUsuario' => 'viejo@x.com', 'telefonoUsuario' => '111', 'rolUsuario' => 'administrador'];
        $entrante = ['emailUsuario' => 'nuevo@x.com', 'telefonoUsuario' => '111', 'rolUsuario' => 'administrador'];
        MiniTest::afirmar(soloCambianCamposPermitidos($actual, $entrante, ['emailUsuario']), "solo cambió el email, que está permitido");
    }

    public function testSoloCambianCamposPermitidosFalseCuandoCambiaOtroCampo()
    {
        $actual = ['emailUsuario' => 'viejo@x.com', 'rolUsuario' => 'administrador'];
        $entrante = ['emailUsuario' => 'viejo@x.com', 'rolUsuario' => 'chofer'];
        MiniTest::afirmar(!soloCambianCamposPermitidos($actual, $entrante, ['emailUsuario']), "rolUsuario cambió y no está permitido");
    }

    public function testExigirRolAdministradorSiEscribeNoBloqueaLecturas()
    {
        // GET/OPTIONS nunca deberían llegar a chequear el rol (ni a hacer exit).
        exigirRolAdministradorSiEscribe('GET');
        exigirRolAdministradorSiEscribe('OPTIONS');
        MiniTest::afirmar(true, "no debería haber terminado el proceso");
    }

    public function testExigirRolAdministradorSiEscribeDejaEscribirAlAdministrador()
    {
        $_SESSION['rolUsuario'] = 'administrador';
        exigirRolAdministradorSiEscribe('POST');
        MiniTest::afirmar(true, "el administrador puede escribir, no debería haber cortado");
        unset($_SESSION['rolUsuario']);
    }
}
