<?php
// Corre todos los tests de api-recoleccion: php tests/run.php

require_once __DIR__ . "/MiniTest.php";
require_once __DIR__ . "/UtilidadesTest.php";
require_once __DIR__ . "/VehiculoControllerTest.php";
require_once __DIR__ . "/RutaControllerTest.php";
require_once __DIR__ . "/CuadrillaControllerTest.php";

session_start();

exit(MiniTest::correr([
    UtilidadesTest::class,
    VehiculoControllerTest::class,
    RutaControllerTest::class,
    CuadrillaControllerTest::class,
]));
