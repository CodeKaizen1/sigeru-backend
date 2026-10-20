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

// Ítem crítico #2 de la auditoría de cierre (19/10/2026): exigirRolAdministradorSiEscribe()
// de acá arriba solo restringe ESCRITURAS -- cualquier chofer/jefe de cuadrilla/operario
// autenticado podía hacer GET ?recurso=X sobre CUALQUIER recurso de esta API, incluyendo
// datos que nunca le hacen falta para su panel: administradorMunicipal, operarioDeInstalacion,
// solicitudDeUsuario (solicitudes de alta pendientes, con dirección/teléfono/email de gente
// que ni siquiera es funcionario todavía) e inicioDeSesion (¡el hash de la contraseña de
// TODOS los usuarios!). Se investigó primero qué lecturas sin id necesitan de verdad los
// paneles de Chofer/Jefe/Operario (ver model/funcionarios.js y model/estado.js del
// frontend): ninguno llama nunca a administradorMunicipal, operarioDeInstalacion,
// solicitudDeUsuario ni inicioDeSesion -- se bloquean sin romper nada. "usuario" y
// "operarioDeCuadrilla" sí los necesitan (para pintar "mi cuadrilla"/"mis compañeros"), así
// que ahí no se bloquea el listado completo -- en cambio, ver filtrarListadoUsuariosSiNoAdmin()
// más abajo, que le saca a esa respuesta los campos sensibles de terceros (dirección,
// teléfono, email, fecha de nacimiento) cuando quien pregunta no es administrador.
function exigirPermisoDeLecturaPorRecurso($recurso, $metodo, $id)
{
    if ($metodo !== 'GET') return;
    if (($_SESSION['rolUsuario'] ?? null) === 'administrador') return;

    // Recursos que ningún panel no-administrador lee nunca, ni "lo mío" ni listado completo.
    $recursosSoloAdministrador = ['administradorMunicipal', 'operarioDeInstalacion', 'solicitudDeUsuario', 'inicioDeSesion'];
    if (in_array($recurso, $recursosSoloAdministrador, true)) {
        http_response_code(403);
        echo json_encode(['error' => 'Tu rol no tiene permiso para leer esto.']);
        exit;
    }

    // "usuario" por id de OTRA persona (no la propia, ver "Mi cuenta"): solo administrador.
    // El listado completo (sin id) sigue permitido -- lo necesitan los paneles de rol --
    // pero queda filtrado por filtrarListadoUsuariosSiNoAdmin() antes de devolverse.
    if ($recurso === 'usuario' && $id !== null && (string) $id !== (string) ($_SESSION['cedulaUsuario'] ?? '')) {
        http_response_code(403);
        echo json_encode(['error' => 'Tu rol no tiene permiso para leer esto.']);
        exit;
    }
}

// Le saca a un listado de "usuario" los campos sensibles de terceros (dirección, teléfono,
// email, fecha de nacimiento) cuando quien pregunta no es administrador -- se deja intacta
// su propia fila. Los paneles de Chofer/Jefe/Operario (panel-*.js) solo necesitan
// nombre/apellido/rol/estado de sus compañeros para mostrar "mi cuadrilla", nunca esos
// datos personales de terceros.
function filtrarListadoUsuariosSiNoAdmin($filas)
{
    if (($_SESSION['rolUsuario'] ?? null) === 'administrador') return $filas;

    $camposSensibles = ['calleUsuario', 'numeroPuertaUsuario', 'numeroApartamentoUsuario', 'emailUsuario', 'telefonoUsuario', 'fechaNacimientoUsuario'];
    $cedulaPropia = (string) ($_SESSION['cedulaUsuario'] ?? '');

    return array_map(function ($fila) use ($camposSensibles, $cedulaPropia) {
        if ((string) ($fila['cedulaUsuario'] ?? '') === $cedulaPropia) return $fila;
        foreach ($camposSensibles as $campo) {
            unset($fila[$campo]);
        }
        return $fila;
    }, $filas);
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
