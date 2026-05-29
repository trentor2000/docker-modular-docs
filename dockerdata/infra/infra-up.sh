#!/bin/bash
# infra-up.sh

echo "=== Levantando Infraestructura Base Modular ==="

echo "[1/5] Inicializando Dockge..."
./dockge.sh
sleep 2 # Pausa para asegurar la creación del socket

echo "[2/5] Inicializando Portainer..."
./portainer.sh

echo "[3/5] Inicializando Watchtower..."
./watchtower.sh

echo "[4/5] Inicializando VPN (Headscale)..."
./headscale.sh
sleep 1

echo "[5/5] Inicializando Proxy Perimetral (Traefik)..."
./traefik.sh

echo "=== Verificando estado de los daemons ==="
sleep 2
./verificacion-integridad-infraestructura-base.sh

echo "=== INFRAESTRUCTURA LEVANTADA CORRECTAMENTE ==="
