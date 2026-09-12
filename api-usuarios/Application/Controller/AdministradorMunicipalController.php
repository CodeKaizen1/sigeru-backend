<?php
require_once __DIR__ . "/../Configuration/Conexion.php";
require_once __DIR__ . "/../Model/AdministradorMunicipal.php";

class AdministradorMunicipalController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    public function crear($administrador)
    {
        $sql = "INSERT INTO administradorMunicipal (idAdministradorMunicipal, cedulaUsuario, correoInstaladorMunicipal) VALUES (?, ?, ?)";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$administrador->getIdAdministradorMunicipal(), $administrador->getCedulaUsuario(), $administrador->getCorreoInstaladorMunicipal()]);
    }

    public function obtenerTodos()
    {
        $sql = "SELECT * FROM administradorMunicipal";

        $stmt = $this->conexion->query($sql);

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerPorId($idAdministradorMunicipal)
    {
        $sql = "SELECT * FROM administradorMunicipal WHERE idAdministradorMunicipal = ?";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$idAdministradorMunicipal]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function modificar($administrador)
    {
        $sql = "UPDATE administradorMunicipal SET cedulaUsuario = ?, correoInstaladorMunicipal = ? WHERE idAdministradorMunicipal = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$administrador->getCedulaUsuario(), $administrador->getCorreoInstaladorMunicipal(), $administrador->getIdAdministradorMunicipal()]);
    }

    public function eliminar($idAdministradorMunicipal)
    {
        $sql = "DELETE FROM administradorMunicipal WHERE idAdministradorMunicipal = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$idAdministradorMunicipal]);
    }
}
?>