# 🧪 **Laboratorio Bonus — Stack PRO de IA (Ollama + Open WebUI) + Infraestructura Docker Avanzada**

Este laboratorio enseña a:

- Desplegar un stack de IA local real

- Integrar servicios con redes dedicadas

- Usar volúmenes persistentes para modelos y configuraciones

- Aplicar buenas prácticas de seguridad y aislamiento

- Depurar problemas de infraestructura

- Entender cómo funciona un entorno de IA moderno

# 🧩 **Arquitectura visual del stack de IA**

# 🔧 **Procedimiento técnico paso a paso**

## **1) Preparar el entorno**

Este stack requiere infraestructura estable.

- Ejecuta:
  
  ```bash
  ./infra-up.sh
  ```

- Verifica:
  
  ```bash
  ./infra-status.sh
  ```

- Limpia stacks previos si es necesario:
  
  ```bash
  ./stacks-clean.sh
  ```

## **2) Crear carpeta del stack**

```bash
mkdir -p ~/dockerdata/stacks/ai-pro
cd ~/dockerdata/stacks/ai-pro
```

## **3) Crear redes dedicadas**

Este stack usa dos redes:

- `ai-internal` → comunicación entre Ollama y OpenWebUI

- `ai-proxy` → acceso externo controlado

```yaml
networks:
  ai-internal:
  ai-proxy:
```

## **4) Crear volúmenes persistentes**

- `ollama-data` → modelos descargados

- `openwebui-data` → configuraciones, agentes, historial

```yaml
volumes:
  ollama-data:
  openwebui-data:
```

## **5) Crear el archivo** `docker-compose.yml` **del stack PRO**

Este es el compose completo, listo para Dockge:

```yaml
services:
  ollama:
    image: ollama/ollama:latest
    container_name: ollama
    volumes:
      - ollama-data:/root/.ollama
    networks:
      - ai-internal
    ports:
      - "11434:11434"
    restart: unless-stopped

  openwebui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: openwebui
    depends_on:
      - ollama
    environment:
      - OLLAMA_API_BASE=http://ollama:11434
      - ENABLE_IMAGE_GENERATION=True
      - ENABLE_WEB_SEARCH=True
      - ENABLE_FILE_TOOLS=True
    volumes:
      - openwebui-data:/app/backend/data
    networks:
      - ai-internal
      - ai-proxy
    ports:
      - "3000:8080"
    restart: unless-stopped

networks:
  ai-internal:
  ai-proxy:

volumes:
  ollama-data:
  openwebui-data:
```

## **6) Desplegar desde Dockge**

- Entra a Dockge: `http://localhost:5001`

- Crea stack: **ai-pro**

- Pega el compose

- Haz clic en **Deploy**

## **7) Verificar funcionamiento**

### ✔ Verificar Ollama

```bash
curl http://localhost:11434/api/tags
```

Debe devolver lista de modelos (vacía si es primera vez).

### ✔ Verificar OpenWebUI

Abre:

```TEXT
http://localhost:3000
```

## **8) Descargar un modelo LLM**

Ejemplo:

```bash
docker exec -it ollama ollama pull llama3
```

O uno más ligero:

```bash
docker exec -it ollama ollama pull phi3
```

## **9) Probar inferencia**

Desde terminal:

```bash
curl http://localhost:11434/api/generate -d '{  "model": "phi3",  "prompt": "Hola, ¿qué puedes hacer?"}'
```

Desde OpenWebUI:

- Selecciona modelo

- Escribe un prompt

- Activa herramientas (web search, file tools, python, etc.)

## **10) Activar capacidades agenticas**

En OpenWebUI:

- Settings → Agents

- Activar:
  
  - Tools
  
  - Web Search
  
  - Python Tool
  
  - File Tools
  
  - Document Q&A
  
  - Image Generation

## **11) Buenas prácticas de infraestructura**

### ✔ Aislamiento de redes

Ollama nunca debe exponerse a internet.

### ✔ Persistencia

Los modelos viven en `ollama-data`.

### ✔ Seguridad

No ejecutar contenedores privilegiados.
No montar `/` del host.
No exponer puertos innecesarios.

### ✔ Observabilidad

Usar Portainer para revisar logs y salud.

## **12) Limpieza del laboratorio**

```bash
docker compose down
./stacks-clean.sh
```

# 🎓 **Resultados de aprendizaje**

Al finalizar este laboratorio, el estudiante será capaz de:

- Desplegar un stack de IA local completo

- Integrar Ollama y OpenWebUI

- Usar redes dedicadas para aislamiento

- Implementar persistencia profesional

- Activar capacidades agenticas

- Depurar problemas de infraestructura

- Entender cómo funciona un entorno de IA moderno
