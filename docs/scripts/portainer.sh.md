# 🟦 `portainer.sh`

### Levanta Portainer CE usando `docker run`

El script `portainer.sh` despliega **Portainer Community Edition**, el panel visual para administrar contenedores, imágenes, redes y volúmenes dentro del modelo Docker Modular.

Portainer es un componente clave porque permite:

- administrar contenedores y stacks

- visualizar logs

- gestionar volúmenes y redes

- revisar el estado del sistema

- trabajar sin depender de la terminal

Este script usa `docker run`, no `docker compose`, para garantizar:

- reproducibilidad

- independencia de archivos externos

- compatibilidad con tu arquitectura educativa

- facilidad de reinstalación

## 🧱 1. Ubicación del script

```bash
/home/usuario/dockerdata/infra/portainer.sh
```

Forma parte del paquete `dockerdata/` que el estudiante coloca en su `$HOME`.

## 🧩 2. ¿Qué hace exactamente `portainer.sh`?

1. Crea el contenedor `portainer`

2. Monta el socket de Docker

3. Monta la carpeta persistente `/opt/portainer`

4. Expone el puerto 9443 (HTTPS)

5. Aplica política de reinicio `unless-stopped`

6. Garantiza que Portainer quede integrado en la infraestructura base

## 🧪 3. Modelo oficial del script

```bash
#!/bin/bash

echo "=== Iniciando Portainer CE ==="

docker run -d \  --name portainer \  --restart unless-stopped \  -p 9443:9443 \  -v /var/run/docker.sock:/var/run/docker.sock \  -v /opt/portainer:/data \  portainer/portainer-ce:latest

echo "=== Portainer iniciado correctamente en https://localhost:9443 ==="
```

### Notas importantes

- `/opt/portainer` contiene usuarios, contraseñas, configuraciones y stacks administrados desde Portainer

- El puerto **9443** es obligatorio porque Portainer CE usa HTTPS por defecto

- No depende de ningún archivo `docker-compose.yml`

- Es totalmente compatible con Dockge y Watchtower

## 🧭 4. Cómo usar este script

### 1. Ir a la carpeta `infra/`

```bash
cd ~/dockerdata/infra
```

### 2. Dar permisos (solo la primera vez)

```bash
chmod +x portainer.sh
```

### 3. Ejecutar

```bash
./portainer.sh
```

### 4. Acceder a Portainer

```text
https://localhost:9443
```

## 🧠 5. ¿Cuándo usar `portainer.sh`?

- Después de ejecutar `infra-up.sh`

- Cuando Portainer no inicia

- Cuando se reconstruye la infraestructura

- Cuando se quiere reinstalar Portainer sin afectar otros servicios

- Cuando un estudiante rompe su instancia de Portainer

## 🧩 6. Relación con otros scripts

| Script            | Función                              |
| ----------------- | ------------------------------------ |
| **dockge.sh**     | Despliega Dockge                     |
| **watchtower.sh** | Despliega Watchtower                 |
| **infra-up**      | Levanta toda la infraestructura base |
| **infra-rebuild** | Reconstruye infraestructura completa |
| **infra-status**  | Verifica estado de servicios         |

## 🎓 7. Uso docente

Para estudiantes:

> “Portainer es tu panel para administrar contenedores y redes. Si no abre, ejecuta este script.”

Para docentes:

> “Permite que los alumnos gestionen contenedores sin depender de comandos.”
