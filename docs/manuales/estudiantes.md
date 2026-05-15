# 📘 Manual para Estudiantes — Infraestructura Docker Modular

## 🎯 Objetivo del manual

Este manual te enseña a:

- entender qué es Docker

- usar contenedores sin romper tu sistema

- levantar y destruir infraestructura de forma segura

- administrar servicios usando Dockge

- visualizar contenedores con Portainer

- mantener un entorno limpio y reproducible

Todo basado en la arquitectura modular del curso: **Infraestructura base → Dockge → Stacks → Datos persistentes**

# 🧱 1. ¿Qué es Docker?

Docker es una plataforma que permite ejecutar aplicaciones dentro de **contenedores**, que son entornos aislados, ligeros y reproducibles.

Los contenedores:

- no afectan tu sistema

- se pueden borrar sin miedo

- se recrean en segundos

- funcionan igual en cualquier computadora

### Conceptos clave

| Concepto       | Significado                     |
| -------------- | ------------------------------- |
| **Imagen**     | Plantilla de un contenedor      |
| **Contenedor** | Instancia en ejecución          |
| **Volumen**    | Carpeta persistente             |
| **Red**        | Comunicación entre contenedores |
| **Compose**    | Archivo que define un stack     |

# 🧩 2. Arquitectura que usarás en este curso

Tu entorno está organizado así:

text

/opt/                               ← Infraestructura base
 ├── dockge/
 ├── portainer/
 ├── watchtower/
 ├── headscale/
 └── traefik/

 /home/usuario/dockerdata/          ← Datos y stacks
 ├── stacks/
 │   ├── app1/docker-compose.yml
 │   ├── app2/docker-compose.yml
 │   └── ...
 ├── ai/
 ├── redes/
 └── seguridad/

 /home/usuario/dockerdata/infra/    ← Scripts de infraestructura
     ├── infra-up.sh
     ├── infra-down.sh
     ├── infra-rebuild.sh
     └── stacks-clean.sh

/opt/                               ← Infraestructura base
 ├── dockge/
 ├── portainer/
 ├── watchtower/
 ├── headscale/
 └── traefik/

 /home/usuario/dockerdata/          ← Datos y stacks
 ├── stacks/
 │   ├── app1/docker-compose.yml
 │   ├── app2/docker-compose.yml
 │   └── ...
 ├── ai/
 ├── redes/
 └── seguridad/

 /home/usuario/dockerdata/infra/    ← Scripts de infraestructura
     ├── infra-up.sh
     ├── infra-down.sh
     ├── infra-rebuild.sh
     └── stacks-clean.sh

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

```
./infra-up.sh
```

### Detener infraestructura

bash

```
./infra-down.sh
```

# 🟩 4. Cómo crear tu primer stack

### Paso 1 — Entra a Dockge

Código

```
http://localhost:5001
```

### Paso 2 — Crea un nuevo stack

Botón **Compose**

### Paso 3 — Escribe tu docker-compose.yml

yaml

```
services:
  web:
    image: nginx
    ports:
      - "8080:80"
```

### Paso 4 — Guarda el archivo en tu carpeta de stacks

text

```
/home/usuario/dockerdata/stacks/web/docker-compose.yml
```

### Paso 5 — Despliega desde Dockge

Botón **Deploy**

# 🟧 5. Cómo ver tus contenedores

### Opción 1 — Portainer

Código

```
http://localhost:9443
```

Portainer te permite:

- ver contenedores

- ver logs

- ver redes

- ver volúmenes

> ⚠️ **No debes crear stacks desde Portainer.**

### Opción 2 — Terminal

bash

```
docker ps
```

# 🟥 6. Cómo limpiar tu entorno si algo sale mal

Si un stack queda roto, incompleto o huérfano:

bash

```
./stacks-clean.sh
```

Este script elimina:

- contenedores huérfanos

- redes rotas

- volúmenes anónimos

Sin tocar la infraestructura base.

# 🟫 7. Cómo reconstruir TODO desde cero

Si tu entorno queda muy dañado:

bash

```
./infra-rebuild.sh
```

Esto:

1. elimina infraestructura

2. limpia redes y volúmenes

3. la reconstruye limpia

# 🟪 8. Buenas prácticas para estudiantes

- No edites contenedores desde Portainer

- No uses `docker run` para crear apps

- Usa Dockge para crear stacks

- Guarda tus compose en `/dockerdata/stacks/`

- Si algo se rompe → `stacks-clean.sh`

- Si todo se rompe → `infra-rebuild.sh`

- No instales nada dentro de contenedores

- No uses `sudo` dentro de contenedores

- No modifiques `/opt` manualmente

# 🧠 9. Preguntas frecuentes

### ✔ ¿Puedo borrar un contenedor sin miedo?

Sí. Los datos viven en volúmenes.

### ✔ ¿Puedo romper Docker?

Sí, pero puedes reconstruirlo con `infra-rebuild.sh`.

### ✔ ¿Puedo compartir mis stacks con otros estudiantes?

Sí, solo comparte tu carpeta `/dockerdata/stacks/`.

### ✔ ¿Puedo usar esta arquitectura en producción?

Sí, es modular, limpia y mantenible.
