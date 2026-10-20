<?php
require_once __DIR__ . "/../Application/Utilidades.php";

// Pruebas de las funciones puras del router (sin sesión ni base de datos).
class UtilidadesTest
{
    public function testValidarCamposObligatoriosSinFaltantes()
    {
        $faltantes = validarCamposObligatorios(['nombreUsuario' => 'Ana', 'apellidoUsuario' => 'Pérez'], ['nombreUsuario', 'apellidoUsuario']);
        MiniTest::afirmarIgual([], $faltantes, "no debería faltar nada");
    }

    public function testValidarCamposObligatoriosConFaltantes()
    {
        $faltantes = validarCamposObligatorios(['nombreUsuario' => 'Ana'], ['nombreUsuario', 'apellidoUsuario']);
        MiniTest::afirmarIgual(['apellidoUsuario'], $faltantes, "apellidoUsuario no vino");
    }

    public function testValidarCamposObligatoriosCampoVacioCuentaComoFaltante()
    {
        $faltantes = validarCamposObligatorios(['nombreUsuario' => ''], ['nombreUsuario']);
        MiniTest::afirmarIgual(['nombreUsuario'], $faltantes, "un string vacío tiene que contar como faltante");
    }

    public function testSoloCambianCamposPermitidosCuandoSoloCambiaLoPermitido()
    {
        $actual = ['emailUsuario' => 'viejo@x.com', 'telefonoUsuario' => '111', 'rolUsuario' => 'administrador'];
        $entrante = ['emailUsuario' => 'nuevo@x.com', 'telefonoUsuario' => '111', 'rolUsuario' => 'administrador'];
        MiniTest::afirmar(soloCambianCamposPermitidos($actual, $entrante, ['emailUsuario']), "solo cambió el email, que está permitido");
    }

    public function testSoloCambianCamposPermitidosFalseCuandoCambiaOtroCampo()
    {
        $actual = ['emailUsuario' => 'viejo@x.com', 'rolUsuario' => 'administrador'];
        $entrante = ['emailUsuario' => 'viejo@x.com', 'rolUsuario' => 'chofer'];
        MiniTest::afirmar(!soloCambianCamposPermitidos($actual, $entrante, ['emailUsuario']), "rolUsuario cambió y no está permitido");
    }

    public function testExigirRolAdministradorSiEscribeNoBloqueaLecturas()
    {
        // GET/OPTIONS nunca deberían llegar a chequear el rol (ni a hacer exit).
        exigirRolAdministradorSiEscribe('GET');
        exigirRolAdministradorSiEscribe('OPTIONS');
        MiniTest::afirmar(true, "no debería haber terminado el proceso");
    }

    public function testExigirRolAdministradorSiEscribeDejaEscribirAlAdministrador()
    {
        $_SESSION['rolUsuario'] = 'administrador';
        exigirRolAdministradorSiEscribe('POST');
        MiniTest::afirmar(true, "el administrador puede escribir, no debería haber cortado");
        unset($_SESSION['rolUsuario']);
    }

    public function testRequisitosContraseniaFaltantesConUnaBuena()
    {
        MiniTest::afirmarIgual([], requisitosContraseniaFaltantes('ClaveBuena123'), "cumple los 3 requisitos, no debería faltar nada");
    }

    public function testRequisitosContraseniaFaltantesMuyCorta()
    {
        MiniTest::afirmarIgual(['al menos 8 caracteres'], requisitosContraseniaFaltantes('Abc12'), "le faltan caracteres, el resto cumple");
    }

    public function testRequisitosContraseniaFaltantesSinNumero()
    {
        MiniTest::afirmarIgual(['al menos un número'], requisitosContraseniaFaltantes('SoloLetras'), "tiene 8+ y letras, pero no números");
    }

    public function testRequisitosContraseniaFaltantesSinLetra()
    {
        MiniTest::afirmarIgual(['al menos una letra'], requisitosContraseniaFaltantes('12345678'), "tiene 8+ y números, pero no letras");
    }

    public function testRequisitosContraseniaFaltantesVacia()
    {
        $faltantes = requisitosContraseniaFaltantes('');
        MiniTest::afirmarIgual(['al menos 8 caracteres', 'al menos una letra', 'al menos un número'], $faltantes, "una contraseña vacía no cumple ninguno de los 3");
    }

    // Ítem crítico #2 de la auditoría de cierre (19/10/2026): solo se pueden probar acá los
    // caminos que NO terminan en exit() (igual que ya pasaba con exigirRolAdministradorSiEscribe
    // más arriba) -- el camino que sí corta con 403 se verificó a mano leyendo el código.

    public function testExigirPermisoDeLecturaPorRecursoNoMiraEscrituras()
    {
        // POST/PUT/DELETE no son de su incumbencia (eso lo cubre exigirRolAdministradorSiEscribe).
        exigirPermisoDeLecturaPorRecurso('inicioDeSesion', 'POST', null);
        MiniTest::afirmar(true, "no debería haber terminado el proceso");
    }

    public function testExigirPermisoDeLecturaPorRecursoDejaAdministradorLeerCualquierCosa()
    {
        $_SESSION['rolUsuario'] = 'administrador';
        exigirPermisoDeLecturaPorRecurso('inicioDeSesion', 'GET', null);
        exigirPermisoDeLecturaPorRecurso('solicitudDeUsuario', 'GET', null);
        exigirPermisoDeLecturaPorRecurso('usuario', 'GET', '99999999');
        MiniTest::afirmar(true, "el administrador puede leer cualquier recurso, no debería haber cortado");
        unset($_SESSION['rolUsuario']);
    }

    public function testExigirPermisoDeLecturaPorRecursoDejaLeerUsuarioListadoYPropio()
    {
        $_SESSION['rolUsuario'] = 'chofer';
        $_SESSION['cedulaUsuario'] = '12345678';
        exigirPermisoDeLecturaPorRecurso('usuario', 'GET', null); // listado completo: lo necesitan los paneles
        exigirPermisoDeLecturaPorRecurso('usuario', 'GET', '12345678'); // su propia fila
        exigirPermisoDeLecturaPorRecurso('operarioDeCuadrilla', 'GET', null); // lo necesitan los paneles
        MiniTest::afirmar(true, "listado completo, la fila propia y operarioDeCuadrilla no deberían cortar");
        unset($_SESSION['rolUsuario'], $_SESSION['cedulaUsuario']);
    }

    public function testFiltrarListadoUsuariosSiNoAdminSacaCamposDeTerceros()
    {
        $_SESSION['rolUsuario'] = 'chofer';
        $_SESSION['cedulaUsuario'] = '11111111';

        $filas = [
            ['cedulaUsuario' => '11111111', 'nombreUsuario' => 'Yo', 'emailUsuario' => 'yo@x.com', 'telefonoUsuario' => '111', 'calleUsuario' => 'Mi calle', 'numeroPuertaUsuario' => '1', 'numeroApartamentoUsuario' => null, 'fechaNacimientoUsuario' => '1990-01-01'],
            ['cedulaUsuario' => '22222222', 'nombreUsuario' => 'Otro', 'emailUsuario' => 'otro@x.com', 'telefonoUsuario' => '222', 'calleUsuario' => 'Otra calle', 'numeroPuertaUsuario' => '2', 'numeroApartamentoUsuario' => null, 'fechaNacimientoUsuario' => '1991-02-02'],
        ];

        $filtradas = filtrarListadoUsuariosSiNoAdmin($filas);

        MiniTest::afirmarIgual('yo@x.com', $filtradas[0]['emailUsuario'], "la fila propia no se filtra");
        MiniTest::afirmar(!array_key_exists('emailUsuario', $filtradas[1]), "emailUsuario de un tercero se saca");
        MiniTest::afirmar(!array_key_exists('telefonoUsuario', $filtradas[1]), "telefonoUsuario de un tercero se saca");
        MiniTest::afirmar(!array_key_exists('calleUsuario', $filtradas[1]), "calleUsuario de un tercero se saca");
        MiniTest::afirmarIgual('Otro', $filtradas[1]['nombreUsuario'], "nombreUsuario de un tercero NO se saca (lo necesitan los paneles)");

        unset($_SESSION['rolUsuario'], $_SESSION['cedulaUsuario']);
    }

    public function testFiltrarListadoUsuariosSiNoAdminNoTocaNadaParaElAdministrador()
    {
        $_SESSION['rolUsuario'] = 'administrador';

        $filas = [['cedulaUsuario' => '22222222', 'emailUsuario' => 'otro@x.com']];
        $filtradas = filtrarListadoUsuariosSiNoAdmin($filas);

        MiniTest::afirmarIgual('otro@x.com', $filtradas[0]['emailUsuario'], "al administrador no se le filtra nada");
        unset($_SESSION['rolUsuario']);
    }
}
