#!/bin/bash
# verificacion-integridad.sh

echo "=== Verificación de Integridad de Infraestructura Base ==="
echo "--------------------------------------------------------"

SERVICIOS=(dockge portainer watchtower traefik headscale) 

for servicio in "${SERVICIOS[@]}"; do 
  # Filtramos directamente en la API de Docker buscando coincidencia exacta de nombre
  ESTADO=$(docker ps -q --filter "name=^/${servicio}$")
  
  if [ -n "$ESTADO" ]; then
    echo "  ✔ [ACTIVO]      $servicio está corriendo correctamente."
  else
    echo "  ⚠ [ALERTA]     $servicio NO ESTÁ CORRIENDO O ESTÁ CAÍDO."
  fi
done

echo "--------------------------------------------------------"
echo "Verificación completada."
