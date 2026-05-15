# 🟥 `infra-down.sh`

### Detiene todos los servicios base del sistema

El script `infra-down.sh` se encarga de **detener la infraestructura base** del modelo Docker Modular.
Esto incluye los contenedores fundamentales que se levantan mediante scripts individuales:

- Dockge

- Portainer

- Watchtower

- Headscale

- Traefik

Detener la infraestructura es una operación segura y necesaria cuando:

- el usuario termina su sesión de trabajo

- se requiere liberar puertos

- se va a modificar algún script base

- se necesita reiniciar el entorno sin reconstruirlo

# 🧱 1. Ubicación del script

```bash
/home/usuario/dockerdata/infra/infra-down.sh
```

Este archivo forma parte del paquete **dockerdata/** que el estudiante descarga y coloca en su `$HOME`.

# 🧩 2. ¿Qué hace exactamente `infra-down.sh`?

1. Muestra un mensaje de inicio.

2. Detiene los contenedores base **por nombre**, sin eliminar volúmenes ni configuraciones.

3. Verifica que los contenedores hayan sido detenidos.

4. Muestra un mensaje de finalización.

# 🧪 3. Ejemplo del contenido del script

Este es el **modelo oficial**:

```bash
#!/bin/bash

echo "=== Deteniendo infraestructura base Docker Modular ==="

docker stop dockge
docker stop portainer
docker stop watchtower
docker stop headscale
docker stop traefik

echo "=== Infraestructura base detenida correctamente ==="
```

### Notas importantes

- No elimina contenedores, solo los detiene.

- No toca volúmenes en `/opt/<servicio>`.

- No afecta stacks del usuario.

- Es seguro ejecutarlo en cualquier momento.

# 🧭 4. Cómo usar este script

### 1. Ir a la carpeta `infra/`

```bash
cd ~/dockerdata/infra
```

### 2. Ejecutar

```bash
./infra-down.sh
```

### 3. Verificar estado (opcional)

```bash
./infra-status.sh
```

# 🧠 5. ¿Cuándo usar `infra-down.sh`?

- Al terminar el día

- Antes de apagar la máquina

- Antes de modificar scripts base

- Cuando un puerto está ocupado

- Cuando se requiere reiniciar la infraestructura sin reconstruirla

# 🧩 6. Relación con otros scripts

| Script            | Función                               |
| ----------------- | ------------------------------------- |
| **infra-up**      | Levanta la infraestructura base       |
| **infra-rebuild** | Reconstruye todo desde cero           |
| **infra-status**  | Muestra el estado de los servicios    |
| **stacks-clean**  | Limpia contenedores y redes huérfanas |

# 🎓 7. Uso docente

Para estudiantes:

> “Este script detiene la infraestructura base sin borrar nada. Úsalo cuando termines tu sesión.”

Para docentes:

> “Permite que los alumnos trabajen con un entorno limpio sin necesidad de reconstruirlo cada vez.”
