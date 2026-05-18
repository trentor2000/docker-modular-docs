# # 🧱 Datos Persistentes — Estándar Oficial Docker Modular

La persistencia es uno de los pilares de la arquitectura modular.
Define **dónde vive la información**, **qué se puede borrar**, **qué se debe respaldar** y **qué nunca debe tocarse**.

# 🎯 1. Objetivo de la persistencia en Docker Modular

Garantizar que:

- los datos del usuario estén **separados** de la infraestructura

- los volúmenes sean **predecibles y auditables**

- los contenedores puedan **reconstruirse sin pérdida de datos**

- los estudiantes entiendan **qué se puede borrar y qué no**

# 🗂️ 2. Estructura oficial de persistencia

Código

```
/opt/                         → Infraestructura base (NO editable)
/home/usuario/dockerdata/     → Datos del usuario (editable)
/home/usuario/.docker-storage/ → Runtime del daemon Docker
/var/lib/containerd/          → Runtime interno (NO editable)
```

# 🧩 3. Tipos de persistencia

## **A. Persistencia del usuario (editable)**

Ubicación:

```bash
/home/usuario/dockerdata/
```

Aquí viven:

- apps del usuario

- stacks

- volúmenes montados

- configuraciones

- bases de datos

- archivos de servicios

Todo lo que el usuario crea o modifica **vive aquí**.

👉 **Ver apps del usuario** 
👉 **Ver stacks**

## **B. Persistencia del daemon Docker (NO editable)**

Ubicación:

```bash
/home/usuario/.docker-storage/
```

Contiene:

- capas de imágenes

- metadatos

- runtime del daemon

Nunca se debe modificar manualmente.

## **C. Persistencia interna de containerd (NO editable)**

Ubicación:

```bash
/var/lib/containerd/
```

Contiene:

- snapshots

- metadata

- runtime interno

Solo Docker debe tocarlo.

# 🛠️ 4. Cómo deben declararse los volúmenes

### ✔ Regla 1 — Siempre rutas relativas dentro de la app o stack

Ejemplo correcto:

yaml

```yaml
volumes:
  - ./data:/var/lib/postgresql/data
```

Ejemplo incorrecto:

yaml

```yaml
volumes:
  - /home/usuario/dockerdata/apps/postgres/data:/var/lib/postgresql/data
```

### ✔ Regla 2 — Cada servicio tiene su propia carpeta de datos

Ejemplo:

```text
apps/ia/ollama/data/
apps/redes/adguard/data/
stacks/devtools/registry/
```

### ✔ Regla 3 — Nunca usar volúmenes anónimos

Incorrecto:

yaml

```yaml
volumes:
  - /var/lib/postgresql/data
```

Esto genera volúmenes huérfanos.

### ✔ Regla 4 — Nunca mezclar datos del usuario con `/opt/`

`/opt/` es solo infraestructura base.

# 🧪 5. Auditoría de persistencia

👉 **Ejecutar auditoría modular**

# 🧹 6. Limpieza de volúmenes y redes

Puedes automatizar limpieza con:

👉 **Limpieza automática**

# 🧱 7. Verificación de integridad

Para confirmar que la infraestructura base está activa:

👉 **Verificación de integridad**

# 🔗8.  Bind Mounts en Docker Modular

Un **bind mount** es un tipo de persistencia donde Docker monta una carpeta del host directamente dentro del contenedor.

Ejemplo:

yaml

```yaml
volumes:
  - /home/usuario/dockerdata/apps/ollama/data:/root/.ollama
```

### ✔ Ventajas

- Acceso directo a archivos del host

- Útil para desarrollo o depuración

- Permite editar archivos sin reconstruir contenedores

### ❌ Desventajas

- No es portable

- No es reproducible

- Depende de rutas absolutas

- Puede romperse si el usuario mueve carpetas

- No funciona bien en entornos multiusuario o multi-host

## 🎯 Uso recomendado en Docker Modular

En Docker Modular:

> **Los bind mounts solo deben usarse dentro de** `/dockerdata/apps/` **o** `/dockerdata/stacks/`**, y siempre con rutas relativas.**

Ejemplo correcto:

yaml

```yaml
volumes:
  - ./data:/root/.ollama
```

Ejemplo incorrecto:

yaml

```yaml
volumes:
  - /home/usuario/dockerdata/apps/ollama/data:/root/.ollama
```

## 🧱 ¿Por qué evitar rutas absolutas?

Porque rompen:

- la reproducibilidad

- la portabilidad

- la auditoría

- la modularidad

Y hacen imposible:

- mover apps

- copiar stacks

- compartir configuraciones

- enseñar buenas prácticas

## 🧩 ¿Cuándo usar volúmenes vs bind mounts?

| Tipo                        | Uso recomendado                        | Ventajas               | Desventajas              |
| --------------------------- | -------------------------------------- | ---------------------- | ------------------------ |
| **Bind mount**              | Desarrollo, depuración, acceso directo | Editable desde host    | No portable              |
| **Volumen (ruta relativa)** | Producción, modularidad, enseñanza     | Reproducible, portable | No editable desde host   |
| **Volumen anónimo**         | Nunca                                  | Ninguna                | Huérfanos, no auditables |

# 📊 9. Tabla ejecutiva de persistencia

| Componente           | Ubicación                | Editable | Responsable | Acción                   |
| -------------------- | ------------------------ | -------- | ----------- | ------------------------ |
| Apps                 | `/dockerdata/apps/`      | ✔ Sí     | Usuario     | Crear, borrar, modificar |
| Stacks               | `/dockerdata/stacks/`    | ✔ Sí     | Usuario     | Administrar desde Dockge |
| Datos de servicios   | Dentro de cada app/stack | ✔ Sí     | Usuario     | Respaldar                |
| Docker runtime       | `~/.docker-storage/`     | ✖ No     | Docker      | No tocar                 |
| Containerd runtime   | `/var/lib/containerd/`   | ✖ No     | Docker      | No tocar                 |
| Infraestructura base | `/opt/`                  | ✖ No     | Sistema     | No modificar             |


