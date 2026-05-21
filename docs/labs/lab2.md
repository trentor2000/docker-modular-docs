# 🧪 **Laboratorio Docker — Persistencia de Datos con Volúmenes**

En este laboratorio, el estudiante aprenderá a:

- Crear volúmenes Docker

- Montarlos en contenedores

- Ver cómo persisten los datos aunque el contenedor se elimine

- Usar Docker Compose para persistencia real

- Ver los datos en el sistema de archivos

## 🔧 **Procedimiento paso a paso**

1 Crear un volumen persistente

2 Ejecutar un contenedor usando el volumen

3 Modificar datos dentro del volumen

4 Eliminar el contenedor y verificar persistencia

5 Crear un nuevo contenedor usando el mismo volumen

6 Persistencia con Docker Compose

7 Limpiar el entorno

## Guia del laborario 2

Un volumen es una carpeta administrada por Docker que persiste aunque el contenedor se elimine.

- Ejecuta: `docker volume create labdata`

- Verifica con: `docker volume ls`

- Observa que Docker creó un volumen llamado **labdata**

Montarás el volumen dentro de un contenedor para almacenar datos persistentes.

- Ejecuta: `docker run -d --name lab-nginx -p 8081:80 -v labdata:/usr/share/nginx/html nginx`

- Abre `http://localhost:8081`

- Verifica que el contenedor está corriendo: `docker ps`

Crearás un archivo dentro del volumen para demostrar que persiste.

- Entra al contenedor: `docker exec -it lab-nginx bash`

- Crea un archivo: `echo 'Hola persistencia' > /usr/share/nginx/html/index.html`

- Sal del contenedor: `exit`

- Refresca `http://localhost:8081` y observa el cambio

Comprobarás que los datos siguen existiendo aunque el contenedor desaparezca.

- Elimina el contenedor: `docker rm -f lab-nginx`

- Verifica que el volumen sigue: `docker volume ls`

- Inspecciona el volumen: `docker volume inspect labdata`

El nuevo contenedor reutilizará los datos creados anteriormente.

- Ejecuta: `docker run -d --name lab-nginx2 -p 8082:80 -v labdata:/usr/share/nginx/html nginx`

- Abre `http://localhost:8082`

- Verás el archivo **Hola persistencia** intacto

- 

Ahora usarás un stack para manejar persistencia de forma declarativa.

- Crea carpeta: `mkdir -p ~/dockerdata/stacks/persistencia`

- Crea archivo `docker-compose.yml` con:

```yaml
services:
  web:
    image: nginx
    ports:
      - "8083:80"
    volumes:
      - labdata:/usr/share/nginx/html
volumes:
  labdata:
```

- Despliega desde Dockge o ejecuta: `docker compose up -d`

Dejarás tu entorno listo para el siguiente laboratorio.

- Elimina el stack desde Dockge

- Ejecuta: `docker rm -f lab-nginx2`

- Si deseas borrar el volumen: `docker volume rm labdata`

- Verifica con: `docker volume ls`

# 🎓 **Resultados de aprendizaje**

Al finalizar este laboratorio, el estudiante comprende:

- Qué es un volumen Docker

- Cómo se monta en un contenedor

- Cómo persisten los datos aunque el contenedor se elimine

- Cómo usar volúmenes en Docker Compose

- Cómo inspeccionar y administrar volúmenes
