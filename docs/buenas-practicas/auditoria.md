# Auditoría de Infraestructura Modular Docker

Esta página permite verificar el cumplimiento del estándar modular definido para la infraestructura Docker, asegurando que cada componente esté correctamente ubicado y que los volúmenes y redes se mantengan limpios y optimizados.

🧩 Objetivo

Garantizar que la infraestructura cumpla con la arquitectura modular establecida:

/opt/ → Infraestructura base (no editable)

/home/usuario/dockerdata/ → Zona del usuario (editable)

/home/usuario/.docker-storage/ → Runtime del daemon Docker

/var/lib/containerd/ → Runtime interno (no editable)

🧠 Script de Auditoría Modular

El siguiente script revisa la estructura, los montajes activos y los volúmenes para confirmar el cumplimiento del estándar modular.

```bash
#!/bin/bash
# auditoria-modular.sh

echo "=== Auditoría de Infraestructura Modular Docker ==="

# 1. Validar estructura base
if [ -d /opt/dockge ] && [ -d /opt/portainer ]; then
  echo "✔ Infraestructura base detectada correctamente en /opt"
else
  echo "⚠ Faltan carpetas de infraestructura base en /opt"
fi

# 2. Validar zona del usuario
if [ -d /home/$USER/dockerdata ]; then
  echo "✔ Zona del usuario encontrada en /home/$USER/dockerdata"
else
  echo "⚠ No se encontró la carpeta dockerdata del usuario"
fi

# 3. Validar runtime Docker
if [ -d /home/$USER/.docker-storage ]; then
  echo "✔ Runtime Docker localizado en ~/.docker-storage"
else
  echo "⚠ No se encontró el runtime Docker en ~/.docker-storage"
fi

# 4. Validar containerd
if [ -d /var/lib/containerd ]; then
  echo "✔ Runtime containerd activo en /var/lib/containerd"
else
  echo "⚠ No se encontró containerd en /var/lib/containerd"
fi

# 5. Auditoría de montajes activos
echo "\n=== Montajes activos ==="
docker ps --format "table {{.Names}}\t{{.Mounts}}"

# 6. Auditoría de volúmenes huérfanos
echo "\n=== Volúmenes huérfanos ==="
docker volume ls -qf dangling=true

# 7. Auditoría de redes
echo "\n=== Redes activas ==="
docker network ls

echo "\nAuditoría completada."
```

Guarda este script como auditoria-modular.sh dentro de /home/usuario/dockerdata/infra/ y ejecútalo con:

bash ~/dockerdata/infra/auditoria-modular.sh

## 🧹 Limpieza Automática de Volúmenes y Redes

Para mantener la infraestructura limpia y optimizada, puedes automatizar la limpieza con un cron job:

```bash
#!/bin/bash
# limpieza-automatica.sh

echo "=== Limpieza automática de Docker ==="

docker container prune -f
docker volume prune -f
docker network prune -f

echo "✔ Limpieza completada"
```

Agrega la tarea al cron:

```bash
crontab -e
```

Y añade:

```bash
0 3 * * * /home/usuario/dockerdata/infra/limpieza-automatica.sh >> /home/usuario/dockerdata/infra/limpieza.log 2>&1Esto ejecutará la limpieza cada día a las 3 AM.Esto ejecutará la limpieza cada día a las 3 AM.
```

## 🧱 Verificación de Integridad de la Infraestructura Base

Para confirmar que los servicios esenciales están activos y en sus rutas correctas:

```bash
#!/bin/bash
# verificacion-integridad.sh

echo "=== Verificación de Integridad de Infraestructura Base ==="

SERVICIOS=(dockge portainer watchtower traefik headscale)

for servicio in "${SERVICIOS[@]}"; do
  if docker ps --format '{{.Names}}' | grep -q "$servicio"; then
    echo "✔ $servicio está activo"
  else
    echo "⚠ $servicio no está corriendo"
  fi

done

echo "\nVerificación completada."
```

Guarda este script en /home/usuario/dockerdata/infra/verificacion-integridad.sh y ejecútalo periódicamente.

### ✅ Resultado Esperado

Al ejecutar los tres scripts:

Auditoría Modular: confirma estructura y montajes.

Limpieza Automática: mantiene volúmenes y redes optimizados.

Verificación de Integridad: asegura que los servicios base estén activos.

Con esto, tu infraestructura Docker modular se mantiene limpia, reproducible y conforme al estándar definido en Docker Modular — Documentación Oficial.
