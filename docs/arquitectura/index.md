# 📐 Arquitectura Docker Modular

### Infraestructura limpia, reproducible y diseñada para docencia

La arquitectura Docker Modular organiza el entorno en **capas claras**, separando infraestructura del sistema, aplicaciones del usuario, definiciones de servicios y scripts de automatización.
Este diseño permite:

- reproducibilidad total

- cero conflictos entre servicios

- claridad para estudiantes

- escalabilidad profesional

- mantenimiento sencillo

# 🧱 Principios de diseño

- **Separación total de responsabilidades** `/opt` para infraestructura base, `/dockerdata` para el usuario.

- **Reproducibilidad garantizada** 
  Todo puede reconstruirse con scripts.

- **Modularidad real** 
  Cada servicio vive en su propio espacio.

- **Docencia clara** 
  Los estudiantes saben qué pueden tocar y qué no.

- **Escalabilidad** 
  Puedes agregar categorías y servicios sin romper nada.

# 🗂️ Estructura general (versión simplificada)

```text
/opt/                                   ← Infraestructura base (root, no editable)
 ├── dockge/
 ├── portainer/
 ├── watchtower/
 ├── headscale/
 └── traefik/


/home/usuario/dockerdata/               ← Zona del usuario (editable)
 ├── stacks/                            ← SOLO docker-compose.yml
 │   ├── servicio1/
 │   ├── servicio2/
 │   └── ...
 │
 ├── apps/                              ← TODAS las aplicaciones del usuario
 │   ├── categoria1/
 │   │   ├── servicioA/
 │   │   └── servicioB/
 │   │
 │   ├── categoria2/
 │   │   ├── servicioC/
 │   │   └── servicioD/
 │   │
 │   └── otros/
 │       ├── servicioX/
 │       └── servicioY/
 │
 └── infra/                             ← Scripts de infraestructura
     ├── infra-up.sh
     ├── infra-down.sh
     ├── infra-rebuild.sh
     └── stacks-clean.sh
/home/usuario/.docker-storage/      ← Runtime Docker (root, no editable)
/var/lib/containerd/                ← Runtime interno (root, no editable)
```

# 🧩 Estructura desarrollada (con roles y almacenamiento)

## 🧠 Explicación por capas

## 🟦 1. Infraestructura base — `/opt`

Servicios críticos del sistema:

- Dockge

- Portainer

- Watchtower

- Headscale

- Traefik

**Características:**

- Usuario: root

- No editable por estudiantes

- Configuración mediante bind mounts

- Datos críticos en volúmenes

## 🟩 2. Definición de servicios — `/dockerdata/stacks`

Aquí viven **solo los docker-compose.yml**.

Ventajas:

- Fácil de versionar

- Fácil de compartir

- No contiene datos

- No genera desorden

## 🟧 3. Aplicaciones del usuario — `/dockerdata/apps`

Aquí viven **todas las apps**, organizadas por categorías:

- IA

- Redes

- Seguridad

- Bases de datos

- Otros

Cada servicio tiene su propia carpeta, con:

- Configuración

- Datos persistentes

- Volúmenes

- Logs

## 🟫 4. Scripts de infraestructura — `/dockerdata/infra`

Automatizan todo:

- `infra-up.sh`

- `infra-down.sh`

- `infra-rebuild.sh`

- `stacks-clean.sh`

Permiten:

- reconstruir

- limpiar

- levantar

- detener

Todo sin errores humanos.

# 🧭 Navegación recomendada

- **Manual del Estudiante**

- **Manual del Docente**

- **Scripts de infraestructura**

- **Laboratorios**
