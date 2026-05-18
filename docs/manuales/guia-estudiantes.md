# 📘 Manual para Estudiantes — Infraestructura Docker Modular

## 🎯 Objetivo del manual

Este manual te enseña a:

- entender qué es Docker

- usar contenedores sin romper tu sistema

- levantar y destruir infraestructura de forma segura

- administrar servicios usando Dockge

- visualizar contenedores con Portainer

- mantener un entorno limpio y reproducible

- trabajar con **apps individuales** y **stacks completos**

- entender **datos persistentes**, **volúmenes** y **bind mounts**

- ejecutar auditorías básicas de tu entorno

Todo basado en la arquitectura modular del curso: **Infraestructura base → Dockge → Stacks → Apps → Datos persistentes**

# 🧱 1. ¿Qué es Docker?

Docker es una plataforma que permite ejecutar aplicaciones dentro de **contenedores**, que son entornos aislados, ligeros y reproducibles.

Los contenedores:

- no afectan tu sistema

- se pueden borrar sin miedo

- se recrean en segundos

- funcionan igual en cualquier computadora

### Conceptos clave

| Concepto       | Significado                           |
| -------------- | ------------------------------------- |
| **Imagen**     | Plantilla de un contenedor            |
| **Contenedor** | Instancia en ejecución                |
| **Volumen**    | Carpeta persistente                   |
| **Bind mount** | Carpeta del host montada directamente |
| **Red**        | Comunicación entre contenedores       |
| **Compose**    | Archivo que define servicios o stacks |

# 🧩 2. Arquitectura que usarás en este curso

Tu entorno está organizado así:

```text
/opt/                               ← Infraestructura base (NO tocar)
 ├── dockge/
 ├── portainer/
 ├── watchtower/
 ├── headscale/
 └── traefik/

/home/usuario/dockerdata/           ← Zona del estudiante (editable)
 ├── stacks/                        ← Sistemas completos
 │   ├── ia/docker-compose.yml
 │   ├── devtools/docker-compose.yml
 │   └── ...
 ├── apps/                          ← Apps individuales
 │   ├── ia/ollama/
 │   ├── redes/adguard/
 │   └── ...
 └── infra/                         ← Scripts de infraestructura
     ├── infra-up.sh
     ├── infra-down.sh
     ├── infra-rebuild.sh
     ├── stacks-clean.sh
     ├── auditoria-modular.sh
     └── verificacion-integridad.sh

/home/usuario/.docker-storage/      ← Runtime Docker (NO tocar)
/var/lib/containerd/                ← Runtime interno (NO tocar)
```

Esta arquitectura te permite trabajar sin romper nada y reconstruir todo en segundos.

# 🟦 3. Infraestructura base (lo que siempre debe estar arriba)

Servicios esenciales:

- **Dockge** → compositor de stacks

- **Portainer** → visor y panel de control

- **Watchtower** → actualizaciones automáticas

- **Headscale** → VPN (si se usa)

- **Traefik** → reverse proxy (si se usa)

### Levantar infraestructura

bash

```bash
./infra-up.sh
```

### Detener infraestructura

bash

```bash
./infra-down.sh
```

# 🟩 4. Cómo crear tu primer stack

### Paso 1 — Entra a Dockge

```bash
http://localhost:5001
```

### Paso 2 — Crea un nuevo stack

Botón **Compose**

### Paso 3 — Escribe tu docker-compose.yml

yaml

```yaml
services:
  web:
    image: nginx
    ports:
      - "8080:80"
    restart: unless-stopped
```

### Paso 4 — Guarda el archivo en tu carpeta de stacks

```text
/home/usuario/dockerdata/stacks/web/docker-compose.yml
```

### Paso 5 — Despliega desde Dockge

Botón **Deploy**

> ⚠ **Importante:** 
> Los stacks SIEMPRE deben levantarse desde Dockge.
> Si usas `docker compose up -d`, Dockge no podrá administrarlos.

# 🟦 4.1 Cómo levantar Apps del usuario (individuales)

Las apps viven en:

```text
~/dockerdata/apps/<categoria>/<app>/
```

Ejemplos:

- `apps/ia/ollama/`

- `apps/redes/adguard/`

### Para levantarlas:

```bash
cd ~/dockerdata/apps/<categoria>/<app>/
docker compose up -d
```

Características:

- No aparecen en Dockge

- Se administran desde terminal

- Son servicios aislados

# 🧩 4.2 Conflictos entre Apps y Stacks (caso Ollama)

Ollama puede existir como:

- app individual

- parte del stack IA

Pero **no pueden coexistir**.

### ✔ Regla

Si vas a usar el stack IA → **destruye la app Ollama individual**:

bash

```
cd ~/dockerdata/apps/ia/ollama
docker compose down
```

# 🗂️ 5. Datos persistentes

## 5.1 Tipos de persistencia

| Tipo                            | Uso                     | Editable |
| ------------------------------- | ----------------------- | -------- |
| **Volúmenes (rutas relativas)** | Producción, modularidad | ✔ Sí     |
| **Bind mounts**                 | Desarrollo, depuración  | ✔ Sí     |
| **Volúmenes anónimos**          | Nunca                   | ✖ No     |

## 5.2 Reglas de persistencia

### ✔ Regla 1 — Siempre rutas relativas

Correcto:

yaml

```yaml
volumes:
  - ./data:/var/lib/postgresql/data
```

Incorrecto:

yaml

```yaml
volumes:
  - /home/usuario/dockerdata/apps/postgres/data:/var/lib/postgresql/data
```

### ✔ Regla 2 — Cada app/stack tiene su propia carpeta de datos

### ✔ Regla 3 — Nunca usar volúmenes anónimos

### ✔ Regla 4 — Nunca mezclar datos con `/opt/`

# 🧪 6. Auditoría del entorno

### Auditoría Modular

```bash
bash ~/dockerdata/infra/auditoria-modular.sh
```

### Verificación de Integridad

```bash
bash ~/dockerdata/infra/verificacion-integridad.sh
```

# 🧹 7. Cómo limpiar tu entorno si algo sale mal

```bash
./stacks-clean.sh
```

Elimina:

- contenedores huérfanos

- redes rotas

- volúmenes anónimos

Sin tocar la infraestructura base.

# 🟫 8. Cómo reconstruir TODO desde cero



```bash
./infra-rebuild.sh
```

Esto:

1. elimina infraestructura

2. limpia redes y volúmenes

3. la reconstruye limpia

# 🟪 9. Buenas prácticas para estudiantes

- No edites contenedores desde Portainer

- No uses `docker run`

- Usa Dockge para stacks

- Guarda tus compose en `/dockerdata/stacks/`

- Apps → terminal

- Stacks → Dockge

- Si algo se rompe → `stacks-clean.sh`

- Si todo se rompe → `infra-rebuild.sh`

- No instales nada dentro de contenedores

- No modifiques `/opt`

# 🧠 10. Preguntas frecuentes

### ✔ ¿Puedo borrar un contenedor sin miedo?

Sí. Los datos viven en volúmenes.

### ✔ ¿Puedo romper Docker?

Sí, pero puedes reconstruirlo con `infra-rebuild.sh`.

### ✔ ¿Puedo compartir mis stacks con otros estudiantes?

Sí, solo comparte tu carpeta `/dockerdata/stacks/`.

### ✔ ¿Puedo usar esta arquitectura en producción?

Sí, es modular, limpia y mantenible.
