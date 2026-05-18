# 🚀 **Guía Rápida de Docker (para Estudiantes)**

## 🧱 **1. Conceptos esenciales**

- **Imagen** — plantilla de un contenedor.

- **Contenedor** — instancia en ejecución.

- **Volumen** — carpeta persistente.

- **Red** — comunicación entre contenedores.

- **Compose** — archivo que define un stack.

## 🐳 **2. Comandos básicos**

### Ver contenedores activos

```bash
docker ps
```

### Ver todos los contenedores (incluye detenidos)

```bash
docker ps -a
```

### Descargar una imagen

```bash
docker pull nginx
```

### Ejecutar un contenedor simple

```bash
docker run -d -p 8080:80 nginx
```

### Ver logs

```bash
docker logs nombre_contenedor
```

### Detener un contenedor

```bash
docker stop nombre_contenedor
```

### Eliminar un contenedor

```bash
docker rm nombre_contenedor
```

## 📦 **3. Comandos de imágenes**

### Ver imágenes instaladas

```bash
docker images
```

### Eliminar una imagen

```bash
docker rmi nombre_imagen
```

## 🗂️ **4. Comandos de volúmenes**

### Ver volúmenes

```bash
docker volume ls
```

### Eliminar volúmenes huérfanos

```bash
docker volume prune -f
```

## 🌐 **5. Comandos de redes**

### Ver redes

```bash
docker network ls
```

### Eliminar redes huérfanas

```bash
docker network prune -f
```

## 🧩 **6. Docker Compose (stacks)**

### Levantar un stack

```bash
docker compose up -d
```

### Detener un stack

```bash
docker compose down
```

### Ver logs del stack

```bash
docker compose logs -f
```

## 🧭 **7. Uso correcto en este curso**

### ✔ Crear stacks → **Dockge**

http://localhost:5001

### ✔ Ver contenedores → **Portainer**

http://localhost:9443

### ✔ NO usar:

- `docker run` para apps

- Portainer para crear stacks

- comandos manuales para redes/volúmenes

## 🛠️ **8. Scripts importantes**

### Levantar infraestructura

```bash
./infra-up.sh
```

### Detener infraestructura

```bash
./infra-down.sh
```

### Reconstruir todo desde cero

```bash
./infra-rebuild.sh
```

### Limpiar stacks huérfanos



```bash
./stacks-clean.sh
```

## 🧠 **9. Buenas prácticas**

- Usa Dockge para crear y administrar stacks.

- Guarda tus compose en `/dockerdata/stacks/`.

- No instales nada dentro de contenedores.

- Si algo se rompe → `stacks-clean.sh`.

- Si todo se rompe → `infra-rebuild.sh`.

- Mantén tus compose simples y claros.
