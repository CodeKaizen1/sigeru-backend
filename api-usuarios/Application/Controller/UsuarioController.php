<?php
require_once __DIR__ . "/../Configuration/Conexion.php";
require_once __DIR__ . "/../Model/Usuario.php";

class UsuarioController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    public function crear($usuario)
    {
        $sql = "INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, calleUsuario, numeroPuertaUsuario, numeroApartamentoUsuario, emailUsuario, telefonoUsuario, fechaNacimientoUsuario, estadoUsuario, rolUsuario) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$usuario->getCedulaUsuario(), $usuario->getNombreUsuario(), $usuario->getApellidoUsuario(), $usuario->getCalleUsuario(), $usuario->getNumeroPuertaUsuario(), $usuario->getNumeroApartamentoUsuario(), $usuario->getEmailUsuario(), $usuario->getTelefonoUsuario(), $usuario->getFechaNacimientoUsuario(), $usuario->getEstadoUsuario(), $usuario->getRolUsuario()]);
    }

    public function obtenerTodos()
    {
        $sql = "SELECT * FROM usuario";

        $stmt = $this->conexion->query($sql);

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerPorId($cedulaUsuario)
    {
        $sql = "SELECT * FROM usuario WHERE cedulaUsuario = ?";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$cedulaUsuario]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function modificar($usuario)
    {
        $sql = "UPDATE usuario SET nombreUsuario = ?, apellidoUsuario = ?, calleUsuario = ?, numeroPuertaUsuario = ?, numeroApartamentoUsuario = ?, emailUsuario = ?, telefonoUsuario = ?, fechaNacimientoUsuario = ?, estadoUsuario = ?, rolUsuario = ? WHERE cedulaUsuario = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$usuario->getNombreUsuario(), $usuario->getApellidoUsuario(), $usuario->getCalleUsuario(), $usuario->getNumeroPuertaUsuario(), $usuario->getNumeroApartamentoUsuario(), $usuario->getEmailUsuario(), $usuario->getTelefonoUsuario(), $usuario->getFechaNacimientoUsuario(), $usuario->getEstadoUsuario(), $usuario->getRolUsuario(), $usuario->getCedulaUsuario()]);
    }

    public function eliminar($cedulaUsuario)
    {
        $sql = "DELETE FROM usuario WHERE cedulaUsuario = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$cedulaUsuario]);
    }

    public function obtenerPorEmail($emailUsuario)
    {
        $sql = "SELECT * FROM usuario WHERE emailUsuario = ?";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$emailUsuario]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}
?>
