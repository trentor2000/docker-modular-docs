# 📘 Manual para Estudiantes — Infraestructura Docker Modular

## 🎯 Objetivo del manual
Este manual enseña a estudiantes a:

- entender qué es Docker  
- usar contenedores sin romper su sistema  
- levantar y destruir infraestructura de forma segura  
- administrar servicios usando Dockge  
- visualizar contenedores con Portainer  
- mantener un entorno limpio y reproducible  

Todo basado en la arquitectura modular que construimos:  
**Infraestructura base → Dockge → Stacks → Datos persistentes**

---

## 🧱 1. ¿Qué es Docker?

Docker es una plataforma que permite ejecutar aplicaciones dentro de **contenedores**, que son entornos aislados, ligeros y reproducibles.

Los contenedores:

- no afectan tu sistema  
- se pueden borrar sin miedo  
- se pueden recrear en segundos  
- funcionan igual en cualquier computadora  

**Conceptos clave:**

| Concepto | Descripción |
|-----------|-------------|
| Imagen | Plantilla de un contenedor |
| Contenedor | Instancia en ejecución |
| Volumen | Carpeta persistente |
| Red | Comunicación entre contenedores |
| Compose | Archivo que define un stack |

---

## 🧩 2. Arquitectura que usarás en este curso

Tu entorno está organizado así:
/opt/                               ← Infraestructura base (solo tocados por los usuarios root y docker)
├── dockge/
├── portainer/
├── watchtower/
├── headscale/
└── traefik/

/home/tu-usuario/dockerdata/          ← Datos y stacks (propiedad de tu usuario)
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

---

## 🟦 3. Infraestructura base (lo que siempre debe estar arriba)

Servicios esenciales:

- Dockge → compositor de stacks  
- Portainer → visor y panel de control  
- Watchtower → actualizaciones automáticas  
- Headscale → VPN (si se usa)  
- Traefik → reverse proxy (si se usa)  

**Levantar infraestructura:**

```bash
./infra-up.sh

**Detener infraestructura:**

bash
./infra-down.sh

