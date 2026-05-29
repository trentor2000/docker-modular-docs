#!/bin/bash
# infra-status.sh

echo "=================================================="
echo "    ESTADO OPERATIVO DE LA INFRAESTRUCTURA CORE   "
echo "=================================================="

# Usamos la cabecera real de docker ps para no perder contexto
# y filtramos ignorando casos de error.
docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | \
  grep -E "NAMES|dockge|portainer|watchtower|headscale|traefik"

echo "=================================================="
