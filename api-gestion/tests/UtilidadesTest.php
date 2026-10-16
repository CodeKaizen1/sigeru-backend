<?php
require_once __DIR__ . "/../Application/Utilidades.php";

// Pruebas de las funciones puras del router (sin sesión ni base de datos).
class UtilidadesTest
{
    public function testValidarCamposObligatoriosSinFaltantes()
    {
        $faltantes = validarCamposObligatorios(['idContenedor' => '5'], ['idContenedor']);
        MiniTest::afirmarIgual([], $faltantes, "no debería faltar nada");
    }

    public function testValidarCamposObligatoriosConFaltantes()
    {
        $faltantes = validarCamposObligatorios([], ['idContenedor']);
        MiniTest::afirmarIgual(['idContenedor'], $faltantes, "idContenedor no vino");
    }

    public function testSoloCambianCamposPermitidosCuandoSoloCambiaLoPermitido()
    {
        $actual = ['estadoIncidencia' => 'abierta', 'descripcionIncidencia' => 'algo'];
        $entrante = ['estadoIncidencia' => 'resuelta', 'descripcionIncidencia' => 'algo'];
        MiniTest::afirmar(soloCambianCamposPermitidos($actual, $entrante, ['estadoIncidencia']), "solo cambió el estado, que está permitido");
    }

    public function testSoloCambianCamposPermitidosFalseCuandoCambiaOtroCampo()
    {
        $actual = ['estadoIncidencia' => 'abierta', 'descripcionIncidencia' => 'algo'];
        $entrante = ['estadoIncidencia' => 'abierta', 'descripcionIncidencia' => 'otra cosa'];
        MiniTest::afirmar(!soloCambianCamposPermitidos($actual, $entrante, ['estadoIncidencia']), "la descripción cambió y no está permitida");
    }
}
