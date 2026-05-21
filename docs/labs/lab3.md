# 🧪 **Laboratorio Docker — Redes y Comunicación entre Contenedores**

Este laboratorio enseña a los estudiantes a:

- Crear redes Docker

- Conectar contenedores a redes personalizadas

- Ver cómo se comunican entre sí

- Aislar servicios en redes separadas

- Usar Docker Compose para definir redes declarativas

# 🌐 **Concepto visual: Redes Docker**

- ![Docker Networking – SYMPLIFY LEARNING](https://ts2.mm.bing.net/th?id=OIP.2zBL3lqh8LDQo8eg7balsQHaE8&pid=15.1&o=7&rm=3)

# 🔧 **Procedimiento paso a paso**

## **1) Crear una red personalizada**

Las redes personalizadas permiten que los contenedores se comuniquen por nombre.

```bash
docker network create labnet
```

Verifica:

```bash
docker network ls
```

## **2) Crear dos contenedores dentro de la misma red**

```bash
docker run -d --name web1 --network labnet nginx
docker run -d --name web2 --network labnet nginx
```

Verifica:

```bash
docker ps
```

## **3) Probar comunicación entre contenedores**

Entra a `web1`:

```bash
docker exec -it web1 bash
```

Prueba ping a `web2`:

```bash
ping web2 -c 3
```

✔ Debe responder.
Esto demuestra que **los contenedores se resuelven por nombre dentro de la misma red**.

## **4) Crear un contenedor en otra red (aislado)**

bash

```bash
docker network create isolated
docker run -d --name web3 --network isolated nginx
```

Prueba comunicación desde `web1`:

```bash
docker exec -it web1 ping web3 -c 3
```

❌ No debe responder.
Esto demuestra **aislamiento entre redes**.

## **5) Conectar un contenedor a dos redes**

Esto permite que un contenedor actúe como “puente”.

```bash
docker network connect isolated web1
```

Ahora prueba desde `web3`:

```bash
docker exec -it web3 ping web1 -c 3
```

✔ Debe responder.

## **6) Desconectar un contenedor de una red**

```bash
docker network disconnect isolated web1
```

Prueba de nuevo:

```bash
docker exec -it web3 ping web1 -c 3
```

❌ Ya no responde.

# 🧩 **7) Redes con Docker Compose**

Crea carpeta:

```bash
mkdir -p ~/dockerdata/stacks/redes
```

Crea `docker-compose.yml`:

```yaml
services:
  app1:
    image: nginx
    networks:
      - frontend

  app2:
    image: nginx
    networks:
      - frontend
      - backend

  db:
    image: redis
    networks:
      - backend

networks:
  frontend:
  backend:
```

Despliega desde Dockge o terminal (recuerda que si habilitas un stack desde terminial no lo podras administrar desde dockge) :

*<mark>ojo</mark>*

```bash
docker compose up -d #inicia un stack desde terminal pero este no sera administrado desde dockge 
```

# 🔍 **8) Verificar topología de red**

### Ver redes creadas:

```bash
docker network ls
```

### Ver contenedores dentro de una red:

```bash
docker network inspect redes_frontend
docker network inspect redes_backend
```

### Comprobación esperada:

- `app1` y `app2` → en **frontend**

- `app2` y `db` → en **backend**

- `app1` ❌ no puede ver `db`

- `app2` ✔ puede ver ambos

# 🧼 **9) Limpieza del laboratorio**

```bash
docker rm -f web1 web2 web3
docker network rm labnet isolated
```

Si usaste Compose:

```bash
docker compose down
```

Y finalmente:

```bash
./stacks-clean.sh
```

# 🎓 **Resultados de aprendizaje**

Al finalizar este laboratorio, el estudiante comprende:

- Cómo funcionan las redes Docker

- Cómo se comunican contenedores por nombre

- Cómo aislar servicios en redes separadas

- Cómo conectar/desconectar contenedores a redes

- Cómo definir redes en Docker Compose

- Cómo inspeccionar topologías de red
