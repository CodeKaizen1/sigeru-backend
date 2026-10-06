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

// Requisitos mínimos de contraseña (ítem 11 de seguridad, 06/10/2026). El
// frontend ya los pedía con minlength/pattern en los formularios de
// registro, cambio de contraseña y alta de funcionario, pero nada los
// exigía del lado del servidor -- cualquiera podía mandar una contraseña
// de 1 carácter directo a la API con curl/devtools, sin pasar por esos
// formularios. Devuelve la lista de requisitos que NO cumple $password
// (vacía si está todo bien), mismo estilo que validarCamposObligatorios().
function requisitosContraseniaFaltantes($password)
{
    $password = (string) $password;
    $faltantes = [];

    if (strlen($password) < 8) {
        $faltantes[] = 'al menos 8 caracteres';
    }
    if (!preg_match('/[A-Za-z]/', $password)) {
        $faltantes[] = 'al menos una letra';
    }
    if (!preg_match('/[0-9]/', $password)) {
        $faltantes[] = 'al menos un número';
    }

    return $faltantes;
}
