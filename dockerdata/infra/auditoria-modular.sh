#!/bin/bash
# auditoria-modular.sh

echo "=================================================="
echo " AUDITORÍA DE INTEGRIDAD SISTÉMICA DOCKER MODULAR "
echo "=================================================="

# 1. Validar estructura base
echo -n "[1/8] Estructura Base (/opt): "
if [ -d /opt/dockge ] && [ -d /opt/portainer ]; then
  echo "✔ Infraestructura base detectada correctamente en /opt"
else
  echo "⚠ Faltan carpetas de infraestructura base en /opt"
fi

# 2. Validar zona del usuario
echo -n "[2/8] Zona de Usuario ($HOME/dockerdata): "
if [ -d /home/$USER/dockerdata ]; then
  echo "✔ Zona del usuario encontrada en /home/$USER/dockerdata"
else
  echo "⚠ No se encontró la carpeta dockerdata del usuario"
fi

# 3. Auditoría de Seguridad de Permisos en la Zona del Usuario
echo "[3/8] Escaneando contaminación de permisos (propiedades de root)..."
CONTA=$(find "$HOME/dockerdata" ! -user "$USER" -type f 2>/dev/null | wc -l)
if [ "$CONTA" -eq 0 ]; then
  echo "  ✔ Excelente: Todos los archivos pertenecen a tu usuario escolar."
else
  echo "  ⚠ ALERTA: Se detectaron $CONTA archivos propiedad de ROOT en tu espacio editable."
  echo "    Sugerencia: Ejecuta 'sudo chown -R \$USER:\$USER ~/dockerdata' para reparar."
fi

# 4. Validar runtime Docker
echo -n "[4/8] Runtime Engine (~/.docker-storage): "
if [ -d /home/$USER/.docker-storage ]; then
  echo "✔ Runtime Docker localizado en ~/.docker-storage"
else
  echo "⚠ No se encontró el runtime Docker en ~/.docker-storage"
fi

# 5. Validar containerd
echo -n "[5/8] Runtime Docker Containerd: "
if [ -d /var/lib/containerd ]; then
  echo "✔ Runtime containerd activo en /var/lib/containerd"
else
  echo "⚠ No se encontró containerd en /var/lib/containerd"
fi

# 6. Auditoría de montajes activos
echo -e "\n[6/8]MAPEO DE MONTAJES EN EJECUCIÓN"
#echo -n "[6/8] MAPEO DE MONTAJES EN EJECUCIÓN: "
docker ps --format "table {{.Names}}\t{{.Mounts}}"

# 7. Auditoría de volúmenes huérfanos
echo -e "\n[7/8]INSPECCIÓN DE VOLUMENES HUERFANOS"
#echo -n "[7/8] INSPECCIÓN DE VOLUMENES HUERFANOS: "
docker volume ls -qf dangling=true

# 8. Auditoría de redes
echo -e "\n[8/8]INSPECCIÓN DE REDES VIRTUALES"
#echo -n "[8/8] INSPECCIÓN DE REDES VIRTUALES: "
docker network ls

echo -e "\nAuditoría completada."
