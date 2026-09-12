<?php
// Corre todos los tests de api-gestion: php tests/run.php

require_once __DIR__ . "/MiniTest.php";
require_once __DIR__ . "/UtilidadesTest.php";
require_once __DIR__ . "/ContenedorControllerTest.php";
require_once __DIR__ . "/IncidenciaControllerTest.php";

session_start();

exit(MiniTest::correr([
    UtilidadesTest::class,
    ContenedorControllerTest::class,
    IncidenciaControllerTest::class,
]));
