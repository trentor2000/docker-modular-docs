# 🛠 Scripts de Infraestructura y Control

### Automatización oficial del entorno Docker Modular

Los scripts son una parte esencial del modelo Docker Modular.
Permiten que cualquier estudiante o docente pueda:

- levantar la infraestructura base

- detenerla

- reconstruirla

- limpiar contenedores y redes

- iniciar servicios base como Portainer, Dockge, Watchtower, Headscale y Traefik

- trabajar con stacks sin riesgo de romper el sistema

Todos los scripts viven en:

```text
/home/usuario/dockerdata/infra/
```

Esta carpeta forma parte del paquete **dockerdata/** que el estudiante descarga y coloca en su `$HOME`.

# 🧱 1. Tipos de scripts

La arquitectura distingue **dos familias de scripts**:

## 🟦 A. Scripts de infraestructura base

Estos scripts levantan los servicios fundamentales del sistema usando `docker run`, no `docker compose`.

Son autocontenidos, reproducibles y no dependen de archivos externos.

Incluyen:

- **dockge.sh**

- **portainer.sh**

- **watchtower.sh**

- **headscale.sh**

- **traefik.sh**

Estos scripts:

- crean los contenedores base

- montan volúmenes en `/opt/<servicio>`

- exponen puertos

- aplican políticas de reinicio

- garantizan que la infraestructura sea **estable y reproducible**

## 🟧 B. Scripts de control del sistema

Estos scripts orquestan la infraestructura base y los stacks del usuario.

Incluyen:

- **infra-up.md**

- **infra-down.md**

- **infra-rebuild.md**

- **infra-status.md**

- **stacks-clean.md**

Estos scripts permiten:

- iniciar toda la infraestructura base

- detenerla

- reconstruirla desde cero

- limpiar contenedores, redes y volúmenes huérfanos

- verificar el estado del sistema

# 🧩 2. Estructura oficial de la carpeta infra



```textile
dockerdata/
 ├── infra/
 │   ├── infra-up.sh
 │   ├── infra-down.sh
 │   ├── infra-rebuild.sh
 │   ├── infra-status.sh
 │   ├── stacks-clean.sh
 │   ├── dockge.sh
 │   ├── portainer.sh
 │   ├── watchtower.sh
 │   ├── headscale.sh
 │   └── traefik.sh

```

Todos los scripts deben tener permisos de ejecución:

```bash
chmod +x ~/dockerdata/infra/*.sh
```

# 🧭 3. Flujo recomendado para estudiantes y docentes

1. **Instalar Docker Engine**
   
   - Zorin/Ubuntu
   
   - WSL2
     (ver anexos)

2. **Descargar la carpeta** `dockerdata/` 
   Colocarla en:
   
   ```text
   /home/usuario/dockerdata/
   ```

3. **Levantar infraestructura base**
   
   ```bash
   cd ~/dockerdata/infra
   ./infra-up.sh
   ```

4. **Trabajar con Dockge y Portainer**

5. **Limpiar si algo falla**
   
   ```bash
   ./stacks-clean.sh
   ```

6. **Reconstruir si todo falla**
   
   ```bash
   ./infra-rebuild.sh
   ```

7. **Detener al terminar**
   
   ```bash
   ./infra-down.sh
   ```

# 🧠 4. Relación entre scripts y arquitectura

| Capa                 | Ubicación             | Método           | Scripts                              |
| -------------------- | --------------------- | ---------------- | ------------------------------------ |
| Infraestructura base | `/opt/<servicio>`     | `docker run`     | `dockge.sh`, `portainer.sh`, etc.    |
| Control del sistema  | `/dockerdata/infra/`  | bash             | `infra-up.sh`, `infra-down.sh`, etc. |
| Stacks del usuario   | `/dockerdata/stacks/` | `docker compose` | gestionados por Dockge               |

# 📦 5. Anexos de instalación (incluidos en dockerdata/anexos/)

- Instalación de Docker Engine en Zorin/Ubuntu

- Instalación de Docker Engine en WSL2

Estos anexos permiten que cualquier estudiante tenga Docker funcionando en **menos de 15 minutos**, sin Docker Desktop y sin enlaces externos.

# 🎯 6. Navegación de esta sección

- **infra-up**

- **infra-down**

- **infra-rebuild**

- **infra-status**

- **stacks-clean**

- **dockge.sh**

- **portainer.sh**

- **watchtower.sh**

- **headscale.sh**

- **traefik.sh**
