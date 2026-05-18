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

# 🛠️ **4. Plantilla oficial de docker-compose.yml para stacks**

Esta plantilla es el estándar que usarás en clase:

```yaml
version: "3.9" #no necesario ya que el estándar moderno es sin version: porque Docker usa Compose Spec.”

services:
  servicio1:
    image: imagen/servicio1
    container_name: servicio1
    ports:
      - "8080:8080"
    volumes:
      - ./data/servicio1:/data
    environment:
      - TZ=America/Mexico_City
    networks:
      - default
    restart: unless-stopped

  servicio2:
    image: imagen/servicio2
    container_name: servicio2
    volumes:
      - ./data/servicio2:/config
    depends_on:
      - servicio1
    restart: unless-stopped

networks:
  default:
    name: stack-devtools
```

# 🧪 **5. Ejemplo real: Stack DevTools**

```bash
/home/usuario/dockerdata/stacks/devtools/docker-compose.yml
```

```yaml
services:
  mkdocs:
    image: squidfunk/mkdocs-material
    container_name: mkdocs-docs
    volumes:
      - ../../docker-modular-docs:/docs
    ports:
      - "8000:8000"
    restart: unless-stopped

  registry:
    image: registry:2
    container_name: registry
    volumes:
      - ./registry:/var/lib/registry
    ports:
      - "5000:5000"
    restart: unless-stopped

  uptime-kuma:
    image: louislam/uptime-kuma
    container_name: uptime-kuma
    volumes:
      - ./uptime-kuma:/app/data
    ports:
      - "3001:3001"
    restart: unless-stopped
```

# 🚀 6. Cómo levantar Apps y Stacks

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
