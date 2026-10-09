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

    // Buscador del mapa de la landing: direccion/barrio/municipio son todos
    // opcionales e independientes entre si (se puede buscar solo por nombre
    // de calle, sin elegir barrio ni municipio). ubicacionContenedor guarda
    // "calle + numero de puerta" como un solo string (ver 13-bis) -- nunca
    // una esquina/interseccion. El vecino no conoce el numero de puerta del
    // contenedor de su cuadra (ver cambio de label a "Calle y esquina mas
    // cercana"), asi que si escribe "Caramuru y Rocafuerte" separarCalleYEsquina()
    // lo parte en sus 2 calles y se busca con OR entre ambas -- la lista
    // muestra los contenedores de cualquiera de las 2 calles nombradas y la
    // persona elige a ojo el mas cercano a esa esquina. Una direccion sin
    // separador (solo "Caramuru") se comporta exactamente igual que antes.
    public function buscar($direccion, $barrio, $municipio)
    {
        $condiciones = [];
        $parametros = [];

        if ($direccion !== null && $direccion !== '') {
            $condicionesDireccion = [];
            foreach ($this->separarCalleYEsquina($direccion) as $parteDireccion) {
                $condicionesDireccion[] = "ubicacionContenedor LIKE ?";
                $parametros[] = '%' . $parteDireccion . '%';
            }
            $condiciones[] = '(' . implode(' OR ', $condicionesDireccion) . ')';
        }
        if ($barrio !== null && $barrio !== '') {
            $condiciones[] = "zonaContenedor = ?";
            $parametros[] = $barrio;
        }
        if ($municipio !== null && $municipio !== '') {
            $condiciones[] = "municipioContenedor = ?";
            $parametros[] = $municipio;
        }

        $where = $condiciones ? ('WHERE ' . implode(' AND ', $condiciones)) : '';

        // Tope duro: una busqueda muy amplia (ej. una sola letra de calle,
        // sin barrio/municipio) no puede devolver miles de filas de una.
        $sql = "SELECT * FROM contenedor $where ORDER BY ubicacionContenedor LIMIT 300";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute($parametros);

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Separa "Calle A y Calle B" / "Calle A esq. Calle B" / "Calle A esquina
    // Calle B" / "Calle A / Calle B" / "Calle A con Calle B" en sus 2 calles.
    // Si no reconoce ningun separador (una sola calle, sin esquina) devuelve
    // la direccion completa tal cual, sin partir nada.
    private function separarCalleYEsquina($direccion)
    {
        $separadores = [' esquina ', ' esq. ', ' esq ', ' y ', ' con ', '/'];
        $texto = ' ' . trim($direccion) . ' ';

        foreach ($separadores as $separador) {
            $posicion = stripos($texto, $separador);
            if ($posicion === false) continue;

            $primeraCalle = trim(substr($texto, 0, $posicion));
            $segundaCalle = trim(substr($texto, $posicion + strlen($separador)));
            $calles = array_values(array_filter([$primeraCalle, $segundaCalle], fn($calle) => $calle !== ''));

            if (count($calles) === 2) return $calles;
        }

        return [trim($direccion)];
    }

    // Contenedores de UNA ruta especifica (panel de chofer/jefe/operario,
    // "Direcciones de mi ruta") -- antes se pedian por barrio completo
    // (buscar() con $barrio), pero un barrio grande puede tener varias
    // rutas reales distintas (ver contenedor.idRuta, 01_code.sql seccion
    // 11): esto devuelve solo los contenedores de ESA ruta en particular.
    // Sin LIMIT: una ruta individual tiene ~25-40 contenedores (rango
    // realista para un camion), muy por debajo de cualquier tope.
    public function obtenerPorRuta($idRuta)
    {
        $sql = "SELECT * FROM contenedor WHERE idRuta = ? ORDER BY ubicacionContenedor";

        $stmt = $this->conexion->prepare($sql);
        $stmt->execute([$idRuta]);

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Listas de valores distintos para poblar los <select> de barrio/municipio
    // del buscador del mapa (el landing nunca carga los ~11.130 contenedores
    // completos, asi que estas listas las tiene que dar el backend).
    public function obtenerFiltrosDisponibles()
    {
        $barrios = $this->conexion->query(
            "SELECT DISTINCT zonaContenedor FROM contenedor WHERE zonaContenedor IS NOT NULL AND zonaContenedor <> '' ORDER BY zonaContenedor"
        )->fetchAll(PDO::FETCH_COLUMN);

        $municipios = $this->conexion->query(
            "SELECT DISTINCT municipioContenedor FROM contenedor WHERE municipioContenedor IS NOT NULL AND municipioContenedor <> '' ORDER BY municipioContenedor"
        )->fetchAll(PDO::FETCH_COLUMN);

        return ['barrios' => $barrios, 'municipios' => $municipios];
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