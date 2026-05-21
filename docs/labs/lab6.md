# 🧪 **Laboratorio Final — Arquitectura Multi‑Servicio con Docker, Traefik y Persistencia**

El objetivo es que el estudiante despliegue una arquitectura completa con:

- **Traefik** como reverse proxy

- **Whoami** como servicio de prueba

- **Uptime Kuma** como dashboard de monitoreo

- **Redis** como servicio backend

- **Volúmenes persistentes**

- **Redes aisladas**

- **Buenas prácticas de seguridad**

# 🧩 Procedimiento técnico paso a paso

1. Preparar la infraestructura base

2. Crear la estructura del proyecto final

3. Definir la red proxy y redes internas

4. Configurar Traefik como reverse proxy

5. Agregar servicio Whoami con enrutamiento

6. Agregar Uptime Kuma con persistencia

7. Agregar Redis como backend interno

8. Conectar servicios internos a Red

9. Desplegar el proyecto final

10. Validar funcionamiento del reverse proxy

11. Aplicar medidas básicas de seguridad

12. Limpiar y documentar el proyecto

## Guía de laboratorio final

Asegúrate que el entorno Docker esté limpio y estable antes del despliegue.

- Ejecuta `./infra-up.sh` para levantar Dockge, Portainer y Watchtower.

- Verifica el estado con `./infra-status.sh`.

- Limpia contenedores huérfanos con `./stacks-clean.sh` si es necesario.

Organiza los servicios en carpetas separadas para mantener orden y reproducibilidad.

- Crea la carpeta: `mkdir -p ~/dockerdata/stacks/proyecto-final`.

- Entra en ella: `cd ~/dockerdata/stacks/proyecto-final`.

- Prepara un archivo `docker-compose.yml` vacío.

Las redes permiten aislar servicios y controlar la comunicación entre ellos.

- Define una red `proxy` para Traefik.

- Define una red `backend` para servicios internos.

- Asegura que Traefik solo exponga lo necesario.

Traefik gestionará el enrutamiento HTTP hacia los servicios del proyecto.

- Agrega Traefik al compose con acceso al socket Docker.

- Expón el puerto 80.

- Habilita el provider Docker.

- Conéctalo a la red `proxy`.

Whoami permite validar que Traefik enruta correctamente.

- Crea el servicio `whoami`.

- Conéctalo a la red `proxy`.

- Agrega labels para el router HTTP.

- Usa dominio: `whoami.localhost`.

Uptime Kuma actuará como dashboard de monitoreo del proyecto.

- Crea un volumen `kuma-data`.

- Expón el puerto interno 3001.

- Conéctalo a la red `proxy`.

- Agrega labels para Traefik.

- Monta el volumen en `/app/data`.

Redis se usará como servicio interno no expuesto al exterior.

- Agrega el servicio `redis`.

- Conéctalo solo a la red `backend`.

- No expongas puertos al host.

- Usa imagen oficial `redis:alpine`.

Los servicios que necesiten Redis deben estar en la red backend.

- Agrega `networks: [backend]` a los servicios que lo requieran.

- Verifica conectividad con `docker exec`.

- Usa `ping redis` desde contenedores internos.

Se levanta toda la arquitectura multi-servicio.

- Entra a Dockge: `http://localhost:5001`.

- Crea un stack llamado `proyecto-final`.

- Pega el compose completo.

- Haz clic en **Deploy**.

- Verifica que todos los servicios estén en estado *Running*.

Comprueba que Traefik enruta correctamente hacia cada servicio.

- Abre `http://whoami.localhost`.

- Abre `http://kuma.localhost`.

- Revisa logs de Traefik: `docker logs traefik`.

- Inspecciona redes: `docker network inspect proyecto-final_proxy`.

Se refuerza la seguridad del proyecto final.

- Evita contenedores privilegiados.

- Usa imágenes oficiales.

- Revisa permisos del socket Docker.

- Ejecuta Docker Bench: `docker run docker/docker-bench-security`.

Deja el entorno listo para evaluación o entrega.

- Documenta el compose final.

- Exporta capturas de Dockge.

- Elimina el stack desde Dockge.

- Ejecuta `./stacks-clean.sh`.

- Verifica con `docker ps -a` que no queden contenedores huérfanos.

# 🎓 **Resultados de aprendizaje del Proyecto Final**

El estudiante será capaz de:

- Diseñar una arquitectura multi-servicio real

- Usar Traefik como reverse proxy profesional

- Implementar persistencia con volúmenes

- Crear redes internas y externas

- Integrar servicios backend como Redis

- Desplegar y depurar stacks complejos

- Aplicar medidas básicas de seguridad

- Documentar un proyecto Docker completo
