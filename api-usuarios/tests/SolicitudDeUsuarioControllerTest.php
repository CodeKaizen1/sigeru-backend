<?php
require_once __DIR__ . "/../Application/Controller/SolicitudDeUsuarioController.php";
require_once __DIR__ . "/../Application/Model/SolicitudDeUsuario.php";
require_once __DIR__ . "/../Application/Configuration/Conexion.php";

// CRUD real de solicitudDeUsuario contra la base que apunte el .env de esta carpeta.
// A diferencia de otras tablas de este archivo, cedulaUsuario NO es FK acá -- es una
// solicitud de alta pendiente, puede referirse a una cédula que todavía no existe en
// "usuario".
class SolicitudDeUsuarioControllerTest
{
    private $conexion;
    private $cedula;

    public function antes()
    {
        $this->conexion = (new Conexion())->conectar();
        $this->cedula = 'TS' . substr(uniqid(), -8);
    }

    public function despues()
    {
        $this->conexion->prepare("DELETE FROM solicitudDeUsuario WHERE cedulaUsuario = ?")->execute([$this->cedula]);
    }

    private function buscarIdPorCedula()
    {
        $stmt = $this->conexion->prepare("SELECT idSolicitud FROM solicitudDeUsuario WHERE cedulaUsuario = ?");
        $stmt->execute([$this->cedula]);
        return (int) $stmt->fetchColumn();
    }

    public function testCrearHasheaLaContraseniaYQuedaPendiente()
    {
        $controller = new SolicitudDeUsuarioController();
        $controller->crear(new SolicitudDeUsuario(null, $this->cedula, 'Test', 'Solicitud', 'Calle Falsa 123', 'solicitud.' . uniqid() . '@sigeru.local', '099123456', '1990-01-01', 'miContrasenia123', 'vecino', null, null, null));

        $id = $this->buscarIdPorCedula();
        $fila = $controller->obtenerPorId($id);

        MiniTest::afirmarIgual('pendiente', $fila['estadoSolicitud'] ?? null, "una solicitud nueva debería quedar en estado pendiente por defecto");
        MiniTest::afirmar($fila['contraseniaSolicitud'] !== 'miContrasenia123', "la contraseña no debería guardarse en texto plano");
        MiniTest::afirmar(password_verify('miContrasenia123', $fila['contraseniaSolicitud']), "el hash guardado debería verificar contra la contraseña original");
    }

    public function testObtenerPendientesIncluyeLaSolicitudNueva()
    {
        $controller = new SolicitudDeUsuarioController();
        $controller->crear(new SolicitudDeUsuario(null, $this->cedula, 'Test', 'Solicitud', 'Calle Falsa 123', 'solicitud.' . uniqid() . '@sigeru.local', '099123456', '1990-01-01', 'miContrasenia123', 'vecino', null, null, null));

        $pendientes = $controller->obtenerPendientes();
        $cedulas = array_column($pendientes, 'cedulaUsuario');

        MiniTest::afirmar(in_array($this->cedula, $cedulas), "la solicitud recién creada debería aparecer entre las pendientes");
    }

    public function testModificarNoRehasheaLaContrasenia()
    {
        $controller = new SolicitudDeUsuarioController();
        $controller->crear(new SolicitudDeUsuario(null, $this->cedula, 'Test', 'Solicitud', 'Calle Falsa 123', 'solicitud.' . uniqid() . '@sigeru.local', '099123456', '1990-01-01', 'miContrasenia123', 'vecino', null, null, null));

        $id = $this->buscarIdPorCedula();
        $fila = $controller->obtenerPorId($id);
        $hashOriginal = $fila['contraseniaSolicitud'];

        $controller->modificar(new SolicitudDeUsuario($id, $this->cedula, 'Test', 'Rechazado', 'Calle Falsa 123', $fila['emailUsuario'], '099123456', '1990-01-01', $hashOriginal, 'vecino', 'rechazada', $fila['fechaSolicitud'], 'datos incompletos', date('Y-m-d H:i:s')));

        $filaModificada = $controller->obtenerPorId($id);
        MiniTest::afirmarIgual('rechazada', $filaModificada['estadoSolicitud'] ?? null, "el estado debería haber cambiado a rechazada");
        MiniTest::afirmarIgual('datos incompletos', $filaModificada['motivoRechazo'] ?? null, "debería guardar el motivo del rechazo");
        MiniTest::afirmarIgual($hashOriginal, $filaModificada['contraseniaSolicitud'], "el hash de la contraseña no debería cambiar al modificar otros campos");
    }

    public function testEliminar()
    {
        $controller = new SolicitudDeUsuarioController();
        $controller->crear(new SolicitudDeUsuario(null, $this->cedula, 'Test', 'Solicitud', 'Calle Falsa 123', 'solicitud.' . uniqid() . '@sigeru.local', '099123456', '1990-01-01', 'miContrasenia123', 'vecino', null, null, null));

        $id = $this->buscarIdPorCedula();
        $controller->eliminar($id);
        MiniTest::afirmarIgual(false, $controller->obtenerPorId($id), "no debería encontrarla después de borrarla");
    }
}
