<?php
require_once __DIR__ . "/../Application/Controller/NotificacionController.php";
require_once __DIR__ . "/../Configuration/Conexion.php";

// Punto 16: notificaciones reales. Arma una cuadrilla de prueba completa (chofer +
// jefe + operario, todos vía disposable-usuario-con-cascada, mismo patrón de la
// Fase 5) porque cedulaPerteneceACuadrilla() necesita los 3 roles para probarse
// de verdad -- no alcanza con una cuadrilla vacía.
class NotificacionControllerTest
{
    private $conexion;
    private $cedulaChofer;
    private $cedulaJefe;
    private $cedulaOperario;
    private $cedulaAjena;
    private $idCuadrilla;
    private $idsNotificacionCreados = [];

    public function antes()
    {
        $this->conexion = (new Conexion())->conectar();

        $sufijo = substr(uniqid(), -8);
        $this->cedulaChofer = 'TC' . $sufijo;
        $this->cedulaJefe = 'TJ' . $sufijo;
        $this->cedulaOperario = 'TP' . $sufijo;
        $this->cedulaAjena = 'TX' . $sufijo;

        $insertUsuario = $this->conexion->prepare(
            "INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, estadoUsuario, rolUsuario) VALUES (?, 'Test', 'Notificacion', 'activo', ?)"
        );
        $insertUsuario->execute([$this->cedulaChofer, 'chofer']);
        $insertUsuario->execute([$this->cedulaJefe, 'jefeDeCuadrilla']);
        $insertUsuario->execute([$this->cedulaOperario, 'operarioDeCuadrilla']);
        $insertUsuario->execute([$this->cedulaAjena, 'chofer']);

        $insertOperario = $this->conexion->prepare(
            "INSERT INTO operarioDeCuadrilla (cedulaUsuario, estadoOperarioDeCuadrilla, cargoOperarioDeCuadrilla) VALUES (?, 'activo', ?)"
        );
        $insertOperario->execute([$this->cedulaChofer, 'chofer']);
        $insertOperario->execute([$this->cedulaJefe, 'jefe']);
        $insertOperario->execute([$this->cedulaOperario, 'peon']);
        $insertOperario->execute([$this->cedulaAjena, 'chofer']);

        $idOperarioChofer = $this->buscarIdOperarioPorCedula($this->cedulaChofer);
        $idOperarioJefe = $this->buscarIdOperarioPorCedula($this->cedulaJefe);
        $idOperarioOperario = $this->buscarIdOperarioPorCedula($this->cedulaOperario);

        $nombreCuadrilla = 'Cuadrilla test notif ' . $sufijo;
        $this->conexion->prepare(
            "INSERT INTO cuadrilla (nombreCuadrilla, idChofer, idJefeCuadrilla) VALUES (?, ?, ?)"
        )->execute([$nombreCuadrilla, $idOperarioChofer, $idOperarioJefe]);

        $stmt = $this->conexion->prepare("SELECT idCuadrilla FROM cuadrilla WHERE nombreCuadrilla = ?");
        $stmt->execute([$nombreCuadrilla]);
        $this->idCuadrilla = (int) $stmt->fetchColumn();

        // Mismo patrón que usan los datos de prueba reales (02_datos_prueba.sql):
        // el operario raso queda asignado a la cuadrilla directamente en
        // operarioDeCuadrilla.idCuadrilla, no en la tabla puente cuadrillaOperario.
        $this->conexion->prepare(
            "UPDATE operarioDeCuadrilla SET idCuadrilla = ? WHERE idOperarioDeCuadrilla = ?"
        )->execute([$this->idCuadrilla, $idOperarioOperario]);
    }

    public function despues()
    {
        if (!empty($this->idsNotificacionCreados)) {
            $marcadores = implode(',', array_fill(0, count($this->idsNotificacionCreados), '?'));
            $this->conexion->prepare("DELETE FROM notificacion WHERE idNotificacion IN ($marcadores)")
                ->execute($this->idsNotificacionCreados);
        }

        // La cuadrilla primero: idChofer/idJefeCuadrilla son FK sin ON DELETE
        // CASCADE hacia operarioDeCuadrilla, así que si se borra el usuario
        // antes, el DELETE de operarioDeCuadrilla (cascada) choca con esta fila.
        // Antes de poder borrarla, hay que soltar operarioDeCuadrilla.idCuadrilla
        // (fk_operario_cuadrilla no tiene ON DELETE, es RESTRICT por defecto).
        if ($this->idCuadrilla) {
            $this->conexion->prepare("UPDATE operarioDeCuadrilla SET idCuadrilla = NULL WHERE idCuadrilla = ?")->execute([$this->idCuadrilla]);
            $this->conexion->prepare("DELETE FROM cuadrilla WHERE idCuadrilla = ?")->execute([$this->idCuadrilla]);
        }

        $marcadoresCedulas = implode(',', array_fill(0, 4, '?'));
        $this->conexion->prepare("DELETE FROM usuario WHERE cedulaUsuario IN ($marcadoresCedulas)")
            ->execute([$this->cedulaChofer, $this->cedulaJefe, $this->cedulaOperario, $this->cedulaAjena]);
    }

    private function buscarIdOperarioPorCedula($cedula)
    {
        $stmt = $this->conexion->prepare("SELECT idOperarioDeCuadrilla FROM operarioDeCuadrilla WHERE cedulaUsuario = ?");
        $stmt->execute([$cedula]);
        return (int) $stmt->fetchColumn();
    }

    private function buscarIdNotificacionPorMensaje($mensaje)
    {
        $stmt = $this->conexion->prepare("SELECT idNotificacion FROM notificacion WHERE mensajeNotificacion = ?");
        $stmt->execute([$mensaje]);
        $id = (int) $stmt->fetchColumn();
        if ($id) $this->idsNotificacionCreados[] = $id;
        return $id;
    }

    public function testCrearParaAdminApareceEnObtenerParaAdmin()
    {
        $mensaje = 'Mensaje admin de prueba ' . uniqid();
        $controller = new NotificacionController();
        $controller->crearParaAdmin('incidencia_nueva', $mensaje, 123);

        $filas = $controller->obtenerParaAdmin();
        $this->buscarIdNotificacionPorMensaje($mensaje);

        $encontrada = null;
        foreach ($filas as $fila) {
            if ($fila['mensajeNotificacion'] === $mensaje) $encontrada = $fila;
        }

        MiniTest::afirmar($encontrada !== null, "debería aparecer en obtenerParaAdmin()");
        MiniTest::afirmarIgual('admin', $encontrada['destinatarioTipoNotificacion'] ?? null, "destinatario debería ser admin");
        MiniTest::afirmarIgual(null, $encontrada['idCuadrillaNotificacion'], "una notificación de admin no debería tener cuadrilla");
        MiniTest::afirmarIgual(123, (int) ($encontrada['idEntidadNotificacion'] ?? 0), "debería guardar el id de entidad");
        MiniTest::afirmarIgual(0, (int) ($encontrada['leidaNotificacion'] ?? 1), "debería crearse sin leer");
    }

    public function testCrearParaCuadrillaSoloApareceEnSuPropiaCuadrilla()
    {
        $mensaje = 'Mensaje cuadrilla de prueba ' . uniqid();
        $controller = new NotificacionController();
        $controller->crearParaCuadrilla($this->idCuadrilla, 'incidencia_asignada', $mensaje, 456);
        $this->buscarIdNotificacionPorMensaje($mensaje);

        $propias = $controller->obtenerParaCuadrilla($this->idCuadrilla);
        $deOtra = $controller->obtenerParaCuadrilla($this->idCuadrilla + 999999);

        $apareceEnPropias = false;
        foreach ($propias as $fila) {
            if ($fila['mensajeNotificacion'] === $mensaje) $apareceEnPropias = true;
        }
        $apareceEnOtra = false;
        foreach ($deOtra as $fila) {
            if ($fila['mensajeNotificacion'] === $mensaje) $apareceEnOtra = true;
        }

        MiniTest::afirmar($apareceEnPropias, "debería aparecer al pedir las notificaciones de su propia cuadrilla");
        MiniTest::afirmar(!$apareceEnOtra, "no debería aparecer al pedir las de otra cuadrilla");
    }

    public function testMarcarLeidasCambiaElEstado()
    {
        $mensaje = 'Mensaje a marcar leído ' . uniqid();
        $controller = new NotificacionController();
        $controller->crearParaAdmin('incidencia_nueva', $mensaje, null);
        $id = $this->buscarIdNotificacionPorMensaje($mensaje);

        $ok = $controller->marcarLeidas([$id]);
        MiniTest::afirmar($ok, "marcarLeidas debería devolver true");

        $filas = $controller->obtenerParaAdmin();
        $fila = null;
        foreach ($filas as $f) {
            if ((int) $f['idNotificacion'] === $id) $fila = $f;
        }

        MiniTest::afirmarIgual(1, (int) ($fila['leidaNotificacion'] ?? 0), "debería quedar marcada como leída");
    }

    public function testMarcarLeidasIgnoraIdsInvalidos()
    {
        $controller = new NotificacionController();
        $ok = $controller->marcarLeidas(['abc', '0', '-5']);
        MiniTest::afirmarIgual(false, $ok, "sin ningún id válido no debería ejecutar el UPDATE");
    }

    public function testIdCuadrillaDeNotificacion()
    {
        $mensajeCuadrilla = 'Mensaje para idCuadrillaDeNotificacion ' . uniqid();
        $mensajeAdmin = 'Mensaje admin para idCuadrillaDeNotificacion ' . uniqid();
        $controller = new NotificacionController();

        $controller->crearParaCuadrilla($this->idCuadrilla, 'incidencia_asignada', $mensajeCuadrilla, null);
        $controller->crearParaAdmin('incidencia_nueva', $mensajeAdmin, null);

        $idNotifCuadrilla = $this->buscarIdNotificacionPorMensaje($mensajeCuadrilla);
        $idNotifAdmin = $this->buscarIdNotificacionPorMensaje($mensajeAdmin);

        MiniTest::afirmarIgual($this->idCuadrilla, $controller->idCuadrillaDeNotificacion($idNotifCuadrilla), "debería devolver la cuadrilla dueña");
        MiniTest::afirmarIgual(null, $controller->idCuadrillaDeNotificacion($idNotifAdmin), "una notificación de admin no tiene cuadrilla dueña");
    }

    public function testCedulaPerteneceACuadrillaParaChoferJefeYOperario()
    {
        $controller = new NotificacionController();

        MiniTest::afirmar($controller->cedulaPerteneceACuadrilla($this->cedulaChofer, $this->idCuadrilla), "el chofer debería pertenecer a su cuadrilla");
        MiniTest::afirmar($controller->cedulaPerteneceACuadrilla($this->cedulaJefe, $this->idCuadrilla), "el jefe debería pertenecer a su cuadrilla");
        MiniTest::afirmar($controller->cedulaPerteneceACuadrilla($this->cedulaOperario, $this->idCuadrilla), "el operario raso debería pertenecer a su cuadrilla (vía operarioDeCuadrilla.idCuadrilla)");
        MiniTest::afirmar(!$controller->cedulaPerteneceACuadrilla($this->cedulaAjena, $this->idCuadrilla), "una cédula sin relación no debería pertenecer a la cuadrilla");
    }
}
