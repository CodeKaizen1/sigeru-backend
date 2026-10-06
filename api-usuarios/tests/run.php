<?php
// Corre todos los tests de api-usuarios: php tests/run.php
// Necesita una base accesible según Application/Configuration/.env (varios tests
// usan y limpian sus propias filas).

require_once __DIR__ . "/MiniTest.php";
require_once __DIR__ . "/UtilidadesTest.php";
require_once __DIR__ . "/InicioDeSesionControllerTest.php";
require_once __DIR__ . "/IntentoLoginFallidoControllerTest.php";
require_once __DIR__ . "/UsuarioControllerTest.php";
require_once __DIR__ . "/AdministradorMunicipalControllerTest.php";
require_once __DIR__ . "/OperarioDeCuadrillaControllerTest.php";
require_once __DIR__ . "/OperarioDeInstalacionControllerTest.php";
require_once __DIR__ . "/PasswordResetControllerTest.php";
require_once __DIR__ . "/SolicitudDeUsuarioControllerTest.php";

session_start();

exit(MiniTest::correr([
    UtilidadesTest::class,
    InicioDeSesionControllerTest::class,
    IntentoLoginFallidoControllerTest::class,
    UsuarioControllerTest::class,
    AdministradorMunicipalControllerTest::class,
    OperarioDeCuadrillaControllerTest::class,
    OperarioDeInstalacionControllerTest::class,
    PasswordResetControllerTest::class,
    SolicitudDeUsuarioControllerTest::class,
]));
