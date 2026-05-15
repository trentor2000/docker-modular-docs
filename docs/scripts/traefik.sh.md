# 🟦 `traefik.sh`

### Despliega Traefik como reverse proxy usando `docker run`

El script `traefik.sh` despliega **Traefik**, el reverse proxy dinámico que enruta tráfico hacia los stacks del usuario.
En tu arquitectura Docker Modular, Traefik permite:

- enrutar servicios por dominio o subdominio

- manejar certificados HTTPS (ACME/Let’s Encrypt)

- exponer servicios internos de forma segura

- integrar Dockge, Portainer y stacks del usuario bajo un mismo proxy

Este script usa `docker run`, no `docker compose`, para mantener:

- simplicidad

- reproducibilidad

- independencia de archivos externos

- compatibilidad con entornos educativos

## 🧱 1. Ubicación del script

```text
/home/usuario/dockerdata/infra/traefik.sh
```

Forma parte del paquete `dockerdata/` que el estudiante coloca en su `$HOME`.

## 🧩 2. ¿Qué hace exactamente `traefik.sh`?

1. Crea el contenedor `traefik`

2. Habilita el proveedor Docker

3. Expone el puerto 80 (HTTP)

4. Monta el socket Docker

5. Monta la carpeta persistente `/opt/traefik`

6. Aplica política de reinicio `unless-stopped`

7. Deja listo el reverse proxy para enrutar stacks mediante labels

## 🧪 3. Modelo oficial del script

bash

```bash
#!/bin/bash

echo "=== Iniciando Traefik ==="

docker run -d \  --name traefik \  --restart unless-stopped \  -p 80:80 \  -v /var/run/docker.sock:/var/run/docker.sock \  -v /opt/traefik:/etc/traefik \  traefik:v2.10 \  --providers.docker=true \  --providers.docker.exposedbydefault=false \  --entrypoints.web.address=:80

echo "=== Traefik iniciado correctamente en el puerto 80 ==="
```

### Notas importantes

- `/opt/traefik` contiene configuración persistente (ACME, certificados, reglas opcionales)

- `exposedbydefault=false` evita exponer servicios accidentalmente

- Los stacks del usuario deben incluir labels para ser enrutados

- HTTPS puede activarse más adelante agregando ACME (documentado en laboratorios)

## 🧭 4. Cómo usar este script

### 1. Ir a la carpeta `infra/`

bash

```bash
cd ~/dockerdata/infra
```

### 2. Dar permisos (solo la primera vez)

bash

```bash
chmod +x traefik.sh
```

### 3. Ejecutar

bash

```bash
./traefik.sh
```

### 4. Verificar que está corriendo

bash

```bash
docker ps | grep traefik
```

## 🧠 5. ¿Cuándo usar `traefik.sh`?

- Después de ejecutar `infra-up.sh`

- Cuando Traefik no inicia

- Cuando se reconstruye la infraestructura

- Cuando un estudiante elimina el contenedor accidentalmente

- Cuando se quiere reinstalar Traefik sin afectar otros servicios

## 🧩 6. Relación con otros scripts

| Script            | Función                              |
| ----------------- | ------------------------------------ |
| **dockge.sh**     | Despliega Dockge                     |
| **portainer.sh**  | Despliega Portainer                  |
| **watchtower.sh** | Despliega Watchtower                 |
| **headscale.sh**  | Despliega Headscale                  |
| **infra-up**      | Levanta toda la infraestructura base |
| **infra-rebuild** | Reconstruye infraestructura completa |

## 🎓 7. Uso docente

Para estudiantes:

> “Traefik es el reverse proxy que enruta tus servicios. Si no funciona, tus stacks no tendrán dominio.”

Para docentes:

> “Permite enseñar reverse proxy, labels, enrutamiento dinámico y HTTPS de forma práctica.”
