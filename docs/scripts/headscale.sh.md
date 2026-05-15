# 🟦 `headscale.sh`

### Despliega Headscale usando `docker run`

El script `headscale.sh` despliega **Headscale**, el *control plane* de código abierto compatible con Tailscale.
En tu arquitectura Docker Modular, Headscale permite:

- gestionar identidades de dispositivos

- crear redes privadas seguras

- administrar nodos sin depender de Tailscale Inc.

- integrar acceso remoto seguro a tu infraestructura

Este script usa `docker run` para garantizar:

- simplicidad

- reproducibilidad

- independencia de archivos externos

- compatibilidad con entornos educativos y de laboratorio

## 🧱 1. Ubicación del script

```text
/home/usuario/dockerdata/infra/headscale.sh
```

Forma parte del paquete `dockerdata/` que el estudiante coloca en su `$HOME`.

## 🧩 2. ¿Qué hace exactamente `headscale.sh`?

1. Crea el contenedor `headscale`

2. Monta la carpeta persistente `/opt/headscale`

3. Expone el puerto 8080 (API)

4. Aplica política de reinicio `unless-stopped`

5. Garantiza que Headscale quede disponible para clientes Tailscale configurados manualmente

## 🧪 3. Modelo oficial del script

```bash
#!/bin/bash

echo "=== Iniciando Headscale ==="

docker run -d \  --name headscale \  --restart unless-stopped \  -p 8080:8080 \  -v /opt/headscale:/var/lib/headscale \  headscale/headscale:latest \  headscale serve

echo "=== Headscale iniciado correctamente en http://localhost:8080 ==="
```

### Notas importantes

- `/opt/headscale` contiene la base de datos SQLite y configuraciones persistentes

- El comando `headscale serve` inicia la API

- No se incluye configuración avanzada (ACLs, DERP, etc.) para mantener simplicidad educativa

- Es totalmente compatible con clientes Tailscale configurados para apuntar a tu servidor Headscale

## 🧭 4. Cómo usar este script

### 1. Ir a la carpeta `infra/`

bash

```bash
cd ~/dockerdata/infra
```

### 2. Dar permisos (solo la primera vez)

bash

```bash
chmod +x headscale.sh
```

### 3. Ejecutar

bash

```bash
./headscale.sh
```

### 4. Verificar que está corriendo

bash

```bash
docker ps | grep headscale
```

## 🧠 5. ¿Cuándo usar `headscale.sh`?

- Después de ejecutar `infra-up.sh`

- Cuando Headscale no inicia

- Cuando se reconstruye la infraestructura

- Cuando un estudiante elimina el contenedor accidentalmente

- Cuando se quiere reinstalar Headscale sin afectar otros servicios

## 🧩 6. Relación con otros scripts

| Script            | Función                              |
| ----------------- | ------------------------------------ |
| **dockge.sh**     | Despliega Dockge                     |
| **portainer.sh**  | Despliega Portainer                  |
| **watchtower.sh** | Despliega Watchtower                 |
| **traefik.sh**    | Despliega Traefik                    |
| **infra-up**      | Levanta toda la infraestructura base |
| **infra-rebuild** | Reconstruye infraestructura completa |

## 🎓 7. Uso docente

Para estudiantes:

> “Headscale te permite conectar tus dispositivos a tu red privada sin depender de Tailscale Inc.”

Para docentes:

> “Permite acceso remoto seguro a la infraestructura sin exponer puertos ni usar VPNs tradicionales.”
