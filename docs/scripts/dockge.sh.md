# 🟦 `dockge.sh`

### Levanta el servicio Dockge usando `docker run`

El script `dockge.sh` es el encargado de desplegar **Dockge**, la interfaz visual para administrar los stacks del usuario dentro del modelo Docker Modular.

Dockge es un componente clave porque permite:

- crear, editar y levantar stacks

- visualizar logs

- administrar contenedores de laboratorio

- trabajar sin necesidad de usar la terminal

Este script usa `docker run`, no `docker compose`, para garantizar:

- simplicidad

- reproducibilidad

- independencia de archivos externos

- compatibilidad con el modelo educativo

## 🧱 1. Ubicación del script

```bash
/home/usuario/dockerdata/infra/dockge.sh
```

Forma parte del paquete `dockerdata/` que el estudiante coloca en su `$HOME`.

## 🧩 2. ¿Qué hace exactamente `dockge.sh`?

1. Crea el contenedor `dockge`

2. Monta el socket de Docker

3. Monta el binario de Docker

4. Monta el Docker Root Dir del usuario

5. Monta la carpeta de datos persistentes en `/opt/dockge`

6. Expone el puerto 5001

7. Aplica política de reinicio `unless-stopped`

## 🧪 3. Modelo oficial del script

```bash
#!/bin/bash

echo "=== Iniciando Dockge ==="

docker run -d \  --name dockge \  --restart unless-stopped \  -p 5001:5001 \  -v /var/run/docker.sock:/var/run/docker.sock \  -v /usr/bin/docker:/usr/bin/docker \  -v /home/usuario/.docker-storage:/home/usuario/.docker-storage \  -v /opt/dockge:/app/data \  louislam/dockge:latest

echo "=== Dockge iniciado correctamente en http://localhost:5001 ==="
```

### Notas importantes

- `/opt/dockge` contiene la configuración persistente

- `.docker-storage` es el Docker Root Dir del usuario

- Dockge requiere acceso directo al binario y al socket de Docker

- No depende de ningún archivo `docker-compose.yml`

## 🧭 4. Cómo usar este script

### 1. Ir a la carpeta `infra/`

```bash
cd ~/dockerdata/infra
```

### 2. Dar permisos (solo la primera vez)

```bash
chmod +x dockge.sh
```

### 3. Ejecutar

```bash
./dockge.sh
```

### 4. Acceder a Dockge

```text
http://localhost:5001
```

## 🧠 5. ¿Cuándo usar `dockge.sh`?

- Despues de ejecutar `infra-up.sh`

- Cuando Dockge no inicia

- Cuando se reconstruye la infraestructura

- Cuando se quiere reinstalar Dockge sin afectar otros servicios

## 🧩 6. Relación con otros scripts

| Script            | Función                              |
| ----------------- | ------------------------------------ |
| **infra-up**      | Levanta toda la infraestructura base |
| **infra-rebuild** | Reconstruye infraestructura completa |
| **infra-status**  | Verifica estado de servicios         |
| **portainer.sh**  | Despliega Portainer                  |
| **watchtower.sh** | Despliega Watchtower                 |

## 🎓 7. Uso docente

Para estudiantes:

> “Dockge es tu panel principal para trabajar con stacks. Si no abre, ejecuta este script.”

Para docentes:

> “Permite que los alumnos gestionen sus laboratorios sin depender de la terminal.”
