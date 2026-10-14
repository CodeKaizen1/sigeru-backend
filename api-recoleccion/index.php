<?php
// Router HTTP para api-recoleccion. Expone los Controllers de Ruta, Vehiculo y Cuadrilla.
//
// Uso:
//   GET    index.php?recurso=vehiculo               -> obtenerTodos()
//   GET    index.php?recurso=vehiculo&id=1           -> obtenerPorId(1)
//   POST   index.php?recurso=vehiculo   (body JSON)  -> crear(...)
//   PUT    index.php?recurso=vehiculo&id=1 (body JSON) -> modificar(...)
//   DELETE index.php?recurso=vehiculo&id=1           -> eliminar(1)
//
// Recursos disponibles: ruta, vehiculo, cuadrilla

session_start();

// Solo se permiten los orígenes desde donde corre el frontend de SiGeRU.
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

require_once "Application/Controller/RutaController.php";
require_once "Application/Controller/VehiculoController.php";
require_once "Application/Controller/CuadrillaController.php";

// Config de cada recurso expuesto: controller, modelo, campos que arma el objeto y campos obligatorios por operación.
$recursos = [
    'ruta' => [
        'controller' => 'RutaController',
        'modelo' => 'Ruta',
        'campos' => ['idRuta', 'zonaRuta', 'recorridoRuta', 'frecuenciaDeRecoleccionRuta', 'horarioRuta', 'estadoRuta', 'horaInicioRealRuta', 'horaFinRealRuta', 'estadoAdminRuta', 'nombreRuta', 'municipioRuta'],
        'obligatoriosModificar' => ['idRuta'],
    ],
    'vehiculo' => [
        'controller' => 'VehiculoController',
        'modelo' => 'Vehiculo',
        'campos' => ['idVehiculo', 'matriculaVehiculo', 'marcaVehiculo', 'modeloVehiculo', 'anioVehiculo', 'disponibilidadVehiculo', 'capacidadVehiculo', 'mantenimientoVehiculo', 'idChofer'],
        'obligatoriosModificar' => ['idVehiculo'],
    ],
    'cuadrilla' => [
        'controller' => 'CuadrillaController',
        'modelo' => 'Cuadrilla',
        'campos' => ['idCuadrilla', 'nombreCuadrilla', 'idChofer', 'idJefeCuadrilla', 'idRuta', 'estadoCuadrilla'],
        'obligatoriosModificar' => ['idCuadrilla'],
    ],
];

$recurso = $_GET['recurso'] ?? null;
$id = $_GET['id'] ?? null;
$metodo = $_SERVER['REQUEST_METHOD'];

$datos = null;
if ($metodo === 'POST' || $metodo === 'PUT') {
    $datos = json_decode(file_get_contents('php://input'), true) ?? [];
}

exigirSesion();

// Excepción a la regla de solo-administrador: jefeDeCuadrilla puede marcar
// inicio/fin de la ruta de su propia cuadrilla, sin tocar el resto de la fila.
$rol = $_SESSION['rolUsuario'] ?? null;
$esJefeMarcandoSuPropiaRuta = false;

if ($rol === 'jefeDeCuadrilla' && $recurso === 'ruta' && $metodo === 'PUT') {
    $idJefe = $_SESSION['cedulaUsuario'];
    $idRutaObjetivo = $datos['idRuta'] ?? null;

    $cuadrillaController = new CuadrillaController();
    if ($cuadrillaController->idRutaPerteneceAJefe($idRutaObjetivo, $idJefe)) {
        $rutaController = new RutaController();
        $filaActualRuta = $rutaController->obtenerPorId($idRutaObjetivo);

        if ($filaActualRuta !== false && soloCambianCamposPermitidos($filaActualRuta, $datos, ['estadoRuta', 'horaInicioRealRuta', 'horaFinRealRuta'])) {
            $esJefeMarcandoSuPropiaRuta = true;
        }
    }
}

if (!$esJefeMarcandoSuPropiaRuta) {
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
    error_log('Error interno en api-recoleccion: ' . $e->getMessage());
    http_response_code(500);
    echo json_encode(['error' => 'Ocurrio un error interno. Intenta de nuevo mas tarde.']);
}
