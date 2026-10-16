<?php
require_once __DIR__ . "/../Application/Controller/ContenedorController.php";
require_once __DIR__ . "/../Application/Model/Contenedor.php";
require_once __DIR__ . "/../Configuration/Conexion.php";

// CRUD real de contenedor contra la base que apunte el .env de esta carpeta.
class ContenedorControllerTest
{
    private $conexion;
    private $idCreado;

    public function antes()
    {
        $this->conexion = (new Conexion())->conectar();
    }

    public function despues()
    {
        if ($this->idCreado) {
            $this->conexion->prepare("DELETE FROM contenedor WHERE idContenedor = ?")->execute([$this->idCreado]);
        }
    }

    // Busca por la ubicación (única en este test) en vez de lastInsertId():
    // ese id es por conexión PDO, y el controller abre la suya propia,
    // distinta de la de este test.
    private function buscarIdPorUbicacion($ubicacion)
    {
        $stmt = $this->conexion->prepare("SELECT idContenedor FROM contenedor WHERE ubicacionContenedor = ?");
        $stmt->execute([$ubicacion]);
        return (int) $stmt->fetchColumn();
    }

    public function testCrearYLeer()
    {
        $ubicacion = 'Test Unitario ' . uniqid();
        $controller = new ContenedorController();
        $controller->crear(new Contenedor(null, $ubicacion, 'operativo', 1100, 'organico'));

        $this->idCreado = $this->buscarIdPorUbicacion($ubicacion);
        $fila = $controller->obtenerPorId($this->idCreado);

        MiniTest::afirmarIgual($ubicacion, $fila['ubicacionContenedor'] ?? null, "debería guardar la ubicación tal cual");
        MiniTest::afirmarIgual(1100.0, (float) $fila['capacidadContenedor'], "la capacidad debería quedar como se mandó (columna DECIMAL, MySQL la devuelve con decimales)");
    }

    public function testEliminar()
    {
        $ubicacion = 'Para borrar ' . uniqid();
        $controller = new ContenedorController();
        $controller->crear(new Contenedor(null, $ubicacion, 'operativo', 500, 'reciclable'));
        $id = $this->buscarIdPorUbicacion($ubicacion);

        MiniTest::afirmar($id > 0, "tiene que haber encontrado el contenedor recién creado");
        $controller->eliminar($id);
        MiniTest::afirmarIgual(false, $controller->obtenerPorId($id), "no debería encontrarlo después de borrarlo");
    }

    // buscar() con una "esquina" (dos calles): ubicacionContenedor nunca
    // guarda una intersección, solo "calle + número de puerta" -- si el
    // vecino escribe "CalleUno y CalleDos" (porque no sabe el número de
    // puerta del contenedor de su cuadra), el buscador tiene que separar
    // ambas calles y devolver los contenedores de cualquiera de las dos, no
    // cero resultados. Crea y borra sus propios contenedores (no usa
    // idCreado/despues(): son 2 filas, no 1).
    public function testBuscarPorEsquinaDevuelveContenedoresDeAmbasCalles()
    {
        $sufijo = uniqid();
        $calleUno = "CalleUnoTest{$sufijo}";
        $calleDos = "CalleDosTest{$sufijo}";
        $ubicacionUno = "{$calleUno} 123";
        $ubicacionDos = "{$calleDos} 456";

        $controller = new ContenedorController();
        $controller->crear(new Contenedor(null, $ubicacionUno, 'operativo', 1100, 'general'));
        $controller->crear(new Contenedor(null, $ubicacionDos, 'operativo', 1100, 'general'));

        $idUno = $this->buscarIdPorUbicacion($ubicacionUno);
        $idDos = $this->buscarIdPorUbicacion($ubicacionDos);

        try {
            $resultado = $controller->buscar("{$calleUno} y {$calleDos}", null, null);
            $idsEncontrados = array_map(fn($fila) => (int) $fila['idContenedor'], $resultado);

            MiniTest::afirmar(in_array($idUno, $idsEncontrados, true), "debería incluir el contenedor de la primera calle de la esquina");
            MiniTest::afirmar(in_array($idDos, $idsEncontrados, true), "debería incluir el contenedor de la segunda calle de la esquina");

            // "esq."/"esquina"/"/" son sinónimos del mismo separador " y ".
            $resultadoEsquina = $controller->buscar("{$calleUno} esquina {$calleDos}", null, null);
            $idsEsquina = array_map(fn($fila) => (int) $fila['idContenedor'], $resultadoEsquina);
            MiniTest::afirmar(in_array($idUno, $idsEsquina, true) && in_array($idDos, $idsEsquina, true), "'esquina' debería separar igual que ' y '");

            // Sin separador reconocido, se comporta como antes: LIKE de la
            // dirección completa (no debería encontrar la otra calle).
            $resultadoSinEsquina = $controller->buscar($calleUno, null, null);
            $idsSinEsquina = array_map(fn($fila) => (int) $fila['idContenedor'], $resultadoSinEsquina);
            MiniTest::afirmar(in_array($idUno, $idsSinEsquina, true), "una calle sola sigue encontrando su propio contenedor");
            MiniTest::afirmar(!in_array($idDos, $idsSinEsquina, true), "una calle sola no debería traer contenedores de otra calle");
        } finally {
            $this->conexion->prepare("DELETE FROM contenedor WHERE idContenedor IN (?, ?)")->execute([$idUno, $idDos]);
        }
    }
}
