# 📘 Curso de Docker Modular

### Infraestructura contenerizada, reproducible, limpia y profesional para estudiantes y docentes

Bienvenido al sitio oficial del curso **Docker Modular**, una arquitectura diseñada para que cualquier estudiante pueda aprender contenedores sin romper su sistema, sin configuraciones complejas y con un entorno totalmente reproducible.

En este sitio encontraras entre otros documentos:

- Manual para estudiantes y docentes

- Arquitectura completa del entorno

- Scripts de infraestructura

- Stacks y aplicaciones del usuario

- Laboratorios prácticos

- Buenas prácticas y troubleshooting

# 🚀 ¿Qué es Docker Modular?

Docker Modular es una arquitectura educativa que separa claramente:

- **Infraestructura base**

- **Gestión de stacks**

- **Aplicaciones del usuario**

- **Datos persistentes**

- **Scripts reproducibles**

Su objetivo es que los estudiantes puedan:

- levantar y destruir entornos completos en segundos

- trabajar sin miedo a romper nada

- entender Docker desde la práctica

- aprender buenas prácticas desde el día uno

- usar el sistema docker modular en sus proyectos (desarollo web, desarollo seguro de aplicaciones, ciclo de vida del desarollo de aplicaciones, redes e infraestructura, etc.)

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

# 🧱 Arquitectura general

```text
/opt/                                   ← Infraestructura base (root, no editable)
 ├── dockge/
 ├── portainer/
 ├── traefik/
 └── otros servicios de infraestructura del sistema docker

/home/usuario/dockerdata/               ← Zona del usuario (editable)
 ├── stacks/                            ← SOLO docker-compose.yml + config + .env
 │   └── <stack1>/
 │        ├── docker-compose.yml
 │        ├── .env                      
 │        └── config/                   ← Configuración del stack (borrable)
 │
 ├── apps/                              ← Aplicaciones del usuario (no               tocadas por stacks)
 │   └── <categoria>/<app>/             ← Ej: IA, redes, seguridad, bases de datos
 │
 ├── data/                              ← Datos persistentes (NO borrables)
 │   ├── <stack>/<servicio>/            ← Modelos, bases vectoriales, cachés
 │   └── <app>/<datospersistentes>/     
 │
 └── infra/                             ← Scripts de infraestructura
     ├── infra-up.sh
     ├── infra-down.sh
     ├── infra-rebuild.sh
     └── otros_scripts_de_infraestructura.sh

/home/usuario/.docker-storage/          ← Runtime Docker (root)
/var/lib/containerd/                    ← Runtime interno (root)
```

Esta estructura garantiza orden, claridad, reproducibilidad y posibilidad de experimentar sin miedo a romper o tener que estar reinstalando el sistema.



# 🎉 Comienza aquí

👉 **[Manual del Estudiante](https://trentor2000.github.io/docker-modular-docs/manuales/guia-estudiantes/)** 
La mejor forma de iniciar si es tu primera vez con Docker Modular.
