# 🟦 `infra-up.sh`

### Inicia todos los servicios base del sistema

El script `infra-up.sh` es el encargado de **levantar la infraestructura base** del modelo Docker Modular.
Esta infraestructura incluye los servicios fundamentales que permiten administrar, monitorear y operar el entorno:

- Dockge

- Portainer

- Watchtower

- Headscale

- Traefik

Todos estos servicios se ejecutan mediante **scripts individuales** ubicados en:

```bash
~/dockerdata/infra/
```

Cada uno de esos scripts usa `docker run`, no `docker compose`, para garantizar:

- simplicidad

- reproducibilidad

- independencia de archivos externos

- portabilidad entre máquinas

# 🧱 1. Ubicación del script

```latex
/home/usuario/dockerdata/infra/infra-up.sh
```

Este archivo forma parte del paquete **dockerdata/** que el estudiante descarga y coloca en su `$HOME`.

# 🧩 2. ¿Qué hace exactamente `infra-up.sh`?

1. Muestra un mensaje de inicio.

2. Ejecuta, uno por uno, los scripts que levantan los servicios base:
   
   - `dockge.sh`
   
   - `portainer.sh`
   
   - `watchtower.sh`
   
   - `headscale.sh`
   
   - `traefik.sh`

3. Verifica que los contenedores se hayan creado.

4. Muestra un mensaje de éxito.

# 🧪 3. Ejemplo del contenido del script

Este es el **modelo oficial**:

```bash
#!/bin/bash

echo "=== Levantando infraestructura base Docker Modular ==="

bash "$(dirname "$0")/dockge.sh"
bash "$(dirname "$0")/portainer.sh"
bash "$(dirname "$0")/watchtower.sh"
bash "$(dirname "$0")/headscale.sh"
bash "$(dirname "$0")/traefik.sh"

echo "=== Infraestructura base levantada correctamente ==="
```

### Notas importantes

- `$(dirname "$0")` garantiza que el script funciona **sin importar desde qué carpeta se ejecute**.

- Cada servicio tiene su propio `.sh` autocontenido.

- No se usan rutas absolutas a `/opt`, porque los scripts individuales ya las manejan internamente.

# 🧭 4. Cómo usar este script

### 1. Ir a la carpeta `infra/`

```bash
cd ~/dockerdata/infra
```

### 2. Dar permisos (solo la primera vez)

```bash
chmod +x *.sh
```

### 3. Ejecutar

```bash
./infra-up.sh
```

### 4. Acceder a los servicios

| Servicio          | URL                    |
| ----------------- | ---------------------- |
| Dockge            | http://localhost:5001  |
| Portainer         | https://localhost:9443 |
| Traefik Dashboard | (si está habilitado)   |
| Headscale         | API interna            |
| Watchtower        | sin interfaz           |

# 🧠 5. ¿Cuándo usar `infra-up.sh`?

- Al iniciar el día

- Después de reiniciar la máquina

- Antes de trabajar con stacks

- Después de clonar el repositorio por primera vez

- Cuando un estudiante necesita “levantar todo rápido”

# 🧩 6. Relación con otros scripts

| Script            | Función                               |
| ----------------- | ------------------------------------- |
| **infra-down**    | Detiene toda la infraestructura       |
| **infra-rebuild** | Reconstruye todo desde cero           |
| **infra-status**  | Muestra el estado de los servicios    |
| **stacks-clean**  | Limpia contenedores y redes huérfanas |

# 🎓 7. Uso docente

Para estudiantes:

> “Este es el primer script que debes ejecutar cada vez que vayas a trabajar con Docker Modular.”

Para docentes:

> “Garantiza que todos los alumnos inicien con la misma infraestructura, sin variaciones ni configuraciones manuales.”

Levanta la infraestructura base:

- Dockge
- Portainer
- Watchtower
- etc.
