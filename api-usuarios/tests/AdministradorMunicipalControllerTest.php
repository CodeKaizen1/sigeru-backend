<?php
require_once __DIR__ . "/../Application/Controller/AdministradorMunicipalController.php";
require_once __DIR__ . "/../Application/Model/AdministradorMunicipal.php";
require_once __DIR__ . "/../Application/Configuration/Conexion.php";

// CRUD real de administradorMunicipal contra la base que apunte el .env de esta carpeta.
// cedulaUsuario es FK a usuario (ON DELETE CASCADE), así que cada test crea su propio
// usuario de prueba y lo borra en despues() -- eso cascadea y limpia la fila de
// administradorMunicipal sin necesidad de borrarla aparte.
class AdministradorMunicipalControllerTest
{
    private $conexion;
    private $cedula;

    public function antes()
    {
        $this->conexion = (new Conexion())->conectar();
        $this->cedula = 'TA' . substr(uniqid(), -8);
        $this->conexion->prepare(
            "INSERT INTO usuario (cedulaUsuario, nombreUsuario, apellidoUsuario, estadoUsuario, rolUsuario) VALUES (?, 'Test', 'Admin', 'activo', 'administradorMunicipal')"
        )->execute([$this->cedula]);
    }

    public function despues()
    {
        // Cascadea y borra también la fila de administradorMunicipal si se creó.
        $this->conexion->prepare("DELETE FROM usuario WHERE cedulaUsuario = ?")->execute([$this->cedula]);
    }

    private function buscarIdPorCedula()
    {
        $stmt = $this->conexion->prepare("SELECT idAdministradorMunicipal FROM administradorMunicipal WHERE cedulaUsuario = ?");
        $stmt->execute([$this->cedula]);
        return (int) $stmt->fetchColumn();
    }

    public function testCrearYLeer()
    {
        $correo = 'admin.' . uniqid() . '@municipio.gub.uy';
        $controller = new AdministradorMunicipalController();
        $controller->crear(new AdministradorMunicipal($this->cedula, 'Test', 'Admin', null, null, null, null, null, null, 'activo', 'administradorMunicipal', null, $correo));

        $id = $this->buscarIdPorCedula();
        $fila = $controller->obtenerPorId($id);

        MiniTest::afirmarIgual($correo, $fila['correoInstaladorMunicipal'] ?? null, "debería guardar el correo institucional tal cual");
        MiniTest::afirmarIgual($this->cedula, $fila['cedulaUsuario'] ?? null, "debería quedar asociado a la cédula correcta");
    }

    public function testModificar()
    {
        $controller = new AdministradorMunicipalController();
        $controller->crear(new AdministradorMunicipal($this->cedula, 'Test', 'Admin', null, null, null, null, null, null, 'activo', 'administradorMunicipal', null, 'viejo@municipio.gub.uy'));

        $id = $this->buscarIdPorCedula();
        $nuevoCorreo = 'nuevo.' . uniqid() . '@municipio.gub.uy';
        $controller->modificar(new AdministradorMunicipal($this->cedula, 'Test', 'Admin', null, null, null, null, null, null, 'activo', 'administradorMunicipal', $id, $nuevoCorreo));

        $fila = $controller->obtenerPorId($id);
        MiniTest::afirmarIgual($nuevoCorreo, $fila['correoInstaladorMunicipal'] ?? null, "el correo institucional debería haber cambiado");
    }

    public function testEliminar()
    {
        $controller = new AdministradorMunicipalController();
        $controller->crear(new AdministradorMunicipal($this->cedula, 'Test', 'Admin', null, null, null, null, null, null, 'activo', 'administradorMunicipal', null, 'borrar@municipio.gub.uy'));

        $id = $this->buscarIdPorCedula();
        MiniTest::afirmar($id > 0, "tiene que haber encontrado el administrador recién creado");

        $controller->eliminar($id);
        MiniTest::afirmarIgual(false, $controller->obtenerPorId($id), "no debería encontrarlo después de borrarlo");
    }
}
