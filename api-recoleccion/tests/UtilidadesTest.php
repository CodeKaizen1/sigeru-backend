<?php
require_once __DIR__ . "/../Application/Utilidades.php";

// Pruebas de las funciones puras del router (sin sesión ni base de datos).
class UtilidadesTest
{
    public function testValidarCamposObligatoriosSinFaltantes()
    {
        $faltantes = validarCamposObligatorios(['idCuadrilla' => '3'], ['idCuadrilla']);
        MiniTest::afirmarIgual([], $faltantes, "no debería faltar nada");
    }

    public function testValidarCamposObligatoriosConFaltantes()
    {
        $faltantes = validarCamposObligatorios([], ['idCuadrilla']);
        MiniTest::afirmarIgual(['idCuadrilla'], $faltantes, "idCuadrilla no vino");
    }

    public function testSoloCambianCamposPermitidosCuandoSoloCambiaLoPermitido()
    {
        $actual = ['estadoRuta' => 'sin iniciar', 'zonaRuta' => 'Centro'];
        $entrante = ['estadoRuta' => 'en curso', 'zonaRuta' => 'Centro'];
        MiniTest::afirmar(soloCambianCamposPermitidos($actual, $entrante, ['estadoRuta']), "solo cambió el estado de ruta, que está permitido");
    }

    public function testSoloCambianCamposPermitidosFalseCuandoCambiaOtroCampo()
    {
        $actual = ['estadoRuta' => 'sin iniciar', 'zonaRuta' => 'Centro'];
        $entrante = ['estadoRuta' => 'sin iniciar', 'zonaRuta' => 'Otra zona'];
        MiniTest::afirmar(!soloCambianCamposPermitidos($actual, $entrante, ['estadoRuta']), "la zona cambió y no está permitida");
    }
}
