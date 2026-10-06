<?php
require_once __DIR__ . "/../../configuration/Conexion.php";
require_once __DIR__ . "/../Model/Notificacion.php";

// Punto 16: campanita + banner reales, contra la tabla notificacion que ya
// existía en 01_code.sql pero no tenía ningún endpoint conectado (quedaba
// simulada 100% en localStorage, ver crearNotificacionSiGeRU() en
// landing/frontend-usuarios almacenamiento-simulado.js -- eso sigue existiendo
// pero ya no lo usa nadie, es código muerto de antes de la 2da entrega).
class NotificacionController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    // INSERT genérico -- lo usan crearParaAdmin()/crearParaCuadrilla(). Devuelve
    // el id nuevo (o false si falló), igual que IncidenciaController::crear().
    public function crear($notificacion)
    {
        $sql = "INSERT INTO notificacion (destinatarioTipoNotificacion, idCuadrillaNotificacion, tipoNotificacion, mensajeNotificacion, idEntidadNotificacion) VALUES (?, ?, ?, ?, ?)";
        $stmt = $this->conexion->prepare($sql);

        $ok = $stmt->execute([
            $notificacion->getDestinatarioTipoNotificacion(),
            $notificacion->getIdCuadrillaNotificacion(),
            $notificacion->getTipoNotificacion(),
            $notificacion->getMensajeNotificacion(),
            $notificacion->getIdEntidadNotificacion(),
        ]);

        if (!$ok) {
            return false;
        }

        return (int) $this->conexion->lastInsertId();
    }

    // Para el administrador: nueva incidencia reportada, incidencia resuelta, etc.
    public function crearParaAdmin($tipo, $mensaje, $idEntidad = null)
    {
        return $this->crear(new Notificacion(null, 'admin', null, $tipo, $mensaje, $idEntidad));
    }

    // Para una cuadrilla puntual: se le asignó una incidencia nueva, etc.
    public function crearParaCuadrilla($idCuadrilla, $tipo, $mensaje, $idEntidad = null)
    {
        return $this->crear(new Notificacion(null, 'cuadrilla', $idCuadrilla, $tipo, $mensaje, $idEntidad));
    }

    // Las más nuevas primero; 50 alcanza y de sobra para la campanita (no es un historial completo).
    public function obtenerParaAdmin()
    {
        $sql = "SELECT * FROM notificacion WHERE destinatarioTipoNotificacion = 'admin' ORDER BY fechaNotificacion DESC, idNotificacion DESC LIMIT 50";
        $stmt = $this->conexion->query($sql);

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerParaCuadrilla($idCuadrilla)
    {
        $sql = "SELECT * FROM notificacion WHERE destinatarioTipoNotificacion = 'cuadrilla' AND idCuadrillaNotificacion = ? ORDER BY fechaNotificacion DESC, idNotificacion DESC LIMIT 50";
        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$idCuadrilla]);

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // $ids puede traer cualquier cosa desde el body JSON -- se castea todo a
    // entero antes de armar el IN(...) para no poder inyectar SQL por ahí.
    public function marcarLeidas($ids)
    {
        $idsValidos = array_values(array_filter(array_map('intval', $ids), fn($id) => $id > 0));
        if (empty($idsValidos)) {
            return false;
        }

        $marcadores = implode(',', array_fill(0, count($idsValidos), '?'));
        $sql = "UPDATE notificacion SET leidaNotificacion = 1 WHERE idNotificacion IN ($marcadores)";
        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute($idsValidos);
    }

    // A qué cuadrilla pertenece una notificación puntual (null si es de admin,
    // o si el id no existe) -- lo usa el router para chequear permisos antes
    // de dejar que un chofer/jefe/operario la marque como leída.
    public function idCuadrillaDeNotificacion($idNotificacion)
    {
        $sql = "SELECT idCuadrillaNotificacion FROM notificacion WHERE idNotificacion = ?";
        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([(int) $idNotificacion]);
        $valor = $stmt->fetchColumn();

        return ($valor === false || $valor === null) ? null : (int) $valor;
    }

    // Si la cédula es chofer, jefe de cuadrilla u operario de esa cuadrilla puntual.
    // Join contra operarioDeCuadrilla porque cuadrilla.idChofer/idJefeCuadrilla
    // guardan idOperarioDeCuadrilla, no la cédula directamente (mismo motivo que
    // IncidenciaController::idCuadrillaPerteneceAJefe()).
    public function cedulaPerteneceACuadrilla($cedula, $idCuadrilla)
    {
        if ($cedula === null || $idCuadrilla === null || $idCuadrilla === '') {
            return false;
        }

        $sql = "SELECT COUNT(*) FROM cuadrilla c
                JOIN operarioDeCuadrilla o ON o.idOperarioDeCuadrilla IN (c.idChofer, c.idJefeCuadrilla)
                WHERE c.idCuadrilla = ? AND o.cedulaUsuario = ?
                UNION ALL
                SELECT COUNT(*) FROM cuadrillaOperario co
                JOIN operarioDeCuadrilla o ON o.idOperarioDeCuadrilla = co.idOperarioDeCuadrilla
                WHERE co.idCuadrilla = ? AND o.cedulaUsuario = ?";
        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$idCuadrilla, $cedula, $idCuadrilla, $cedula]);

        foreach ($stmt->fetchAll(PDO::FETCH_COLUMN) as $cantidad) {
            if ((int) $cantidad > 0) {
                return true;
            }
        }

        return false;
    }
}
?>
