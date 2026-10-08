<?php
// Router HTTP para api-usuarios. Expone los Controllers por HTTP.
//
// Uso:
//   GET    index.php?recurso=usuario                -> obtenerTodos()
//   GET    index.php?recurso=usuario&id=12345678     -> obtenerPorId(...)
//   POST   index.php?recurso=usuario   (body JSON)   -> crear(...)
//   PUT    index.php?recurso=usuario&id=... (body JSON) -> modificar(...)
//   DELETE index.php?recurso=usuario&id=...          -> eliminar(...)
//
// Recursos: usuario, administradorMunicipal, operarioDeCuadrilla,
// operarioDeInstalacion, inicioDeSesion, solicitudDeUsuario
//
// Endpoints especiales: login, logout, recuperarPassword,
// restablecerPassword, cambiarPassword

session_start();

$origenesPermitidos = ["http://localhost", "http://127.0.0.1"];
$origenSolicitante = $_SERVER['HTTP_ORIGIN'] ?? '';
if (in_array($origenSolicitante, $origenesPermitidos, true)) {
    header("Access-Control-Allow-Origin: $origenSolicitante");
    header('Access-Control-Allow-Credentials: true');
}

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

// exigirSesion(), exigirRolAdministradorSiEscribe(), validarCamposObligatorios()
// y soloCambianCamposPermitidos() viven en Utilidades.php (antes estaban acá
// duplicadas idénticas en las 3 APIs) para poder probarlas con PHPUnit.
require_once __DIR__ . "/Application/Utilidades.php";

// Usuario primero: AdministradorMunicipal, OperarioDeCuadrilla y
// OperarioDeInstalacion heredan de ella.
require_once "Application/Controller/UsuarioController.php";
require_once "Application/Controller/AdministradorMunicipalController.php";
require_once "Application/Controller/OperarioDeCuadrillaController.php";
require_once "Application/Controller/OperarioDeInstalacionController.php";
require_once "Application/Controller/InicioDeSesion.php";
require_once "Application/Controller/SolicitudDeUsuarioController.php";
require_once "Application/Controller/PasswordResetController.php";
require_once "Application/Controller/IntentoLoginFallidoController.php";
require_once "Application/Configuration/Mailer.php";

$recursos = [
    'usuario' => [
        'controller' => 'UsuarioController',
        'modelo' => 'Usuario',
        'campos' => ['cedulaUsuario', 'nombreUsuario', 'apellidoUsuario', 'calleUsuario', 'numeroPuertaUsuario', 'numeroApartamentoUsuario', 'emailUsuario', 'telefonoUsuario', 'fechaNacimientoUsuario', 'estadoUsuario', 'rolUsuario'],
        'obligatoriosCrear' => ['cedulaUsuario', 'nombreUsuario', 'apellidoUsuario'],
        'obligatoriosModificar' => ['cedulaUsuario', 'nombreUsuario', 'apellidoUsuario'],
    ],
    'administradorMunicipal' => [
        'controller' => 'AdministradorMunicipalController',
        'modelo' => 'AdministradorMunicipal',
        'campos' => ['cedulaUsuario', 'nombreUsuario', 'apellidoUsuario', 'calleUsuario', 'numeroPuertaUsuario', 'numeroApartamentoUsuario', 'emailUsuario', 'telefonoUsuario', 'fechaNacimientoUsuario', 'estadoUsuario', 'rolUsuario', 'idAdministradorMunicipal', 'correoInstaladorMunicipal'],
        'obligatoriosCrear' => ['cedulaUsuario'],
        'obligatoriosModificar' => ['idAdministradorMunicipal', 'cedulaUsuario'],
    ],
    'operarioDeCuadrilla' => [
        'controller' => 'OperarioDeCuadrillaController',
        'modelo' => 'OperarioDeCuadrilla',
        'campos' => ['cedulaUsuario', 'nombreUsuario', 'apellidoUsuario', 'calleUsuario', 'numeroPuertaUsuario', 'numeroApartamentoUsuario', 'emailUsuario', 'telefonoUsuario', 'fechaNacimientoUsuario', 'estadoUsuario', 'rolUsuario', 'idOperarioDeCuadrilla', 'estadoOperarioDeCuadrilla', 'cargoOperarioDeCuadrilla', 'turnoOperarioDeCuadrilla', 'horaInicioOperarioDeCuadrilla', 'horaFinOperarioDeCuadrilla', 'licenciaDeConducirOperarioDeCuadrilla', 'idCuadrilla'],
        'obligatoriosCrear' => ['cedulaUsuario'],
        'obligatoriosModificar' => ['idOperarioDeCuadrilla', 'cedulaUsuario'],
    ],
    'operarioDeInstalacion' => [
        'controller' => 'OperarioDeInstalacionController',
        'modelo' => 'OperarioDeInstalacion',
        'campos' => ['cedulaUsuario', 'nombreUsuario', 'apellidoUsuario', 'calleUsuario', 'numeroPuertaUsuario', 'numeroApartamentoUsuario', 'emailUsuario', 'telefonoUsuario', 'fechaNacimientoUsuario', 'estadoUsuario', 'rolUsuario', 'turnoOperarioDeInstalacion', 'instalacionAsignada', 'estadoOperarioDeInstalacion', 'cargoOperarioDeInstalacion'],
        'obligatoriosCrear' => ['cedulaUsuario'],
        'obligatoriosModificar' => ['cedulaUsuario'],
    ],
    'inicioDeSesion' => [
        'controller' => 'InicioDeSesionController',
        'modelo' => 'InicioDeSesion',
        'campos' => ['idUsuarioInicioDeSesion', 'contraseniaUsuarioInicioDeSesion'],
        'obligatoriosCrear' => ['idUsuarioInicioDeSesion', 'contraseniaUsuarioInicioDeSesion'],
        'obligatoriosModificar' => ['idUsuarioInicioDeSesion', 'contraseniaUsuarioInicioDeSesion'],
    ],
    'solicitudDeUsuario' => [
        'controller' => 'SolicitudDeUsuarioController',
        'modelo' => 'SolicitudDeUsuario',
        'campos' => ['idSolicitud', 'cedulaUsuario', 'nombreUsuario', 'apellidoUsuario', 'direccionCompletaUsuario', 'emailUsuario', 'telefonoUsuario', 'fechaNacimientoUsuario', 'contraseniaSolicitud', 'rolSolicitado', 'estadoSolicitud', 'fechaSolicitud', 'motivoRechazo', 'fechaRechazo'],
        'obligatoriosCrear' => ['cedulaUsuario', 'nombreUsuario', 'apellidoUsuario', 'contraseniaSolicitud'],
        'obligatoriosModificar' => ['idSolicitud', 'nombreUsuario', 'apellidoUsuario', 'contraseniaSolicitud'],
    ],
];

$recurso = $_GET['recurso'] ?? null;
$id = $_GET['id'] ?? null;
$metodo = $_SERVER['REQUEST_METHOD'];

$datos = null;
if ($metodo === 'POST' || $metodo === 'PUT') {
    $datos = json_decode(file_get_contents('php://input'), true) ?? [];
}

// Login: busca por email y verifica la contraseña con password_verify().
if ($recurso === 'login') {
    if ($metodo !== 'POST') {
        http_response_code(405);
        echo json_encode(['error' => 'El login solo acepta POST']);
        exit;
    }

    $email = trim($datos['email'] ?? '');
    $password = $datos['password'] ?? '';

    if ($email === '' || $password === '') {
        http_response_code(400);
        echo json_encode(['error' => 'Faltan email o password']);
        exit;
    }

    // Rate limiting del login (ítem 11 de seguridad, 06/10/2026): 5 intentos
    // fallidos en los últimos 15 minutos bloquean el login para ESE email (no
    // la IP ni la cuenta en la base) -- se destraba solo con el tiempo, a
    // medida que esos intentos van saliendo de la ventana de 15 minutos. No
    // confirma si el email existe (mismo criterio que recuperarPassword).
    $intentosController = new IntentoLoginFallidoController();
    $limiteIntentosLogin = 5;
    $ventanaMinutosLogin = 15;

    if ($intentosController->contarFallidosRecientes($email, $ventanaMinutosLogin) >= $limiteIntentosLogin) {
        http_response_code(429);
        echo json_encode(['error' => 'Demasiados intentos fallidos para este correo. Esperá unos minutos y volvé a intentar.']);
        exit;
    }

    $controllerLogin = new InicioDeSesionController();
    $resultado = $controllerLogin->login($email, $password);

    if ($resultado === null) {
        $intentosController->registrarFallido($email);
        http_response_code(401);
        echo json_encode(['error' => 'Correo o contraseña incorrectos']);
        exit;
    }

    if (isset($resultado['inactivo'])) {
        // La contraseña era correcta -- no cuenta como intento de fuerza bruta.
        $intentosController->limpiarPorEmail($email);
        http_response_code(403);
        echo json_encode(['error' => 'Tu cuenta todavía no está activa. Consultá con el Administrador.']);
        exit;
    }

    $intentosController->limpiarPorEmail($email);

    $_SESSION['cedulaUsuario'] = $resultado['cedulaUsuario'];
    $_SESSION['rolUsuario'] = $resultado['rol'];

    echo json_encode(['exito' => true, 'usuario' => $resultado]);
    exit;
}

if ($recurso === 'logout') {
    $_SESSION = [];
    session_destroy();
    echo json_encode(['exito' => true]);
    exit;
}

// Genera un token de recuperación y lo manda por mail (punto 9 de la
// auditoría: antes se devolvía el token directo en la respuesta JSON y el
// frontend lo mostraba como link en pantalla -- cualquiera que viera esa
// respuesta podía resetear la contraseña de otro usuario. Ahora el token
// nunca sale de acá: se arma el link de reseteo y se manda por SMTP real
// con Mailer (PHPMailer), la respuesta al cliente es siempre el mismo
// mensaje genérico exista o no el email, y exista o no haya podido
// mandarse el mail -- un fallo de SMTP se loguea con error_log() pero no
// se filtra al cliente, mismo criterio que el punto 10 (mensajes de error
// genéricos).
if ($recurso === 'recuperarPassword') {
    if ($metodo !== 'POST') {
        http_response_code(405);
        echo json_encode(['error' => 'recuperarPassword solo acepta POST']);
        exit;
    }

    $email = trim($datos['email'] ?? '');
    if ($email === '') {
        http_response_code(400);
        echo json_encode(['error' => 'Falta el email']);
        exit;
    }

    $mensajeGenerico = 'Si el email está registrado, en unos minutos vas a recibir un correo con el link para restablecer tu contraseña (revisá también la carpeta de spam).';

    $usuarioController = new UsuarioController();
    $usuarioEncontrado = $usuarioController->obtenerPorEmail($email);

    // No se confirma si el email existe o no.
    if ($usuarioEncontrado === false) {
        echo json_encode(['exito' => true, 'mensaje' => $mensajeGenerico]);
        exit;
    }

    $resetController = new PasswordResetController();
    $token = $resetController->crear($usuarioEncontrado['cedulaUsuario']);

    $mailer = new Mailer();
    $urlFrontend = $mailer->urlFrontendUsuarios();
    $linkReseteo = "{$urlFrontend}/restablecer.html?token=" . urlencode($token);

    $nombreUsuario = htmlspecialchars($usuarioEncontrado['nombreUsuario'] ?? '', ENT_QUOTES, 'UTF-8');
    $cuerpoHtml = "<p>Hola" . ($nombreUsuario !== '' ? " {$nombreUsuario}" : "") . ",</p>"
        . "<p>Recibimos un pedido para restablecer tu contraseña en SiGeRU. Si fuiste vos, hacé click en el siguiente link (válido por 1 hora):</p>"
        . "<p><a href=\"{$linkReseteo}\">{$linkReseteo}</a></p>"
        . "<p>Si no pediste este cambio, podés ignorar este correo -- tu contraseña actual sigue funcionando igual.</p>";

    $enviado = $mailer->enviar($email, 'Restablecer tu contraseña de SiGeRU', $cuerpoHtml);
    if (!$enviado) {
        error_log("recuperarPassword: no se pudo enviar el mail de reseteo a {$email} (ver log de Mailer arriba para el detalle)");
    }

    echo json_encode(['exito' => true, 'mensaje' => $mensajeGenerico]);
    exit;
}

if ($recurso === 'restablecerPassword') {
    if ($metodo !== 'POST') {
        http_response_code(405);
        echo json_encode(['error' => 'restablecerPassword solo acepta POST']);
        exit;
    }

    $token = $datos['token'] ?? '';
    $nuevaPassword = $datos['contraseniaNueva'] ?? '';

    if ($token === '' || $nuevaPassword === '') {
        http_response_code(400);
        echo json_encode(['error' => 'Faltan token o contraseniaNueva']);
        exit;
    }

    // Ítem 11 de seguridad: reglas mínimas de contraseña (el frontend ya las
    // pedía con minlength/pattern, pero nada las exigía del lado del servidor).
    $faltantesPassword = requisitosContraseniaFaltantes($nuevaPassword);
    if (!empty($faltantesPassword)) {
        http_response_code(400);
        echo json_encode(['error' => 'La contraseña debe tener ' . implode(', ', $faltantesPassword) . '.']);
        exit;
    }

    $resetController = new PasswordResetController();
    $fila = $resetController->buscarPorToken($token);

    if ($fila === false || strtotime($fila['expiraPasswordReset']) < time()) {
        http_response_code(400);
        echo json_encode(['error' => 'El link de recuperación no es válido o ya venció. Pedí uno nuevo.']);
        exit;
    }

    $inicioController = new InicioDeSesionController();
    $inicioController->modificar(new InicioDeSesion($fila['cedulaUsuario'], $nuevaPassword));

    // Token de un solo uso.
    $resetController->eliminar($fila['idPasswordReset']);

    echo json_encode(['exito' => true]);
    exit;
}

// El registro público (alta de solicitudDeUsuario) no requiere sesión.
$esRegistroPublico = ($recurso === 'solicitudDeUsuario' && $metodo === 'POST');

// Ítem 11 de seguridad: reglas mínimas de contraseña, también para el
// registro público (el único de los 4 puntos que setean contraseña que no
// pasa por un bloque "if ($recurso === ...)" propio más abajo).
if ($esRegistroPublico) {
    $faltantesPassword = requisitosContraseniaFaltantes($datos['contraseniaSolicitud'] ?? '');
    if (!empty($faltantesPassword)) {
        http_response_code(400);
        echo json_encode(['error' => 'La contraseña debe tener ' . implode(', ', $faltantesPassword) . '.']);
        exit;
    }

    // Punto 5 de la auditoría 08/10/2026: nada impedía que dos cuentas (o una
    // cuenta y una solicitud pendiente) terminaran con el mismo emailUsuario
    // -- ni recuperar contraseña ni las notificaciones por email garantizan
    // entonces a cuál de las dos le llega. Se corta acá, antes de guardar la
    // solicitud, y de nuevo en crearPersonaConRol() al aprobarla (por si en
    // el medio se aprobó otra con ese mismo email).
    $emailDeclarado = $datos['emailUsuario'] ?? null;
    if ($emailDeclarado !== null && $emailDeclarado !== '') {
        $usuarioControllerEmail = new UsuarioController();
        $solicitudControllerEmail = new SolicitudDeUsuarioController();

        if (
            $usuarioControllerEmail->obtenerPorEmail($emailDeclarado) !== false
            || $solicitudControllerEmail->obtenerPendientePorEmail($emailDeclarado) !== false
        ) {
            http_response_code(409);
            echo json_encode(['error' => 'Ya hay una cuenta o una solicitud pendiente con ese email.']);
            exit;
        }
    }
}

if (!$esRegistroPublico) {
    exigirSesion();
}

// Hallazgo reportado por el profesor (08/10/2026): los 4 paneles del
// backoffice decidían "¿hay sesión?" mirando solo una copia en
// sessionStorage (ver auth.js) -- sessionStorage es por pestaña, así que
// pegar la URL de un panel en una pestaña nueva mostraba "Acceso no
// autorizado" aunque la sesión real (cookie PHPSESSID, que sí es
// compartida entre pestañas) siguiera siendo válida. Este endpoint es lo
// que esa copia local debería haber consultado desde el principio: a esta
// altura ya pasó exigirSesion(), así que si llegamos acá hay una sesión
// real.
if ($recurso === 'sesionActual') {
    if ($metodo !== 'GET') {
        http_response_code(405);
        echo json_encode(['error' => 'sesionActual solo acepta GET']);
        exit;
    }

    $usuarioControllerSesion = new UsuarioController();
    $filaSesion = $usuarioControllerSesion->obtenerPorId($_SESSION['cedulaUsuario']);

    if ($filaSesion === false) {
        // La cuenta se borró o desactivó después de que se inició esta sesión.
        $_SESSION = [];
        session_destroy();
        http_response_code(401);
        echo json_encode(['error' => 'Sesión inválida.']);
        exit;
    }

    echo json_encode(['exito' => true, 'usuario' => [
        'cedulaUsuario' => $filaSesion['cedulaUsuario'],
        'nombreUsuario' => $filaSesion['nombreUsuario'],
        'apellidoUsuario' => $filaSesion['apellidoUsuario'],
        'emailUsuario' => $filaSesion['emailUsuario'],
        'rol' => $filaSesion['rolUsuario'],
    ]]);
    exit;
}

if ($recurso === 'cambiarPassword') {
    if ($metodo !== 'POST') {
        http_response_code(405);
        echo json_encode(['error' => 'cambiarPassword solo acepta POST']);
        exit;
    }

    $actual = $datos['contraseniaActual'] ?? '';
    $nueva = $datos['contraseniaNueva'] ?? '';

    if ($actual === '' || $nueva === '') {
        http_response_code(400);
        echo json_encode(['error' => 'Faltan contraseniaActual o contraseniaNueva']);
        exit;
    }

    $cedula = $_SESSION['cedulaUsuario'];
    $inicioController = new InicioDeSesionController();
    $filaActual = $inicioController->obtenerPorId($cedula);

    if ($filaActual === false || !password_verify($actual, $filaActual['contraseniaUsuarioInicioDeSesion'])) {
        http_response_code(403);
        echo json_encode(['error' => 'La contraseña actual no es correcta.']);
        exit;
    }

    // Ítem 11 de seguridad: reglas mínimas de contraseña.
    $faltantesPassword = requisitosContraseniaFaltantes($nueva);
    if (!empty($faltantesPassword)) {
        http_response_code(400);
        echo json_encode(['error' => 'La contraseña debe tener ' . implode(', ', $faltantesPassword) . '.']);
        exit;
    }

    $inicioController->modificar(new InicioDeSesion($cedula, $nueva));

    echo json_encode(['exito' => true]);
    exit;
}

// Traduce el rol de cuenta al "cargo" de operarioDeCuadrilla; null si no aplica.
function cargoOperarioDeCuadrillaSegunRol($rol) {
    return in_array($rol, ['chofer', 'jefeDeCuadrilla', 'operarioDeCuadrilla'], true) ? $rol : null;
}

// Crea usuario + inicioDeSesion + subtipo (administrador u operarioDeCuadrilla)
// para un rol de cuenta; deshace lo insertado si un paso falla.
function crearPersonaConRol($datosUsuario, $rol, $passwordParaInicioDeSesion, $passwordYaHasheada) {
    $usuarioController = new UsuarioController();
    $inicioController = new InicioDeSesionController();

    if ($usuarioController->obtenerPorId($datosUsuario['cedulaUsuario']) !== false) {
        return ['error' => 'Ya existe una persona con esa cédula.'];
    }

    // Punto 5 de la auditoría 08/10/2026: cubre tanto crearFuncionario (alta
    // directa desde el panel) como aprobarSolicitud (por si entre el registro
    // y la aprobación se coló otra cuenta con el mismo email).
    $emailDeclarado = $datosUsuario['emailUsuario'] ?? null;
    if ($emailDeclarado !== null && $emailDeclarado !== '' && $usuarioController->obtenerPorEmail($emailDeclarado) !== false) {
        return ['error' => 'Ya existe una persona con ese email.'];
    }

    $nuevoUsuario = new Usuario(
        $datosUsuario['cedulaUsuario'],
        $datosUsuario['nombreUsuario'],
        $datosUsuario['apellidoUsuario'],
        $datosUsuario['calleUsuario'] ?? null,
        $datosUsuario['numeroPuertaUsuario'] ?? null,
        $datosUsuario['numeroApartamentoUsuario'] ?? null,
        $datosUsuario['emailUsuario'] ?? null,
        $datosUsuario['telefonoUsuario'] ?? null,
        $datosUsuario['fechaNacimientoUsuario'] ?? null,
        'activo',
        $rol
    );

    if (!$usuarioController->crear($nuevoUsuario)) {
        return ['error' => 'No se pudo crear el usuario.'];
    }

    if (!$inicioController->crear(new InicioDeSesion($datosUsuario['cedulaUsuario'], $passwordParaInicioDeSesion), $passwordYaHasheada)) {
        $usuarioController->eliminar($datosUsuario['cedulaUsuario']);
        return ['error' => 'No se pudo crear el inicio de sesión.'];
    }

    if ($rol === 'administrador') {
        $adminController = new AdministradorMunicipalController();
        $ok = $adminController->crear(new AdministradorMunicipal(
            $datosUsuario['cedulaUsuario'], $datosUsuario['nombreUsuario'], $datosUsuario['apellidoUsuario'],
            $datosUsuario['calleUsuario'] ?? null, $datosUsuario['numeroPuertaUsuario'] ?? null, $datosUsuario['numeroApartamentoUsuario'] ?? null,
            $datosUsuario['emailUsuario'] ?? null, $datosUsuario['telefonoUsuario'] ?? null, $datosUsuario['fechaNacimientoUsuario'] ?? null,
            'activo', $rol,
            null, $datosUsuario['emailUsuario'] ?? null
        ));
    } else {
        $cargo = cargoOperarioDeCuadrillaSegunRol($rol);
        $operarioController = new OperarioDeCuadrillaController();
        $ok = $operarioController->crear(new OperarioDeCuadrilla(
            $datosUsuario['cedulaUsuario'], $datosUsuario['nombreUsuario'], $datosUsuario['apellidoUsuario'],
            $datosUsuario['calleUsuario'] ?? null, $datosUsuario['numeroPuertaUsuario'] ?? null, $datosUsuario['numeroApartamentoUsuario'] ?? null,
            $datosUsuario['emailUsuario'] ?? null, $datosUsuario['telefonoUsuario'] ?? null, $datosUsuario['fechaNacimientoUsuario'] ?? null,
            'activo', $rol,
            null, 'activo', $cargo, null, null, null, null, null
        ));
    }

    if (!$ok) {
        $inicioController->eliminar($datosUsuario['cedulaUsuario']);
        $usuarioController->eliminar($datosUsuario['cedulaUsuario']);
        return ['error' => 'No se pudo crear la ficha de ' . ($rol === 'administrador' ? 'administrador' : 'operario') . '.'];
    }

    return ['cedulaUsuario' => $datosUsuario['cedulaUsuario']];
}

// Alta directa de un funcionario desde el panel administrador.
if ($recurso === 'crearFuncionario') {
    if ($metodo !== 'POST') {
        http_response_code(405);
        echo json_encode(['error' => 'crearFuncionario solo acepta POST']);
        exit;
    }

    exigirSesion();
    if (($_SESSION['rolUsuario'] ?? null) !== 'administrador') {
        http_response_code(403);
        echo json_encode(['error' => 'Solo un administrador puede crear funcionarios.']);
        exit;
    }

    $rol = $datos['rolUsuario'] ?? '';
    if (!in_array($rol, ['administrador', 'chofer', 'jefeDeCuadrilla', 'operarioDeCuadrilla'], true)) {
        http_response_code(400);
        echo json_encode(['error' => 'Rol inválido.']);
        exit;
    }

    $faltantes = array_filter(['cedulaUsuario', 'nombreUsuario', 'apellidoUsuario'], fn($c) => empty($datos[$c] ?? null));
    if ($faltantes || empty($datos['contraseniaNueva'] ?? null)) {
        http_response_code(400);
        echo json_encode(['error' => 'Faltan campos obligatorios (cédula, nombre, apellido o contraseña).']);
        exit;
    }

    // Ítem 11 de seguridad: reglas mínimas de contraseña.
    $faltantesPassword = requisitosContraseniaFaltantes($datos['contraseniaNueva']);
    if (!empty($faltantesPassword)) {
        http_response_code(400);
        echo json_encode(['error' => 'La contraseña debe tener ' . implode(', ', $faltantesPassword) . '.']);
        exit;
    }

    $resultado = crearPersonaConRol($datos, $rol, $datos['contraseniaNueva'], false);

    if (isset($resultado['error'])) {
        http_response_code(400);
        echo json_encode($resultado);
        exit;
    }

    echo json_encode(['exito' => true, 'cedulaUsuario' => $resultado['cedulaUsuario']]);
    exit;
}

// Aprueba una solicitud pública: crea la persona con la contraseña ya hasheada.
if ($recurso === 'aprobarSolicitud') {
    if ($metodo !== 'POST') {
        http_response_code(405);
        echo json_encode(['error' => 'aprobarSolicitud solo acepta POST']);
        exit;
    }

    exigirSesion();
    if (($_SESSION['rolUsuario'] ?? null) !== 'administrador') {
        http_response_code(403);
        echo json_encode(['error' => 'Solo un administrador puede aprobar solicitudes.']);
        exit;
    }

    $rol = $datos['rolUsuario'] ?? '';
    if (!in_array($rol, ['administrador', 'chofer', 'jefeDeCuadrilla', 'operarioDeCuadrilla'], true)) {
        http_response_code(400);
        echo json_encode(['error' => 'Rol inválido.']);
        exit;
    }

    $idSolicitud = $datos['idSolicitud'] ?? null;
    if (!$idSolicitud) {
        http_response_code(400);
        echo json_encode(['error' => 'Falta idSolicitud.']);
        exit;
    }

    $solicitudController = new SolicitudDeUsuarioController();
    $solicitud = $solicitudController->obtenerPorId($idSolicitud);

    if ($solicitud === false) {
        http_response_code(404);
        echo json_encode(['error' => 'No se encontró esa solicitud.']);
        exit;
    }

    // La dirección de la solicitud viene en un solo campo; se guarda entera en calleUsuario.
    $datosUsuario = [
        'cedulaUsuario' => $solicitud['cedulaUsuario'],
        'nombreUsuario' => $solicitud['nombreUsuario'],
        'apellidoUsuario' => $solicitud['apellidoUsuario'],
        'calleUsuario' => $solicitud['direccionCompletaUsuario'] ?? null,
        'emailUsuario' => $solicitud['emailUsuario'] ?? null,
        'telefonoUsuario' => $solicitud['telefonoUsuario'] ?? null,
        'fechaNacimientoUsuario' => $solicitud['fechaNacimientoUsuario'] ?? null,
    ];

    $resultado = crearPersonaConRol($datosUsuario, $rol, $solicitud['contraseniaSolicitud'], true);

    if (isset($resultado['error'])) {
        http_response_code(400);
        echo json_encode($resultado);
        exit;
    }

    $solicitudController->eliminar($idSolicitud);

    echo json_encode(['exito' => true, 'cedulaUsuario' => $resultado['cedulaUsuario']]);
    exit;
}

// Un usuario logueado puede modificar su propia fila de "usuario" (email/teléfono) sin ser administrador.
$esAutoedicionDeCuenta = ($recurso === 'usuario' && $metodo === 'PUT' && ($datos['cedulaUsuario'] ?? null) !== null && ($datos['cedulaUsuario'] ?? null) === ($_SESSION['cedulaUsuario'] ?? null));

if (!$esRegistroPublico && !$esAutoedicionDeCuenta) {
    exigirRolAdministradorSiEscribe($metodo);
}

if (!$recurso || !isset($recursos[$recurso])) {
    http_response_code(404);
    echo json_encode(['error' => 'Recurso no encontrado. Recursos disponibles: ' . implode(', ', array_keys($recursos))]);
    exit;
}

$config = $recursos[$recurso];
$controllerClass = $config['controller'];
$modeloClass = $config['modelo'];
$controller = new $controllerClass();

if ($esAutoedicionDeCuenta) {
    $filaActualUsuario = $controller->obtenerPorId($datos['cedulaUsuario']);
    if ($filaActualUsuario === false || !soloCambianCamposPermitidos($filaActualUsuario, $datos, ['emailUsuario', 'telefonoUsuario'])) {
        http_response_code(403);
        echo json_encode(['error' => 'Desde tu cuenta solo podés cambiar email y teléfono.']);
        exit;
    }
}

try {
    switch ($metodo) {
        case 'GET':
            if ($id !== null) {
                $resultado = $controller->obtenerPorId($id);

                if ($resultado === false) {
                    http_response_code(404);
                    echo json_encode(['error' => 'No se encontró un registro con ese id']);
                    break;
                }
            } else {
                $resultado = $controller->obtenerTodos();
            }

            echo json_encode($resultado);
            break;

        case 'POST':
            $faltantes = validarCamposObligatorios($datos, $config['obligatoriosCrear'] ?? []);
            if (!empty($faltantes)) {
                http_response_code(400);
                echo json_encode(['error' => 'Faltan campos obligatorios: ' . implode(', ', $faltantes)]);
                break;
            }

            $args = [];
            foreach ($config['campos'] as $campo) {
                $args[] = $datos[$campo] ?? null;
            }
            $objeto = new $modeloClass(...$args);
            $ok = $controller->crear($objeto);
            echo json_encode(['exito' => (bool) $ok]);
            break;

        case 'PUT':
            $faltantes = validarCamposObligatorios($datos, $config['obligatoriosModificar'] ?? []);
            if (!empty($faltantes)) {
                http_response_code(400);
                echo json_encode(['error' => 'Faltan campos obligatorios: ' . implode(', ', $faltantes)]);
                break;
            }

            $args = [];
            foreach ($config['campos'] as $campo) {
                $args[] = $datos[$campo] ?? null;
            }
            $objeto = new $modeloClass(...$args);
            $ok = $controller->modificar($objeto);
            echo json_encode(['exito' => (bool) $ok]);
            break;

        case 'DELETE':
            if ($id === null) {
                http_response_code(400);
                echo json_encode(['error' => 'Falta el parametro id']);
                break;
            }
            $ok = $controller->eliminar($id);
            echo json_encode(['exito' => (bool) $ok]);
            break;

        default:
            http_response_code(405);
            echo json_encode(['error' => 'Metodo no soportado']);
    }
} catch (Throwable $e) {
    // El mensaje real (puede incluir nombres de tabla/columna o fragmentos
    // de la consulta) queda en el log del servidor; al cliente se le
    // devuelve uno generico para no exponer la estructura interna de la
    // base -- ver auditoria de seguridad.
    error_log('Error interno en api-usuarios: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode(['error' => 'Ocurrio un error interno. Intenta de nuevo mas tarde.']);
}
