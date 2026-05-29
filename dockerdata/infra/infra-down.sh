#!/bin/bash
# infra-down.sh

echo "=== Deteniendo infraestructura base de forma segura ==="

SERVICIOS=(traefik headscale watchtower portainer dockge)

for servicio in "${SERVICIOS[@]}"; do
    if docker ps --format '{{.Names}}' | grep -q "$servicio"; then
        echo " - Deteniendo de forma cortés: $servicio"
        docker stop -t 2 "$servicio" >/dev/null 2>&1
        echo " - Removiendo contenedor: $servicio"
        docker rm "$servicio" >/dev/null 2>&1
    fi
done

echo "=== Infraestructura base totalmente limpia ==="
