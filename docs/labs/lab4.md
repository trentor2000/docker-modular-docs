# 🧪 **Laboratorio Docker — Traefik como Reverse Proxy para Stacks**

Antes del procedimiento, aquí tienes un **diagrama visual** para ayudarte a entender la arquitectura de Traefik como reverse proxy:

### 1 Preparar la infraestructura base

Inicio

![](https://ts2.mm.bing.net/th?id=OIP.L7RnMNkNH9QjsX0ubu_asgHaDn&pid=15.1&o=7&rm=3)

### 2 Crear la carpeta del stack Traefik

### 3 Definir el docker-compose de Traefik

Clave

![](https://ts1.mm.bing.net/th?id=OIP.oLsUifARBdTFfM3crsltlAHaHa&pid=15.1&o=7&rm=3)

### 4 Desplegar Traefik desde Dockge

### 5 Crear un servicio detrás de Traefik

### 6 Probar el enrutamiento

### 7 Inspeccionar redes y contenedores

### 8 Agregar HTTPS (opcional)

`Avanzado`

### 9 Limpiar el laboratorio

## Guía de laboratorio 4

Traefik requiere que la infraestructura Docker esté activa y estable.

- Ejecuta `./infra-up.sh` para levantar Dockge, Portainer y Watchtower.

- Verifica con `./infra-status.sh` que todo esté en estado **Up**.

- Asegúrate de tener un dominio o subdominio si usarás HTTPS.

Organizar el stack en su propia carpeta facilita la reproducibilidad.

- Crea la carpeta: `mkdir -p ~/dockerdata/stacks/traefik`

- Entra en ella: `cd ~/dockerdata/stacks/traefik`

- Prepara un archivo `docker-compose.yml` vacío.

Traefik se configura mediante labels y acceso al socket Docker.

- Copia este compose dentro de `docker-compose.yml`:

yaml

```
services:
  traefik:
    image: traefik:v2.10
    command:
      - "--providers.docker=true"
      - "--entrypoints.web.address=:80"
    ports:
      - "80:80"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    networks:
      - proxy
networks:
  proxy:
    external: false
```

- Guarda el archivo.

Dockge será el compositor oficial para mantener la arquitectura limpia.

- Entra a Dockge: `http://localhost:5001`.

- Crea un nuevo stack llamado **traefik**.

- Pega el compose.

- Haz clic en **Deploy**.

- Verifica que el contenedor esté en estado *Running*.

Aprenderás a enrutar un servicio usando labels.

- Crea carpeta: `~/dockerdata/stacks/whoami`

- Crea `docker-compose.yml` con:

```yaml
services:
  whoami:
    image: traefik/whoami
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.whoami.rule=Host(\"whoami.localhost\")"
      - "traefik.http.routers.whoami.entrypoints=web"
    networks:
      - proxy
networks:
  proxy:
    external: true
```

- Despliega desde Dockge.

Verificarás que Traefik enruta correctamente según el dominio.

- Abre tu navegador.

- Visita: `http://whoami.localhost`

- Debes ver una respuesta JSON con información del contenedor.

- Si no funciona, revisa logs: `docker logs traefik`.

Comprenderás cómo Traefik detecta servicios mediante Docker.

- Ejecuta: `docker network inspect traefik_proxy`

- Verifica que **traefik** y **whoami** estén conectados.

- En Portainer, revisa las labels del contenedor whoami.

Si tienes dominio real, puedes activar certificados automáticos.

- Agrega a Traefik:

```yaml
- "--certificatesresolvers.myresolver.acme.httpchallenge=true"
- "--certificatesresolvers.myresolver.acme.httpchallenge.entrypoint=web"
- "--certificatesresolvers.myresolver.acme.email=tu-correo"
- "--certificatesresolvers.myresolver.acme.storage=/letsencrypt/acme.json"
```

- Monta volumen: `/letsencrypt:/letsencrypt`

- Usa labels:

```yaml
- "traefik.http.routers.whoami.tls.certresolver=myresolver"
```

Dejarás tu entorno listo para el siguiente laboratorio.

- Elimina el stack whoami desde Dockge.

- Elimina el stack traefik si deseas repetir el laboratorio.

- Ejecuta: `./stacks-clean.sh`.

- Verifica con `docker ps -a` que no queden contenedores huérfanos.

# 🎓 **Resultados de aprendizaje**

Al finalizar este laboratorio, el estudiante comprende:

- Qué es un reverse proxy

- Cómo funciona Traefik como router dinámico

- Cómo usar labels para enrutar servicios

- Cómo conectar servicios a redes proxy

- Cómo probar rutas HTTP y dominios

- Cómo inspeccionar redes y contenedores

- Cómo agregar HTTPS con ACME
