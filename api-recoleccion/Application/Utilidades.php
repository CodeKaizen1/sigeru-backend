<?php
// Funciones compartidas por el router (antes duplicadas igual en las 3 APIs).
// Se sacaron a este archivo aparte para poder probarlas con PHPUnit sin
// tener que ejecutar todo el router (que hace session_start()/exit()).

function exigirSesion()
{
    if (!isset($_SESSION['cedulaUsuario'])) {
        http_response_code(401);
        echo json_encode(['error' => 'Tenés que iniciar sesión para hacer esto.']);
        exit;
    }
}

function exigirRolAdministradorSiEscribe($metodo)
{
    if ($metodo === 'GET' || $metodo === 'OPTIONS') return;

    if (($_SESSION['rolUsuario'] ?? null) !== 'administrador') {
        http_response_code(403);
        echo json_encode(['error' => 'Tu rol no tiene permiso para hacer esto.']);
        exit;
    }
}

// Devuelve los campos obligatorios que faltan o vienen vacíos en $datos.
function validarCamposObligatorios($datos, $obligatorios)
{
    $faltantes = [];
    foreach ($obligatorios as $campo) {
        $valor = $datos[$campo] ?? null;
        if ($valor === null || $valor === '') {
            $faltantes[] = $campo;
        }
    }
    return $faltantes;
}

// Compara la fila actual contra lo entrante: true si solo cambió lo permitido.
function soloCambianCamposPermitidos($actual, $entrante, $camposPermitidos)
{
    foreach ($actual as $campo => $valorActual) {
        if (in_array($campo, $camposPermitidos, true)) {
            continue;
        }
        $valorEntrante = $entrante[$campo] ?? null;
        if ((string) ($valorActual ?? '') !== (string) ($valorEntrante ?? '')) {
            return false;
        }
    }
    return true;
}
