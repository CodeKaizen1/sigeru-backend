#!/bin/bash
# Corre los 3 suites de tests (api-usuarios, api-gestion, api-recoleccion)
# uno por uno, en procesos de PHP separados (cada API declara las mismas
# funciones globales en Utilidades.php, así que no pueden convivir en un
# mismo proceso). Necesita las 3 bases .env apuntando a una base con el
# esquema de 01_code.sql ya cargado.

set -e
cd "$(dirname "$0")"

FALLARON=0

for api in api-usuarios api-gestion api-recoleccion; do
    echo "=== $api ==="
    if ! (cd "$api" && php tests/run.php); then
        FALLARON=1
    fi
    echo
done

if [ "$FALLARON" -eq 0 ]; then
    echo "TODO OK"
else
    echo "HUBO FALLOS"
fi
exit $FALLARON
