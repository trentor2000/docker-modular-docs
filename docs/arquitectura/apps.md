# 🧱 **Apps del Usuario — Estándar Oficial Docker Modular**

Esta sección define **cómo deben organizarse todas las aplicaciones del usuario** dentro de la infraestructura modular.
Es parte crítica del estándar porque garantiza:

- orden

- reproducibilidad

- claridad docente

- escalabilidad

- facilidad de auditoría

# 🎯 **1. Propósito de la carpeta** `/apps/`

La carpeta:

```bash
/home/usuario/dockerdata/apps/
```

es el **espacio oficial para todas las aplicaciones del usuario**, separadas completamente de:

- infraestructura base (`/opt/`)

- runtime del daemon (`~/.docker-storage`)

- stacks (`/home/usuario/dockerdata/stacks/`)

Esto permite:

- evitar contaminación entre servicios

- mantener backups limpios

- enseñar a los estudiantes una arquitectura profesional

- escalar sin romper nada

# 🗂️ **2. Estructura estándar de** `/apps/`

La estructura recomendada es:

```text
/home/usuario/dockerdata/apps/
 ├── ia/
 │   ├── ollama/
 │   ├── openwebui/
 │   └── whisper/
 │
 ├── redes/
 │   ├── adguard/
 │   ├── tailscale-client/
 │   └── speedtest/
 │
 ├── seguridad/
 │   ├── crowdsec/
 │   ├── vaultwarden/
 │   └── authelia/
 │
 ├── bases-datos/
 │   ├── postgres/
 │   ├── mariadb/
 │   └── redis/
 │
 └── otros/
     ├── filebrowser/
     ├── uptime-kuma/
     └── homer/
```

Cada servicio tiene su propia carpeta con:

```text
docker-compose.yml
.env (opcional)
config/ (opcional)
data/ (si aplica)
```

# 🧩 **3. Categorías oficiales**

Estas categorías son **parte del estándar Docker Modular** y deben mantenerse:

### **📌 IA**

Para modelos, interfaces y herramientas de inferencia.

Ejemplos:

- Ollama

- OpenWebUI

- Whisper

- LM Studio (server)

👉 **Agregar apps IA**

### **📌 Redes**

Servicios que interactúan con DNS, VPN, routing o monitoreo.

Ejemplos:

- AdGuard Home

- Tailscale client

- Speedtest Tracker

👉 **Agregar apps redes**

### **📌 Seguridad**

Servicios que protegen, autentican o monitorean.

Ejemplos:

- CrowdSec

- Authelia

- Vaultwarden

👉 **Agregar apps seguridad**

### **📌 Bases de datos**

Servicios de almacenamiento estructurado o en memoria.

Ejemplos:

- PostgreSQL

- MariaDB

- Redis

👉 **Agregar apps bases de datos**

### **📌 Otros**

Servicios que no encajan en categorías anteriores.

Ejemplos:

- Filebrowser

- Uptime Kuma

- Homer Dashboard

👉 **Agregar apps otros**

# 📊 **Tabla ejecutiva de consideraciones Apps vs Stacks**

| Tema                                  | App Ollama (individual)         | Stack IA (ollama + openwebui) | Consideración       |
| ------------------------------------- | ------------------------------- | ----------------------------- | ------------------- |
| **Propósito**                         | Pruebas, uso aislado            | Sistema completo de IA        | No deben coexistir  |
| **Nombre del contenedor**             | `ollama`                        | `ollama`                      | **Colisión**        |
| **Puerto**                            | `11434`                         | `11434`                       | **Colisión**        |
| **Volúmenes**                         | `./data:/root/.ollama`          | `./ollama:/root/.ollama`      | Puede sobrescribir  |
| **Red**                               | default                         | red del stack                 | No compatible       |
| **Dockge**                            | Se administra sola              | Se administra como grupo      | No mezclar          |
| **Recomendación**                     | Usar solo si no existe stack IA | Usar como solución final      | **Elegir uno**      |
| **Acción antes de levantar stack IA** | `docker compose down`           | —                             | **Debe destruirse** |

# 🛠️ **4. Reglas de oro para apps del usuario**

Estas reglas son obligatorias para mantener la arquitectura modular:

### ✔ **1. Cada app en su propia carpeta**

Nada de mezclar servicios.

### ✔ **2. Cada app tiene su propio docker-compose.yml**

Nunca se mezclan apps en un solo compose.

### ✔ **3. Volúmenes dentro de la carpeta de la app**

Ejemplo:

```bash
volumes:
  - ./data:/var/lib/postgresql/data
```

### ✔ **4. No usar rutas absolutas**

Siempre rutas relativas dentro de la app.

### ✔ **5. No usar puertos fijos si no es necesario**

Evita colisiones.

### ✔ **6. No colocar apps dentro de** `/opt/`

Ese espacio es **solo infraestructura base**.

# 🧪 **5. Ejemplo oficial de app del usuario**

Ejemplo para `ollama`:

```bash
/home/usuario/dockerdata/apps/ia/ollama/
 ├── docker-compose.yml
 └── data/
```

Contenido del compose:

```yaml
services:
  ollama:
    image: ollama/ollama
    container_name: ollama
    volumes:
      - ./data:/root/.ollama
    ports:
      - "11434:11434"
    restart: unless-stopped
```

# 🚀6. Cómo levantar Apps

### **Apps del usuario (individuales)**

Las apps ubicadas en `/dockerdata/apps/` se levantan desde terminal:

bash

```
cd ~/dockerdata/apps/<categoria>/<app>/
docker compose up -d
```

- No aparecen en Dockge.

- No deben administrarse desde Dockge.

- Son servicios aislados.

⚠️ Conflictos entre Apps y Stacks (Ollama como caso real)

Algunas aplicaciones pueden existir como **app individual** o como **parte de un stack**.
El caso más común es **Ollama**.

Solo puede existir **una instancia** de Ollama, porque:

- usa el mismo nombre de contenedor

- usa el mismo puerto (`11434`)

- usa la misma ruta de datos

- Dockge no puede administrar dos instancias del mismo servicio

### ✔ Reglas:

- Si vas a usar **stack IA**, debes **destruir la app Ollama individual**.

- Si solo quieres usar Ollama sin OpenWebUI, usa la app individual.

- **Nunca** deben coexistir.

# 🧹 **7. Auditoría de apps del usuario**

Puedes verificar que todas las apps cumplen el estándar ejecutando:

👉 **Auditoría Modular**

# 🧱 **8. Resultado esperado**

Al completar esta sección, los estudiantes y docentes podrán:

- entender la arquitectura modular

- crear apps sin romper la infraestructura

- mantener orden y reproducibilidad

- auditar fácilmente la estructura

- escalar sin caos
