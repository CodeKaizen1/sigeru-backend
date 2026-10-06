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

    public function testRequisitosContraseniaFaltantesConUnaBuena()
    {
        MiniTest::afirmarIgual([], requisitosContraseniaFaltantes('ClaveBuena123'), "cumple los 3 requisitos, no debería faltar nada");
    }

    public function testRequisitosContraseniaFaltantesMuyCorta()
    {
        MiniTest::afirmarIgual(['al menos 8 caracteres'], requisitosContraseniaFaltantes('Abc12'), "le faltan caracteres, el resto cumple");
    }

    public function testRequisitosContraseniaFaltantesSinNumero()
    {
        MiniTest::afirmarIgual(['al menos un número'], requisitosContraseniaFaltantes('SoloLetras'), "tiene 8+ y letras, pero no números");
    }

    public function testRequisitosContraseniaFaltantesSinLetra()
    {
        MiniTest::afirmarIgual(['al menos una letra'], requisitosContraseniaFaltantes('12345678'), "tiene 8+ y números, pero no letras");
    }

    public function testRequisitosContraseniaFaltantesVacia()
    {
        $faltantes = requisitosContraseniaFaltantes('');
        MiniTest::afirmarIgual(['al menos 8 caracteres', 'al menos una letra', 'al menos un número'], $faltantes, "una contraseña vacía no cumple ninguno de los 3");
    }
}
