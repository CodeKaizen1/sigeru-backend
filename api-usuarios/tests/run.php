<?php
// Corre todos los tests de api-usuarios: php tests/run.php
// Necesita una base accesible según Application/Configuration/.env (los
// tests de InicioDeSesionControllerTest usan y limpian sus propias filas).

require_once __DIR__ . "/MiniTest.php";
require_once __DIR__ . "/UtilidadesTest.php";
require_once __DIR__ . "/InicioDeSesionControllerTest.php";

session_start();

exit(MiniTest::correr([
    UtilidadesTest::class,
    InicioDeSesionControllerTest::class,
]));
