# 📘 Guía Docente — Docker Modular

**Para cursos universitarios, bootcamps y formación ejecutiva**

# 🎯 Propósito de la guía

Esta guía permite a cualquier docente enseñar Docker de forma:

- estructurada

- modular

- reproducible

- alineada con buenas prácticas reales

- sin ambigüedades técnicas

- con una arquitectura estable y segura

El objetivo es que los estudiantes aprendan **contenedores, infraestructura y buenas prácticas**, sin “pelear con Docker”.

# 🧱 1. Marco conceptual para docentes

## ✔ ¿Qué es Docker?

Docker es una plataforma para ejecutar aplicaciones en **contenedores**, que son entornos:

- aislados

- portables

- reproducibles

- fáciles de destruir y recrear

Conceptos clave:

| Concepto       | Significado                           |
| -------------- | ------------------------------------- |
| **Imagen**     | Plantilla de un contenedor            |
| **Contenedor** | Instancia en ejecución                |
| **Volumen**    | Datos persistentes                    |
| **Bind mount** | Carpeta del host montada directamente |
| **Red**        | Comunicación entre contenedores       |
| **Compose**    | Definición declarativa de servicios   |

## ✔ Enfoque pedagógico recomendado

1. Primero **conceptos**, luego comandos.

2. Primero **contenedores simples**, luego stacks.

3. Primero **infraestructura estable**, luego aplicaciones.

4. Primero **reproducibilidad**, luego personalización.

5. Primero **modularidad**, luego automatización.

👉 **Flujo pedagógico modular**

# 🧩 2. Arquitectura docente recomendada

Esta arquitectura evita el caos típico de cursos Docker:

Código

```
Infraestructura base (Dockge, Portainer, Watchtower)
        ↓
Composición de stacks (Dockge)
        ↓
Apps individuales (terminal)
        ↓
Datos persistentes (dockerdata/)
        ↓
Scripts reproducibles (infra/)
```

## ✔ Beneficios pedagógicos

- Los estudiantes **no rompen el sistema**.

- Los stacks se pueden **recrear en segundos**.

- El docente puede **resetear todo el grupo fácilmente**.

- La infraestructura es **idéntica para todos**.

- Se evita el uso incorrecto de `docker run`.

- Se enseña **arquitectura real**, no solo comandos.

👉 **Arquitectura completa**

# 🟦 3. Infraestructura base para el curso

El docente debe preparar:

- **Dockge** → compositor oficial de stacks

- **Portainer** → visor y auditor

- **Watchtower** → actualizaciones automáticas

- **Headscale** (opcional) → VPN

- **Traefik** (opcional) → reverse proxy

## ✔ Scripts que el docente entrega a los estudiantes

- `infra-up.sh` → levanta infraestructura

- `infra-down.sh` → la detiene

- `infra-rebuild.sh` → reconstruye todo

- `stacks-clean.sh` → limpia stacks huérfanos

- `auditoria-modular.sh` → valida estructura

- `verificacion-integridad.sh` → valida servicios base

👉 **Auditoría modular**

Esto garantiza **reproducibilidad total**.

# 🟩 4. Flujo docente para enseñar Docker

## **Fase 1 — Introducción conceptual**

- Qué es un contenedor

- Qué es una imagen

- Qué es un volumen

- Qué es una red

- Qué es un stack

👉 **Crear primer contenedor**

## **Fase 2 — Primeros contenedores**

- `docker pull`

- `docker run` (solo demostración docente)

- `docker ps`

- `docker logs`

## **Fase 3 — Introducción a Dockge**

- Crear un stack simple

- Editar un compose

- Ver logs

- Detener y reiniciar servicios

👉 **Crear stack web**

## **Fase 4 — Persistencia**

- Volúmenes

- Bind mounts

- Carpetas de datos

- Auditoría de persistencia

👉 **Identificar volúmenes**

## **Fase 5 — Apps vs Stacks**

- Apps → terminal

- Stacks → Dockge

- Conflictos (ej. Ollama)

- Reglas de modularidad

👉 **Comparar app vs stack**

## **Fase 6 — Auditoría y limpieza**

- Auditoría modular

- Verificación de integridad

- Limpieza de redes y volúmenes

👉 **Limpiar entorno roto**

## **Fase 7 — Proyecto final**

- Crear un stack completo

- Documentar arquitectura

- Exponer servicios

- Presentar despliegue

👉 **Proyecto final**

# 🧪 5. Laboratorios del curso (solo títulos + propósito)

## **Laboratorio 1 — Infraestructura + Primer Stack**

Levantar infraestructura, crear primer stack, validar persistencia.

## **Laboratorio 2 — Persistencia + Volúmenes**

Trabajar con rutas relativas, carpetas de datos y auditoría.

## **Laboratorio 3 — Redes + Comunicación entre Contenedores**

Crear redes dedicadas y conectar servicios.

## **Laboratorio 4 — Reverse Proxy con Traefik**

Exponer servicios de forma segura.

## **Laboratorio 5 — Seguridad y Auditoría del Host**

Buenas prácticas, auditoría modular, verificación de integridad.

## **Laboratorio 6 — Proyecto Final (Stack Completo)**

Diseñar, documentar y desplegar un stack real.

## **Laboratorio 7 — Bonus PRO: Stack IA (Ollama + Open WebUI)**

Entorno profesional de IA local con redes, persistencia y seguridad.

# 🟧 6. Actividades prácticas recomendadas

- **Hola Docker** → primer contenedor

- **Mi primer stack** → Nginx + Redis

- **Persistencia real** → volúmenes

- **Logs y debugging** → errores comunes

- **Proyecto final** → stack completo

👉 **Crear app individual**

# 🟥 7. Errores comunes que debes evitar como docente

- Permitir que los estudiantes usen `docker run` para apps

- Permitir que creen stacks desde Portainer

- No enseñar persistencia desde el inicio

- No enseñar limpieza de redes y volúmenes

- No enseñar reproducibilidad

- No separar infraestructura de stacks

- No explicar apps vs stacks

- No explicar conflictos (ej. Ollama)

# 🟫 8. Evaluación recomendada

## ✔ Evaluación formativa

- Preguntas rápidas

- Mini ejercicios

- Validación de compose

## ✔ Evaluación sumativa

- Proyecto final con stack completo

- Documentación técnica

- Demostración en vivo

- Exportación del compose

# 🟪 9. Rúbrica sugerida (0–100)

| Área                 | Peso |
| -------------------- | ---- |
| Arquitectura         | 20%  |
| Infraestructura      | 20%  |
| Stacks               | 20%  |
| Apps                 | 15%  |
| Persistencia         | 15%  |
| Auditoría y limpieza | 10%  |
