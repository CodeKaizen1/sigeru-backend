<?php
require_once __DIR__ . "/../../Configuration/Conexion.php";
require_once __DIR__ . "/../Model/Ruta.php";

class RutaController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    public function crear($ruta)
    {
        $sql = "INSERT INTO ruta (idRuta, zonaRuta, recorridoRuta, frecuenciaDeRecoleccionRuta, horarioRuta, estadoRuta, horaInicioRealRuta, horaFinRealRuta, estadoAdminRuta, nombreRuta) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$ruta->getIdRuta(), $ruta->getZonaRuta(), $ruta->getRecorridoRuta(), $ruta->getFrecuenciaDeRecoleccionRuta(), $ruta->getHorarioRuta(), $ruta->getEstadoRuta() ?? 'sin iniciar', $ruta->getHoraInicioRealRuta(), $ruta->getHoraFinRealRuta(), $ruta->getEstadoAdminRuta() ?? 'activa', $ruta->getNombreRuta()]);
    }

    public function obtenerTodos()
    {
        $sql = "SELECT * FROM ruta";

        return $this->conexion->query($sql)->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerPorId($idRuta)
    {
        $sql = "SELECT * FROM ruta WHERE idRuta = ?";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$idRuta]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function modificar($ruta)
    {
        $sql = "UPDATE ruta SET zonaRuta = ?, recorridoRuta = ?, frecuenciaDeRecoleccionRuta = ?, horarioRuta = ?, estadoRuta = ?, horaInicioRealRuta = ?, horaFinRealRuta = ?, estadoAdminRuta = ?, nombreRuta = ? WHERE idRuta = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$ruta->getZonaRuta(), $ruta->getRecorridoRuta(), $ruta->getFrecuenciaDeRecoleccionRuta(), $ruta->getHorarioRuta(), $ruta->getEstadoRuta(), $ruta->getHoraInicioRealRuta(), $ruta->getHoraFinRealRuta(), $ruta->getEstadoAdminRuta(), $ruta->getNombreRuta(), $ruta->getIdRuta()]);
    }

    public function eliminar($idRuta)
    {
        $sql = "DELETE FROM ruta WHERE idRuta = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$idRuta]);
    }
}
?>
