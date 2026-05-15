# 🟧 `infra-rebuild.sh`

### Reconstruye toda la infraestructura base desde cero

El script `infra-rebuild.sh` es el **botón nuclear controlado** del modelo Docker Modular.
Su función es **limpiar y reconstruir** la infraestructura base cuando:

- algo se corrompe

- un contenedor base no inicia

- hay redes o volúmenes huérfanos

- un estudiante rompió su entorno

- se requiere volver al estado inicial limpio

Este script combina:

- detener infraestructura

- limpiar redes y volúmenes

- eliminar contenedores base

- volver a ejecutar los scripts individuales (`dockge.sh`, `portainer.sh`, etc.)

# 🧱 1. Ubicación del script

```bash
/home/usuario/dockerdata/infra/infra-rebuild.sh
```

Forma parte del paquete **dockerdata/** que el estudiante coloca en su `$HOME`.

# 🧩 2. ¿Qué hace exactamente `infra-rebuild.sh`?

1. Detiene todos los contenedores base

2. Elimina contenedores detenidos

3. Limpia volúmenes anónimos

4. Limpia redes huérfanas

5. Ejecuta nuevamente los scripts base:
   
   - `dockge.sh`
   
   - `portainer.sh`
   
   - `watchtower.sh`
   
   - `headscale.sh`
   
   - `traefik.sh`

6. Muestra un mensaje final de éxito

# 🧪 3. Ejemplo del contenido del script

Este es el **modelo oficial**:

```bash
#!/bin/bash

echo "=== RECONSTRUCCIÓN COMPLETA DE INFRAESTRUCTURA ==="

echo "[1/5] Deteniendo contenedores base"
docker stop dockge portainer watchtower headscale traefik 2>/dev/null

echo "[2/5] Eliminando contenedores detenidos"
docker rm dockge portainer watchtower headscale traefik 2>/dev/null

echo "[3/5] Limpiando volúmenes anónimos"
docker volume prune -f

echo "[4/5] Limpiando redes huérfanas"
docker network prune -f

echo "[5/5] Levantando infraestructura limpia"
bash "$(dirname "$0")/dockge.sh"
bash "$(dirname "$0")/portainer.sh"
bash "$(dirname "$0")/watchtower.sh"
bash "$(dirname "$0")/headscale.sh"
bash "$(dirname "$0")/traefik.sh"

echo "=== INFRAESTRUCTURA RECONSTRUIDA CORRECTAMENTE ==="
```

### Notas importantes

- No elimina volúmenes persistentes en `/opt/<servicio>`

- No toca stacks del usuario

- Es seguro ejecutarlo incluso si algunos contenedores no existen

- Garantiza un entorno **limpio, reproducible y estable**

# 🧭 4. Cómo usar este script

### 1. Ir a la carpeta `infra/`

```bash
cd ~/dockerdata/infra
```

### 2. Ejecutar

```bash
./infra-rebuild.sh
```

### 3. Verificar estado

```bash
./infra-status.sh
```

# 🧠 5. ¿Cuándo usar `infra-rebuild.sh`?

- Cuando Dockge no carga

- Cuando Portainer no inicia

- Cuando un contenedor base está corrupto

- Cuando hay errores de redes o puertos

- Cuando un estudiante rompió su entorno

- Cuando se quiere volver al estado inicial limpio

- Antes de iniciar un laboratorio importante

# 🧩 6. Relación con otros scripts

| Script           | Función                         |
| ---------------- | ------------------------------- |
| **infra-up**     | Levanta la infraestructura base |
| **infra-down**   | Detiene la infraestructura      |
| **infra-status** | Muestra el estado               |
| **stacks-clean** | Limpieza profunda de stacks     |

# 🎓 7. Uso docente

Para estudiantes:

> “Si algo se rompe, este script te devuelve a un estado limpio en menos de un minuto.”

Para docentes:

> “Permite reiniciar el entorno de cualquier alumno sin necesidad de reinstalar nada.”
