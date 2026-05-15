# 🟩 `infra-status.sh`

### Muestra el estado actual de los servicios base

El script `infra-status.sh` permite verificar rápidamente si la infraestructura base del modelo Docker Modular está:

- levantada

- detenida

- en estado inconsistente

- con contenedores faltantes

Este script es fundamental para estudiantes y docentes, ya que permite diagnosticar el entorno **sin necesidad de abrir Portainer o Dockge**.

# 🧱 1. Ubicación del script

```text
/home/usuario/dockerdata/infra/infra-status.sh
```

Este archivo forma parte del paquete **dockerdata/** que el estudiante descarga y coloca en su `$HOME`.

# 🧩 2. ¿Qué hace exactamente `infra-status.sh`?

1. Muestra un encabezado.

2. Ejecuta `docker ps` filtrando por los contenedores base:
   
   - dockge
   
   - portainer
   
   - watchtower
   
   - headscale
   
   - traefik

3. Indica si cada servicio está:
   
   - **Up** (activo)
   
   - **Exited** (detenido)
   
   - **Missing** (no existe)

4. Muestra un resumen final.

# 🧪 3. Ejemplo del contenido del script

Este es el **modelo oficial**:

```bash
#!/bin/bash

echo "=== Estado de infraestructura base Docker Modular ==="

services=("dockge" "portainer" "watchtower" "headscale" "traefik")

for svc in "${services[@]}"; do
    status=$(docker ps -a --filter "name=$svc" --format "{{.Status}}")    if [ -z "$status" ]; then
        echo "$svc: Missing"
    else
        echo "$svc: $status"
    fi
done

echo "=== Fin del estado ==="
```

### Notas importantes

- No modifica nada: **solo lee información**.

- Funciona incluso si Docker está parcialmente operativo.

- Es seguro ejecutarlo en cualquier momento.

# 🧭 4. Cómo usar este script

### 1. Ir a la carpeta `infra/`

```bash
cd ~/dockerdata/infra
```

### 2. Ejecutar

```bash
./infra-status.sh
```

### 3. Interpretar resultados

Ejemplo:

```bash
dockge: Up 5 minutes
portainer: Up 3 minutes
watchtower: Up 3 minutes
headscale: Exited (0)
traefik: Missing
```

Interpretación:

- **Up** → funcionando correctamente

- **Exited** → detenido, puede levantarse con infra-up

- **Missing** → nunca se ha creado o fue eliminado

# 🧠 5. ¿Cuándo usar `infra-status.sh`?

- Antes de iniciar un laboratorio

- Después de ejecutar `infra-up.sh`

- Si un servicio no responde

- Si Dockge o Portainer no cargan

- Antes de pedir ayuda al docente

- Para verificar que la infraestructura está lista para trabajar

# 🧩 6. Relación con otros scripts

| Script            | Función                               |
| ----------------- | ------------------------------------- |
| **infra-up**      | Levanta la infraestructura base       |
| **infra-down**    | Detiene la infraestructura            |
| **infra-rebuild** | Reconstruye todo desde cero           |
| **stacks-clean**  | Limpia contenedores y redes huérfanas |

# 🎓 7. Uso docente

Para estudiantes:

> “Este script te dice si tu entorno está listo para trabajar. Úsalo antes de iniciar cualquier laboratorio.”

Para docentes:

> “Permite verificar rápidamente si un alumno tiene la infraestructura base levantada sin necesidad de revisar su máquina.”
