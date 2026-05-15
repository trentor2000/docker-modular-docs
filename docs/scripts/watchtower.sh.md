# 🟦 `watchtower.sh`

### Despliega Watchtower usando `docker run`

El script `watchtower.sh` despliega **Watchtower**, el servicio encargado de:

- monitorear imágenes de contenedores

- detectar nuevas versiones

- actualizar contenedores automáticamente

- reiniciarlos sin intervención del usuario

En el modelo Docker Modular, Watchtower es parte de la **infraestructura base**, junto con Dockge y Portainer.

Este script usa `docker run` para garantizar:

- simplicidad

- reproducibilidad

- independencia de archivos externos

- compatibilidad con entornos educativos

## 🧱 1. Ubicación del script

```text
/home/usuario/dockerdata/infra/watchtower.sh
```

Forma parte del paquete `dockerdata/` que el estudiante coloca en su `$HOME`.

## 🧩 2. ¿Qué hace exactamente `watchtower.sh`?

1. Crea el contenedor `watchtower`

2. Monta el socket de Docker

3. Aplica política de reinicio `unless-stopped`

4. Configura el intervalo de verificación (por defecto: 5 minutos)

5. Garantiza que Watchtower opere de forma silenciosa y estable

## 🧪 3. Modelo oficial del script

```bash
#!/bin/bash

echo "=== Iniciando Watchtower ==="

docker run -d \  --name watchtower \  --restart unless-stopped \  -v /var/run/docker.sock:/var/run/docker.sock \  containrrr/watchtower:latest \  --interval 300

echo "=== Watchtower iniciado correctamente ==="
```

### Notas importantes

- Watchtower **no tiene interfaz gráfica**

- Opera en segundo plano

- Revisa actualizaciones cada **300 segundos (5 minutos)**

- No toca volúmenes persistentes

- No interfiere con Dockge ni Portainer

## 🧭 4. Cómo usar este script

### 1. Ir a la carpeta `infra/`

```bash
cd ~/dockerdata/infra
```

### 2. Dar permisos (solo la primera vez)

```bash
chmod +x watchtower.sh
```

### 3. Ejecutar

```bash
./watchtower.sh
```

### 4. Verificar que está corriendo



```bash
docker ps | grep watchtower
```

## 🧠 5. ¿Cuándo usar `watchtower.sh`?

- Después de ejecutar `infra-up.sh`

- Cuando Watchtower desaparece por error

- Cuando se reconstruye la infraestructura

- Cuando un estudiante elimina el contenedor accidentalmente

- Cuando se quiere reinstalar Watchtower sin afectar otros servicios

## 🧩 6. Relación con otros scripts

| Script            | Función                              |
| ----------------- | ------------------------------------ |
| **dockge.sh**     | Despliega Dockge                     |
| **portainer.sh**  | Despliega Portainer                  |
| **infra-up**      | Levanta toda la infraestructura base |
| **infra-rebuild** | Reconstruye infraestructura completa |
| **infra-status**  | Verifica estado de servicios         |

## 🎓 7. Uso docente

Para estudiantes:

> “Watchtower mantiene tus contenedores actualizados sin que tengas que hacer nada.”

Para docentes:

> “Evita que los alumnos trabajen con imágenes obsoletas o vulnerables.”
