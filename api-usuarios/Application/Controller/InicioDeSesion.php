<?php
require_once __DIR__ . "/../Configuration/Conexion.php";
require_once __DIR__ . "/../Model/InicioDeSesion.php";

class InicioDeSesionController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    // Hashea la contraseña, salvo que $yaHasheada indique que ya viene hasheada (aprobación de solicitud).
    public function crear($inicioDeSesion, $yaHasheada = false)
    {
        $sql = "INSERT INTO inicioDeSesion (idUsuarioInicioDeSesion, contraseniaUsuarioInicioDeSesion) VALUES (?, ?)";

        $stmt = $this->conexion->prepare($sql);

        $hash = $yaHasheada
            ? $inicioDeSesion->getContraseniaUsuarioInicioDeSesion()
            : password_hash($inicioDeSesion->getContraseniaUsuarioInicioDeSesion(), PASSWORD_DEFAULT);

        return $stmt->execute([$inicioDeSesion->getIdUsuarioInicioDeSesion(), $hash]);
    }


    public function obtenerTodos()
    {
        $sql = "SELECT * FROM inicioDeSesion";

        $stmt = $this->conexion->query($sql);

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerPorId($idUsuarioInicioDeSesion)
    {
        $sql = "SELECT * FROM inicioDeSesion WHERE idUsuarioInicioDeSesion = ?";

        $stmt = $this->conexion->prepare($sql);

        $stmt->execute([$idUsuarioInicioDeSesion]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function modificar($inicioDeSesion)
    {
        $sql = "UPDATE inicioDeSesion SET contraseniaUsuarioInicioDeSesion = ? WHERE idUsuarioInicioDeSesion = ?";

        $stmt = $this->conexion->prepare($sql);

        $hash = password_hash($inicioDeSesion->getContraseniaUsuarioInicioDeSesion(), PASSWORD_DEFAULT);

        return $stmt->execute([$hash, $inicioDeSesion->getIdUsuarioInicioDeSesion()]);
    }

    public function eliminar($idUsuarioInicioDeSesion)
    {
        $sql = "DELETE FROM inicioDeSesion WHERE idUsuarioInicioDeSesion = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$idUsuarioInicioDeSesion]);
    }

    // Busca por email, verifica la contraseña y devuelve el rol resuelto.
    public function login($email, $passwordPlano)
    {
        $sql = "SELECT u.cedulaUsuario, u.nombreUsuario, u.apellidoUsuario, u.emailUsuario,
                       u.estadoUsuario, u.rolUsuario, i.contraseniaUsuarioInicioDeSesion
                FROM usuario u
                JOIN inicioDeSesion i ON i.idUsuarioInicioDeSesion = u.cedulaUsuario
                WHERE u.emailUsuario = ?";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$email]);
        $fila = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$fila) {
            return null;
        }

        if (!password_verify($passwordPlano, $fila['contraseniaUsuarioInicioDeSesion'])) {
            return null;
        }

        if ($fila['estadoUsuario'] !== 'activo') {
            return ['inactivo' => true];
        }

        return [
            'cedulaUsuario' => $fila['cedulaUsuario'],
            'nombreUsuario' => $fila['nombreUsuario'],
            'apellidoUsuario' => $fila['apellidoUsuario'],
            'emailUsuario' => $fila['emailUsuario'],
            'rol' => $fila['rolUsuario'],
        ];
    }
}
?>