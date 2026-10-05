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

// Ninguno de estos recursos tiene campos obligatorios propios al crear; todos
// necesitan su id en "obligatoriosModificar" porque modificar() lo usa en el WHERE.
$recursos = [
    'contenedor' => [
        'controller' => 'ContenedorController',
        'modelo' => 'Contenedor',
        // latitudContenedor/longitudContenedor son opcionales (mapa interactivo,
        // entrega final) -- el constructor de Contenedor ya las acepta null.
        'campos' => ['idContenedor', 'ubicacionContenedor', 'estadoContenedor', 'capacidadContenedor', 'tipoResiduoContenedor', 'latitudContenedor', 'longitudContenedor'],
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

    // tipoIncidencia se valida contra la misma lista fija que usa el <select>
    // del formulario publico (TIPOS_INCIDENCIA en landing/js/app.js) -- antes
    // solo se validaba del lado del JS, y el endpoint acepta POST sin sesion.
    $tiposIncidenciaPermitidos = [
        'Contenedor desbordado',
        'Contenedor dañado',
        'Contenedor prendido fuego',
        'Residuos fuera de lugar',
        'Otra situación',
    ];
    if (!in_array($datos['tipoIncidencia'] ?? null, $tiposIncidenciaPermitidos, true)) {
        $datos['tipoIncidencia'] = 'Otra situación';
    }
}

if (!$esReportePublicoDeIncidencia && !$esJefeResolviendoSuIncidencia && !$esJefeCreandoIncidenciaPropia) {
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
