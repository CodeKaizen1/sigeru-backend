<?php
require_once __DIR__ . "/../../configuration/Conexion.php";
require_once __DIR__ . "/../Model/Contenedor.php";

class ContenedorController
{
    private $conexion;

    public function __construct()
    {
        $db = new Conexion();
        $this->conexion = $db->conectar();
    }

    public function crear($contenedor)
    {
        $sql = "INSERT INTO contenedor (idContenedor, ubicacionContenedor, estadoContenedor, capacidadContenedor, tipoResiduoContenedor, latitudContenedor, longitudContenedor, zonaContenedor, municipioContenedor) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$contenedor->getIdContenedor(), $contenedor->getUbicacionContenedor(), $contenedor->getEstadoContenedor(), $contenedor->getCapacidadContenedor(), $contenedor->getTipoResiduoContenedor(), $contenedor->getLatitudContenedor(), $contenedor->getLongitudContenedor(), $contenedor->getZonaContenedor(), $contenedor->getMunicipioContenedor()]);
    }

    public function obtenerTodos()
    {
        $sql = "SELECT * FROM contenedor";

        $stmt = $this->conexion->query($sql);

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerPorId($idContenedor)
    {
        $sql = "SELECT * FROM contenedor WHERE idContenedor = ?";

        $stmt = $this->conexion->prepare($sql);

        $stmt->execute([$idContenedor]);

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // Mapa interactivo (entrega final): con los ~11.130 contenedores oficiales
    // de la IMM cargados, traer obtenerTodos() entero para pintar el mapa ya
    // no tiene sentido (la mayoria ni siquiera se ve en la pantalla). El mapa
    // pide solo lo que entra en el viewport actual (norte/sur/este/oeste en
    // grados decimales, el propio Leaflet da esos limites con getBounds()).
    // Requiere el indice idx_contenedor_coordenadas (ver 01_code.sql, seccion
    // 8) para no escanear la tabla entera en cada movimiento del mapa.
    public function obtenerEnBoundingBox($norte, $sur, $este, $oeste)
    {
        $sql = "SELECT * FROM contenedor
                WHERE latitudContenedor BETWEEN ? AND ?
                  AND longitudContenedor BETWEEN ? AND ?";

        $stmt = $this->conexion->prepare($sql);

        $stmt->execute([$sur, $norte, $oeste, $este]);

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function modificar($contenedor)
    {
        $sql = "UPDATE contenedor SET ubicacionContenedor = ?, estadoContenedor = ?, capacidadContenedor = ?, tipoResiduoContenedor = ?, latitudContenedor = ?, longitudContenedor = ?, zonaContenedor = ?, municipioContenedor = ? WHERE idContenedor = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$contenedor->getUbicacionContenedor(), $contenedor->getEstadoContenedor(), $contenedor->getCapacidadContenedor(), $contenedor->getTipoResiduoContenedor(), $contenedor->getLatitudContenedor(), $contenedor->getLongitudContenedor(), $contenedor->getZonaContenedor(), $contenedor->getMunicipioContenedor(), $contenedor->getIdContenedor()]);
    }

    public function eliminar($idContenedor)
    {
        $sql = "DELETE FROM contenedor WHERE idContenedor = ?";

        $stmt = $this->conexion->prepare($sql);

        return $stmt->execute([$idContenedor]);
    }
}
?>