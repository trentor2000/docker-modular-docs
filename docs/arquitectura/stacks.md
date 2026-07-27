# 🧱 **Stacks (docker-compose.yml) — Estándar Oficial Docker Modular**

Los *stacks* representan **unidades funcionales completas**, cada una definida por un archivo `docker-compose.yml` independiente.
Son la base de la arquitectura modular y permiten:

- reproducibilidad

- aislamiento

- escalabilidad

- claridad docente

- administración limpia desde Dockge

# 🎯 **1. Propósito de la carpeta** `/stacks/`

La carpeta:

```bash
/home/usuario/dockerdata/stacks/
```

es el **espacio oficial para todos los stacks** que agrupan servicios relacionados.

Ejemplos:

- stack de infraestructura (traefik, watchtower, headscale)

- stack de devtools (mkdocs, registry, gitea, uptime-kuma)

- stack de IA (ollama + openwebui)

- stack de monitoreo (grafana + prometheus)

Cada stack:

- tiene su propio `docker-compose.yml`

- puede contener múltiples servicios

- se administra como una unidad

- se inicia/detiene desde Dockge

# 🗂️ **2. Estructura estándar de** `/stacks/`

```text
/home/usuario/dockerdata/stacks/
 ├── infraestructura/
 │   └── docker-compose.yml
 │
 ├── devtools/
 │   └── docker-compose.yml
 │
 ├── ia/
 │   └── docker-compose.yml
 │
 ├── monitoreo/
 │   └── docker-compose.yml
 │
 └── redes/
     └── docker-compose.yml
```

Cada carpeta representa **un stack completo**.

# 🧩 **3. Reglas de oro para stacks**

Estas reglas son **obligatorias** para mantener la arquitectura modular:

### ✔ **1. Un stack = un archivo compose**

Nunca mezclar múltiples stacks en un solo archivo.

### ✔ **2. Un stack puede tener múltiples servicios**

Ejemplo: `devtools` → mkdocs + registry + gitea + uptime-kuma

### ✔ **3. Los stacks NO contienen volúmenes absolutos**

Siempre rutas relativas dentro del stack:

```bash
volumes:
  - ./data:/var/lib/gitea
```

### ✔ **4. Los stacks NO viven en** `/opt/`

Ese espacio es **solo infraestructura base**.

### ✔ **5. Los stacks SÍ deben tener política de reinicio**

Recomendado:

```text
restart: unless-stopped
```

### ✔ **6. Los stacks NO deben depender de Dockge**

Dockge administra, no ejecuta.

# 🛠️  **PLANTILLA UNIVERSAL PARA STACKS CON DATOS PERSISTENTES**

## 📁 **Estructura del stack**

```text
~/dockerdata/stacks/<stack>/
 ├── docker-compose.yml
 ├── .env
 └── config/
      ├── servicio1/
      └── servicio2/
```

## 📁 **Estructura de persistencia**

```text
~/dockerdata/data/<stack>/
 ├── servicio1/
 └── servicio2/**
```

Esta plantilla es el estándar que usarás en clase:

```yaml
services:

  servicio1:
    image: <imagen_servicio1>
    container_name: <stack>-servicio1
    restart: unless-stopped
    user: "${PUID}:${PGID}"
    env_file:
      - .env
    volumes:
      # Configuración del stack (borrable)
      - ./config/servicio1:/config
      # Persistencia real (NO borrable)
      - ../../data/<stack>/servicio1:/data
    ports:
      - "PUERTO_HOST:PUERTO_CONTENEDOR"
    networks:
      - red

  servicio2:
    image: <imagen_servicio2>
    container_name: <stack>-servicio2
    restart: unless-stopped
    user: "${PUID}:${PGID}"
    env_file:
      - .env
    depends_on:
      - servicio1
    volumes:
      # Configuración del stack (borrable)
      - ./config/servicio2:/config
      # Persistencia real (NO borrable)
      - ../../data/<stack>/servicio2:/data
    ports:
      - "PUERTO_HOST:PUERTO_CONTENEDOR"
    networks:
      - red

networks:
  red:
    external: false

```

# 📄 **.env (plantilla universal)**

```bash
PUID=1000
PGID=1000
TZ=America/Mexico_City
```

✔ Evita archivos root
✔ Compatible con cualquier contenedor moderno
✔ Portabilidad total

# 🧩 **Reglas oficiales que esta plantilla cumple**

## ✔ `/stacks/<stack>/`

Contiene **solo**:

- `docker-compose.yml`

- `.env`

- `config/`

Todo esto es **borrable** sin riesgo.

## ✔ `/data/<stack>/<servicio>/`

Contiene:

- modelos

- bases vectoriales

- cachés

- datos de usuario

- archivos pesados

Todo esto es **NO borrable** por Dockge.

## ✔ `PUID/PGID`

Evita archivos root y problemas de permisos.

## ✔ Rutas relativas

Garantizan portabilidad y reproducibilidad.

## ✔ Aislamiento modular

Cada stack es autocontenido.

# 🧪 **5. Ejemplo real: Stack ai**

```text
/home/usuario/dockerdata/stacks/ai/docker-compose.yml
```

```yaml
services:

  ollama:
    image: ollama/ollama:latest
    container_name: ai-ollama
    restart: unless-stopped
    user: "${PUID}:${PGID}"
    env_file:
      - .env
    volumes:
      # Configuración del stack (borrable)
      - ./config/ollama:/root/.ollama/config
      # Persistencia real (NO borrable)
      - ../../data/ai/ollama:/root/.ollama/models
    ports:
      - "11434:11434"
    networks:
      - ai_net

  openwebui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: ai-openwebui
    restart: unless-stopped
    user: "${PUID}:${PGID}"
    depends_on:
      - ollama
    env_file:
      - .env
    environment:
      - OLLAMA_API_BASE=http://ollama:11434
      - WEBUI_AUTH=False
      - ENABLE_IMAGE_GENERATION=True
      - ENABLE_WEB_SEARCH=True
      - ENABLE_FILE_TOOLS=True
    volumes:
      # Configuración del stack (borrable)
      - ./config/openwebui:/app/backend/config
      # Persistencia real (NO borrable)
      - ../../data/ai/openwebui:/app/backend/data
    ports:
      - "3000:8080"
    networks:
      - ai_net

networks:
  ai_net:
    external: false

```

# 📄 **3. Archivo** `.env`

```text
PUID=1000
PGID=1000
TZ=America/Mexico_City
```

✔ Evita archivos root
✔ Permite borrar, migrar, respaldar
✔ Compatible con cualquier contenedor moderno

# 🧩 **4. ¿Qué va en cada carpeta?**

## `/stacks/ai/config/ollama`

- Configuración del runtime

- Archivos ligeros

- Logs efímeros

## `/data/ai/ollama`

- Modelos descargados

- Blobs

- Manifests

- Cachés pesadas

## `/stacks/ai/config/openwebui`

- Configuración del backend

- Ajustes de UI

- Preferencias del usuario

## `/data/ai/openwebui`

- vector_db

- embeddings

- uploads

- cachés

# 🧠 **5. Reglas oficiales que esta plantilla cumple**

### ✔ Persistencia real en `/data`

Los modelos y bases vectoriales sobreviven:

- recreaciones

- borrados del stack

- reinstalaciones

- migraciones

### ✔ Configuración en `/config`

Borrable sin riesgo.

### ✔ Stacks autocontenidos

Cada stack vive en su propia carpeta.

### ✔ Nada de root

`user: "${PUID}:${PGID}"` evita archivos root.

### ✔ Rutas relativas

Portabilidad total.

### ✔ Dockge-friendly

Dockge solo ve `/stacks`, nunca `/data`.

# 🚀 6. Cómo levantar Apps y Stacks

### **Apps del usuario (individuales)**

Las apps ubicadas en `/dockerdata/apps/` se levantan desde terminal:



```bash
cd ~/dockerdata/apps/<categoria>/<app>/
docker compose up -d
```

- No aparecen en Dockge.

- No deben administrarse desde Dockge.

- Son servicios aislados.

### **Stacks (sistemas completos)**

Los stacks ubicados en `/dockerdata/stacks/` **deben levantarse desde Dockge**:

1. Abrir Dockge.

2. Ir a **Stacks**.

3. Seleccionar el stack.

4. Presionar **Deploy** o **Start**.

> **Advertencia:** 
> Si levantas un stack con `docker compose up -d`, Dockge no podrá administrarlo.

## ⚠️ Consideraciones al levantar Stacks vs Apps 📊

| Acción                                                           | ¿Rompe estándar?          | ¿Cuándo usarla?                             | ¿Administrable por Dockge? |
| ---------------------------------------------------------------- | ------------------------- | ------------------------------------------- | -------------------------- |
| **Levantar stack desde Dockge**                                  | ❌ No                      | Stacks oficiales en `/stacks/`              | ✔ Sí                       |
| **Levantar app con** `docker compose up -d`                      | ❌ No                      | Apps individuales en `/apps/`               | ✖ No                       |
| **Levantar stack con** `docker compose up -d`                    | 🟥 **Sí, rompe estándar** | Solo si NO quieres que Dockge lo administre | ✖ No                       |
| **Levantar stack desde terminal y luego querer verlo en Dockge** | 🟥 **Error crítico**      | Nunca                                       | ✖ No                       |

### **1. Apps individuales se levantan con** `docker compose up -d`

No se administran desde Dockge.

### **2. Stacks se levantan desde Dockge**

Nunca desde terminal.

### **3. Si levantas un stack desde terminal, Dockge no podrá administrarlo**

Quedará “huérfano”.

### **4. Si una app existe como app y como stack (ej. Ollama), solo una puede estar activa**

Destruye la app antes de levantar el stack.

🧩 **Acción recomendada antes de levantar el stack IA**

Si tienes la app Ollama individual:

```bash
cd ~/dockerdata/apps/ia/ollama
docker compose down
```

Luego sí puedes levantar el stack IA.

# 🧹 **7. Auditoría de stacks**

Puedes verificar que todos los stacks cumplen el estándar ejecutando:

👉 **Ejecutar auditoría modular**

# 🧱 **8. Errores comunes (y cómo evitarlos)**

### ❌ Mezclar apps del usuario dentro de un stack

→ Cada app va en `/apps/`, no en `/stacks/`.

### ❌ Usar rutas absolutas

→ Rompe la reproducibilidad.

### ❌ No usar `restart: unless-stopped`

→ Servicios frágiles ante reinicios.

### ❌ Colocar stacks dentro de `/opt/`

→ Contamina la infraestructura base.
