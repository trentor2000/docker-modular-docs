#!/bin/bash

echo "=== RECONSTRUCCIÓN COMPLETA DE INFRAESTRUCTURA ==="

echo "[1/4] Deteniendo y eliminando contenedores"
./infra-down.sh

echo "[2/4] Eliminando volúmenes anónimos"
docker volume prune -f

echo "[3/4] Eliminando redes huérfanas"
docker network prune -f

echo "[4/4] Levantando infraestructura limpia"
./infra-up.sh

echo "=== INFRAESTRUCTURA RECONSTRUIDA CORRECTAMENTE ==="
