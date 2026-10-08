<?php
// Router HTTP para api-gestion: expone los Controllers de contenedor,
// instalacion, centroDeAcopio, plantaDeProcesamiento, vertedero, maquinaria,
// incidencia, residuo y tipoResiduo vía GET/POST/PUT/DELETE (?recurso=...&id=...).

// Necesario para leer la sesión de login de api-usuarios (misma cookie PHPSESSID).
session_start();

// Solo se permite a los orígenes del frontend local de SiGeRU.
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
require_once __DIR__ . "/application/Utilidades.php";

// Instalacion primero: CentroDeAcopio, PlantaDeProcesamiento y Vertedero heredan de ella.
require_once "application/Controller/InstalacionController.php";
require_once "application/Controller/CentroDeAcopioController.php";
require_once "application/Controller/PlantaDeProcesamientoController.php";
require_once "application/Controller/VertederoController.php";
require_once "application/Controller/ContenedorController.php";
require_once "application/Controller/MaquinariaController.php";
require_once "application/Controller/IncidenciaController.php";
require_once "application/Controller/ResiduoController.php";
require_once "application/Controller/TipoResiduoController.php";
require_once "application/Controller/NotificacionController.php";

// Ninguno de estos recursos tiene campos obligatorios propios al crear; todos
// necesitan su id en "obligatoriosModificar" porque modificar() lo usa en el WHERE.
$recursos = [
    'contenedor' => [
        'controller' => 'ContenedorController',
        'modelo' => 'Contenedor',
        // latitudContenedor/longitudContenedor/zonaContenedor/municipioContenedor
        // son opcionales (mapa interactivo + enriquecimiento IMM, entrega
        // final) -- el constructor de Contenedor ya las acepta null.
        'campos' => ['idContenedor', 'ubicacionContenedor', 'estadoContenedor', 'capacidadContenedor', 'tipoResiduoContenedor', 'latitudContenedor', 'longitudContenedor', 'zonaContenedor', 'municipioContenedor'],
        'obligatoriosModificar' => ['idContenedor'],
    ],
    'instalacion' => [
        'controller' => 'InstalacionController',
        'modelo' => 'Instalacion',
        'campos' => ['idInstalacion', 'nombreInstalacion', 'ubicacionInstalacion', 'capacidadInstalacion', 'estadoOperativoInstalacion', 'tipoResiduoInstalacion', 'latitudInstalacion', 'longitudInstalacion'],
        'obligatoriosModificar' => ['idInstalacion'],
    ],
    'centroDeAcopio' => [
        'controller' => 'CentroDeAcopioController',
        'modelo' => 'CentroDeAcopio',
        'campos' => ['idInstalacion', 'nombreInstalacion', 'ubicacionInstalacion', 'capacidadInstalacion', 'estadoOperativoInstalacion', 'tipoResiduoInstalacion', 'latitudInstalacion', 'longitudInstalacion', 'clasificacionDeResiduoCentroDeAcopio', 'capacidadCentroDeAcopio'],
        'obligatoriosModificar' => ['idInstalacion'],
    ],
    'plantaDeProcesamiento' => [
        'controller' => 'PlantaDeProcesamientoController',
        'modelo' => 'PlantaDeProcesamiento',
        'campos' => ['idInstalacion', 'nombreInstalacion', 'ubicacionInstalacion', 'capacidadInstalacion', 'estadoOperativoInstalacion', 'tipoResiduoInstalacion', 'latitudInstalacion', 'longitudInstalacion', 'capacidadPlantaDeProcesamiento', 'tipoDeProcesoPlantaDeProcesamiento'],
        'obligatoriosModificar' => ['idInstalacion'],
    ],
    'vertedero' => [
        'controller' => 'VertederoController',
        'modelo' => 'Vertedero',
        'campos' => ['idInstalacion', 'nombreInstalacion', 'ubicacionInstalacion', 'capacidadInstalacion', 'estadoOperativoInstalacion', 'tipoResiduoInstalacion', 'latitudInstalacion', 'longitudInstalacion', 'vidaUtil', 'tipoDeDispocicionVertedero'],
        'obligatoriosModificar' => ['idInstalacion'],
    ],
    'maquinaria' => [
        'controller' => 'MaquinariaController',
        'modelo' => 'Maquinaria',
        'campos' => ['idMaquinaria', 'tipoDeMaquinaria', 'estadoMaquinaria', 'disponibilidadMaquinaria', 'idInstalacion'],
        'obligatoriosModificar' => ['idMaquinaria'],
    ],
    'incidencia' => [
        'controller' => 'IncidenciaController',
        'modelo' => 'Incidencia',
        'campos' => ['idIncidencia', 'descripcionIncidencia', 'estadoIncidencia', 'emailResponsableIncidencia', 'tipoIncidencia', 'zonaIncidencia', 'fechaReporte', 'idContenedor', 'idCuadrilla'],
        'obligatoriosModificar' => ['idIncidencia'],
    ],
    'residuo' => [
        'controller' => 'ResiduoController',
        'modelo' => 'Residuo',
        'campos' => ['idResiduo', 'pesoResiduo', 'fechaResiduo'],
        'obligatoriosModificar' => ['idResiduo'],
    ],
    'tipoResiduo' => [
        'controller' => 'TipoResiduoController',
        'modelo' => 'TipoResiduo',
        'campos' => ['idTipoResiduo', 'nombreTipoResiduo', 'descripcionTipoResiduo', 'esReciclableTipoResiduo'],
        'obligatoriosModificar' => ['idTipoResiduo'],
    ],
];

$recurso = $_GET['recurso'] ?? null;
$id = $_GET['id'] ?? null;
$metodo = $_SERVER['REQUEST_METHOD'];

$datos = null;
if ($metodo === 'POST' || $metodo === 'PUT') {
    $datos = json_decode(file_get_contents('php://input'), true) ?? [];
}

// El portal público (sigeru-landing, sin login) necesita GET de contenedor/incidencia
// y POST de incidencia sin sesión; el resto de la API sigue exigiendo login.
$esLecturaPublicaLanding = ($metodo === 'GET' && in_array($recurso, ['contenedor', 'incidencia'], true));
$esReportePublicoDeIncidencia = ($recurso === 'incidencia' && $metodo === 'POST');

if (!$esLecturaPublicaLanding && !$esReportePublicoDeIncidencia) {
    exigirSesion();
}

// jefeDeCuadrilla puede resolver o crear una incidencia solo si es de su propia
// cuadrilla; chofer y cualquier otro caso siguen siendo solo-lectura/solo-administrador.
$rol = $_SESSION['rolUsuario'] ?? null;
$esJefeResolviendoSuIncidencia = false;
$esJefeCreandoIncidenciaPropia = false;

if ($rol === 'jefeDeCuadrilla' && $recurso === 'incidencia') {
    $idJefe = $_SESSION['cedulaUsuario'];
    $incidenciaController = new IncidenciaController();

    if ($metodo === 'PUT') {
        $idIncidenciaObjetivo = $datos['idIncidencia'] ?? null;
        $filaActualIncidencia = $incidenciaController->obtenerPorId($idIncidenciaObjetivo);

        if (
            $filaActualIncidencia !== false
            && $incidenciaController->idCuadrillaPerteneceAJefe($filaActualIncidencia['idCuadrilla'], $idJefe)
            && soloCambianCamposPermitidos($filaActualIncidencia, $datos, ['estadoIncidencia'])
        ) {
            $esJefeResolviendoSuIncidencia = true;
        }
    } elseif ($metodo === 'POST') {
        $idCuadrillaDeclarada = $datos['idCuadrilla'] ?? null;

        if ($incidenciaController->idCuadrillaPerteneceAJefe($idCuadrillaDeclarada, $idJefe)) {
            $esJefeCreandoIncidenciaPropia = true;
        }
    }
}

// Un POST a incidencia que no es de un jefe es el reporte anónimo del vecino: se
// fuerzan idCuadrilla/estadoIncidencia server-side y se valida que el contenedor exista.
if ($esReportePublicoDeIncidencia && !$esJefeCreandoIncidenciaPropia && $datos !== null) {
    $datos['idCuadrilla'] = null;
    $datos['estadoIncidencia'] = 'abierta';

    $idContenedorDeclarado = $datos['idContenedor'] ?? null;
    if ($idContenedorDeclarado === null || $idContenedorDeclarado === '') {
        http_response_code(400);
        echo json_encode(['error' => 'Falta idContenedor']);
        exit;
    }

    $contenedorControllerPermiso = new ContenedorController();
    $contenedorDeclarado = $contenedorControllerPermiso->obtenerPorId($idContenedorDeclarado);
    if ($contenedorDeclarado === false) {
        http_response_code(400);
        echo json_encode(['error' => 'El contenedor indicado no existe']);
        exit;
    }

    // zonaIncidencia no se toma de lo que mande el cliente: se fuerza la
    // ubicacion real del contenedor guardada en la base. El reporte publico
    // no exige sesion, asi que sin esto cualquiera podia mandar HTML/texto
    // arbitrario ahi (ver auditoria de seguridad, XSS del buscador publico
    // de incidencias en sigeru-frontend/landing).
    $datos['zonaIncidencia'] = $contenedorDeclarado['ubicacionContenedor'] ?? null;
}

// tipoIncidencia y zonaIncidencia no se confian del cliente en NINGUNA vía de
// creación (ni el reporte público del vecino ni la que arma un jefe para su
// propia cuadrilla): antes esta validación solo corría en la rama del reporte
// público de arriba, así que un jefe podía mandar zonaIncidencia/tipoIncidencia
// arbitrarios en el POST -- ver auditoría 08/10/2026, Fase 1 punto 4.
if (($esReportePublicoDeIncidencia || $esJefeCreandoIncidenciaPropia) && $datos !== null) {
    if ($esJefeCreandoIncidenciaPropia) {
        // Acá zonaIncidencia no viene de un contenedor (el jefe puede reportar
        // sin uno puntual, ver crearIncidenciaDesdeCuadrilla() en model.js):
        // se deriva de la ruta real asignada a su cuadrilla.
        $zonaReal = $incidenciaController->zonaDeCuadrilla($idCuadrillaDeclarada);
        $datos['zonaIncidencia'] = $zonaReal ?? ($datos['zonaIncidencia'] ?? null);
    }

    // tipoIncidencia se valida contra la misma lista fija que usa el <select>
    // del formulario público (TIPOS_INCIDENCIA en landing/js/app.js) -- antes
    // solo se validaba del lado del JS, y el endpoint acepta POST sin sesión.
    // Un valor inválido ahora corta con 400 en vez de reemplazarse en
    // silencio (punto 8 de la misma auditoría): así queda claro en el
    // cliente que algo vino mal, en vez de guardarse como "Otra situación"
    // sin que nadie se entere.
    $tiposIncidenciaPermitidos = [
        'Contenedor desbordado',
        'Contenedor dañado',
        'Contenedor prendido fuego',
        'Residuos fuera de lugar',
        'Otra situación',
    ];
    if (!in_array($datos['tipoIncidencia'] ?? null, $tiposIncidenciaPermitidos, true)) {
        http_response_code(400);
        echo json_encode(['error' => 'tipoIncidencia inválido']);
        exit;
    }
}

// Punto 16: un chofer/jefe/operario puede marcar como leídas SUS PROPIAS
// notificaciones (PUT) sin ser administrador -- el chequeo de que sean
// realmente suyas (y no las de otra cuadrilla) se hace más abajo, en el
// bloque propio de "notificacion", antes de llamar a marcarLeidas().
$esFuncionarioGestionandoNotificaciones = (
    $recurso === 'notificacion'
    && in_array($rol, ['chofer', 'jefeDeCuadrilla', 'operarioDeCuadrilla'], true)
);

if (!$esReportePublicoDeIncidencia && !$esJefeResolviendoSuIncidencia && !$esJefeCreandoIncidenciaPropia && !$esFuncionarioGestionandoNotificaciones) {
    exigirRolAdministradorSiEscribe($metodo);
}

// "notificacion" no entra en el dispatch genérico de $recursos: GET necesita
// filtrar por destinatario (admin vs. cuadrilla puntual) y PUT recibe un
// array de ids a marcar leídos, no los campos de un modelo -- se resuelve acá
// aparte, antes de llegar al switch genérico, igual que el reporte público de
// incidencia se resuelve antes del suyo.
if ($recurso === 'notificacion') {
    $notificacionController = new NotificacionController();

    try {
        switch ($metodo) {
            case 'GET':
                $destinatario = $_GET['destinatario'] ?? null;

                if ($destinatario === 'admin') {
                    if ($rol !== 'administrador') {
                        http_response_code(403);
                        echo json_encode(['error' => 'Solo el administrador puede ver estas notificaciones.']);
                        break;
                    }
                    echo json_encode($notificacionController->obtenerParaAdmin());
                } elseif ($destinatario === 'cuadrilla') {
                    $idCuadrillaPedida = $_GET['idCuadrilla'] ?? null;
                    if ($idCuadrillaPedida === null || $idCuadrillaPedida === '') {
                        http_response_code(400);
                        echo json_encode(['error' => 'Falta idCuadrilla']);
                        break;
                    }
                    // Un chofer/jefe/operario solo puede pedir las notificaciones de
                    // SU propia cuadrilla, no las de cualquier otra; el admin sí puede.
                    if ($rol !== 'administrador' && !$notificacionController->cedulaPerteneceACuadrilla($_SESSION['cedulaUsuario'] ?? null, $idCuadrillaPedida)) {
                        http_response_code(403);
                        echo json_encode(['error' => 'No pertenecés a esa cuadrilla.']);
                        break;
                    }
                    echo json_encode($notificacionController->obtenerParaCuadrilla($idCuadrillaPedida));
                } else {
                    http_response_code(400);
                    echo json_encode(['error' => 'Falta el parámetro destinatario (admin|cuadrilla)']);
                }
                break;

            case 'PUT':
                $idsAMarcar = $datos['ids'] ?? null;
                if (!is_array($idsAMarcar) || empty($idsAMarcar)) {
                    http_response_code(400);
                    echo json_encode(['error' => 'Falta ids (array)']);
                    break;
                }

                // Un no-administrador solo puede marcar como leídas notificaciones
                // de SU propia cuadrilla (nunca las de otra, ni las de admin).
                if ($rol !== 'administrador') {
                    foreach ($idsAMarcar as $idNotifAMarcar) {
                        $idCuadrillaDeEsa = $notificacionController->idCuadrillaDeNotificacion($idNotifAMarcar);
                        if ($idCuadrillaDeEsa === null || !$notificacionController->cedulaPerteneceACuadrilla($_SESSION['cedulaUsuario'] ?? null, $idCuadrillaDeEsa)) {
                            http_response_code(403);
                            echo json_encode(['error' => 'No podés marcar notificaciones que no son tuyas.']);
                            exit;
                        }
                    }
                }

                $ok = $notificacionController->marcarLeidas($idsAMarcar);
                echo json_encode(['exito' => (bool) $ok]);
                break;

            default:
                http_response_code(405);
                echo json_encode(['error' => 'Metodo no soportado']);
        }
    } catch (Throwable $e) {
        error_log('Error interno en api-gestion (notificacion): ' . $e->getMessage());
        http_response_code(500);
        echo json_encode(['error' => 'Ocurrio un error interno. Intenta de nuevo mas tarde.']);
    }
    exit;
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
            } elseif (
                $recurso === 'contenedor'
                && isset($_GET['accion']) && $_GET['accion'] === 'filtros'
            ) {
                // Listas de barrio/municipio para los <select> del buscador del mapa.
                $resultado = $controller->obtenerFiltrosDisponibles();
            } elseif (
                $recurso === 'contenedor'
                && (
                    (isset($_GET['direccion']) && $_GET['direccion'] !== '')
                    || (isset($_GET['barrio']) && $_GET['barrio'] !== '')
                    || (isset($_GET['municipio']) && $_GET['municipio'] !== '')
                )
            ) {
                // Buscador del mapa: direccion/barrio/municipio son
                // independientes y combinables -- se puede buscar solo por
                // nombre de calle, sin elegir barrio ni municipio.
                $resultado = $controller->buscar(
                    $_GET['direccion'] ?? null,
                    $_GET['barrio'] ?? null,
                    $_GET['municipio'] ?? null
                );
            } elseif (
                $recurso === 'contenedor'
                && isset($_GET['bboxNorte'], $_GET['bboxSur'], $_GET['bboxEste'], $_GET['bboxOeste'])
            ) {
                // Mapa interactivo: con los contenedores oficiales de la IMM
                // cargados (~11 mil), el mapa pide solo lo que entra en su
                // viewport actual en vez de obtenerTodos() entero.
                $resultado = $controller->obtenerEnBoundingBox(
                    (float) $_GET['bboxNorte'],
                    (float) $_GET['bboxSur'],
                    (float) $_GET['bboxEste'],
                    (float) $_GET['bboxOeste']
                );
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

            $respuestaCrear = ['exito' => (bool) $ok];

            // "incidencia" devuelve además el id recién creado, para poder buscarlo en Seguimiento.
            if ($recurso === 'incidencia' && $ok !== false) {
                $respuestaCrear['idIncidencia'] = $ok;
            }

            echo json_encode($respuestaCrear);
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
    error_log('Error interno en api-gestion: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode(['error' => 'Ocurrio un error interno. Intenta de nuevo mas tarde.']);
}
