# 📘 Curso de Docker Modular

### Infraestructura reproducible, limpia y profesional para estudiantes y docentes

Bienvenido al sitio oficial del curso **Docker Modular**, una arquitectura diseñada para que cualquier estudiante pueda aprender contenedores sin romper su sistema, sin configuraciones complejas y con un entorno totalmente reproducible.

Este sitio contiene:

- Manuales para estudiantes y docentes

- Arquitectura completa del entorno

- Scripts de infraestructura

- Stacks y aplicaciones del usuario

- Laboratorios prácticos

- Buenas prácticas y troubleshooting

# 🚀 ¿Qué es Docker Modular?

Docker Modular es una arquitectura educativa que separa claramente:

- **Infraestructura base**

- **Gestión de stacks (docker-compose.yml)**

- **Aplicaciones del usuario (apps/)**

- **Datos persistentes**

- **Scripts reproducibles**

Su objetivo es que los estudiantes puedan:

- levantar y destruir entornos completos en segundos

- trabajar sin miedo a romper nada

- entender Docker desde la práctica

- aprender buenas prácticas desde el día uno

# 🧱 Arquitectura general

```text
/opt/                                   ← Infraestructura base (root, no editable)
 ├── dockge/
 ├── portainer/
 ├── watchtower/
 ├── headscale/
 ├── traefik/
 └── otros servicios de infraestructura del sistema docker/

/home/usuario/dockerdata/               ← Zona del usuario (editable)
 ├── stacks/                            ← SOLO docker-compose.yml
 │   ├── servicio1/docker-compose.yml
 │   ├── servicio2/docker-compose.yml
 │   └── ...
 │
 ├── apps/                              ← TODAS las aplicaciones del usuario
 │   ├── categoria1/                    ← Ej: IA, redes, seguridad, bases de datos
 │   │   ├── servicioA/
 │   │   └── servicioB/
 │   │
 │   ├── categoria2/
 │   │   ├── servicioC/
 │   │   └── servicioD/
 │   │
 │   └── otros/                         ← Apps futuras del usuario
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

Esta estructura garantiza orden, claridad, reproducibilidad y posibilidad de experimentar sin miedo a romper o tener que estar reinstalando el sistema.

# 🧭 Navegación del curso

## 📘 Manuales

- **Manual del Estudiante**

- **Manual del Docente**

## 🧩 Arquitectura

- **Infraestructura base**

- **Stacks y datos persistentes**

- **Apps del usuario**

- **Scripts reproducibles**

## 🧪 Laboratorios

- **Laboratorio 1: Primer stack**

- **Laboratorio 2: Redes Docker**

- **Laboratorio 3: Persistencia**

## 🛠 Troubleshooting

- **Errores comunes**

- **Cómo limpiar el entorno**

- **Cómo reconstruir todo**

# 🎯 Objetivo del curso

Al finalizar este curso, podrás:

- comprender Docker desde una perspectiva moderna

- crear y administrar stacks profesionales

- usar Dockge como compositor central

- visualizar contenedores con Portainer

- mantener un entorno limpio y estable

- aplicar buenas prácticas de infraestructura

# 🧠 Filosofía del curso

> **Aprender Docker no debe ser difícil.** **Debe ser modular, reproducible y seguro.**

Por eso esta arquitectura:

- evita errores comunes

- separa responsabilidades

- permite reconstruir todo en segundos

- enseña buenas prácticas desde el inicio

# 🎉 Comienza aquí

👉 **Manual del Estudiante** 
La mejor forma de iniciar si es tu primera vez con Docker Modular.
