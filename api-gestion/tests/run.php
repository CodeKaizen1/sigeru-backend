<?php
// Corre todos los tests de api-gestion: php tests/run.php

require_once __DIR__ . "/MiniTest.php";
require_once __DIR__ . "/UtilidadesTest.php";
require_once __DIR__ . "/ContenedorControllerTest.php";
require_once __DIR__ . "/IncidenciaControllerTest.php";
require_once __DIR__ . "/InstalacionControllerTest.php";
require_once __DIR__ . "/CentroDeAcopioControllerTest.php";
require_once __DIR__ . "/PlantaDeProcesamientoControllerTest.php";
require_once __DIR__ . "/VertederoControllerTest.php";
require_once __DIR__ . "/MaquinariaControllerTest.php";
require_once __DIR__ . "/ResiduoControllerTest.php";
require_once __DIR__ . "/TipoResiduoControllerTest.php";

session_start();

exit(MiniTest::correr([
    UtilidadesTest::class,
    ContenedorControllerTest::class,
    IncidenciaControllerTest::class,
    InstalacionControllerTest::class,
    CentroDeAcopioControllerTest::class,
    PlantaDeProcesamientoControllerTest::class,
    VertederoControllerTest::class,
    MaquinariaControllerTest::class,
    ResiduoControllerTest::class,
    TipoResiduoControllerTest::class,
]));
