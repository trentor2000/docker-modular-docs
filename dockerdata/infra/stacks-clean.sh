#!/bin/bash

echo "=== LIMPIEZA DE STACKS HUÉRFANOS ==="

# 1. Eliminar contenedores no pertenecientes a infraestructura (incluye detenidos)
echo "[1/4] Eliminando contenedores no pertenecientes a infraestructura..."

docker ps -a --format '{{.Names}}' | grep -v -E 'portainer|dockge|watchtower|headscale|traefik' | while read container; do
    echo " - Eliminando contenedor: $container"
    docker rm -f "$container" >/dev/null 2>&1
done

# 2. Eliminar redes huérfanas
echo "[2/4] Eliminando redes huérfanas..."
docker network prune -f >/dev/null 2>&1

# 3. Eliminar volúmenes huérfanos
echo "[3/4] Eliminando volúmenes huérfanos..."
docker volume prune -f >/dev/null 2>&1

# 4. Mostrar estado final
echo "[4/4] Estado final de contenedores:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Ports}}" | grep -E "portainer|dockge|watchtower|headscale|traefik"

echo "=== LIMPIEZA COMPLETA ==="
