# 🧪 **Manual de Laboratorio Docker (Sesión 1: Infraestructura + Primer Stack)**

## 🔧 **Laboratorio: Preparación del entorno + Primer despliegue**

Este laboratorio consistira en las siguientes acciones :

1 Levantar la infraestructura base

2 Verificar el estado de la infraestructura

3 Crear un nuevo stack desde Dockge

4 Verificar que el stack está funcionando

5 Explorar el contenedor desde Portainer

6 Probar persistencia y reinicios

7 Eliminar el stack de forma segura

8 Restaurar el entorno para el siguiente

## Guia del laboratorio 1:

Activa los servicios esenciales para trabajar con Docker en este curso.

- Abre una terminal en tu máquina.

- Navega a la carpeta `~/dockerdata/infra/`.

- Ejecuta: `./infra-up.sh`.

- Espera a que Dockge, Portainer y Watchtower estén arriba.

Confirma que los servicios base están funcionando correctamente.

- Ejecuta: `./infra-status.sh`.

- Debes ver **dockge**, **portainer** y **watchtower** en estado *Up*.

- Si algo falla, usa `./infra-rebuild.sh`.

Usarás Dockge como compositor oficial para crear tu primera aplicación.

- Entra a Dockge: `http://localhost:5001`.

- Haz clic en **Compose**.

- Crea un stack llamado `web`.

- Pega este compose:

```yaml
services:
  web:
    image: nginx
    ports:
      - "8080:80"
```

- Haz clic en **Deploy**.

Comprueba que el contenedor se creó correctamente.

- Abre tu navegador y visita: `http://localhost:8080`.

- Debes ver la página por defecto de Nginx.

- En Dockge, revisa que el stack `web` esté en estado *Running*.

Aprende a visualizar contenedores sin modificarlos.

- Entra a Portainer: `http://localhost:9443`.

- Ve a **Containers**.

- Ubica el contenedor `web`.

- Observa: logs, puertos, volúmenes, red.

- **No modifiques nada desde Portainer**.

Comprueba que el contenedor se mantiene estable.

- Detén el contenedor desde Dockge.

- Vuelve a iniciarlo.

- Refresca `http://localhost:8080`.

- Observa que la aplicación sigue funcionando.

Aprende a limpiar tu entorno sin afectar la infraestructura.

- En Dockge, selecciona el stack `web`.

- Haz clic en **Delete**.

- Ejecuta en terminal: `./stacks-clean.sh`.

- Verifica con `docker ps -a` que no queden contenedores huérfanos.

Deja tu entorno limpio y listo para la siguiente sesión.

- Ejecuta: `./infra-status.sh`.

- Deben aparecer únicamente: **dockge**, **portainer**, **watchtower**.

- Si algo quedó fuera de lugar, usa: `./infra-rebuild.sh`.

## 🎓 **Objetivos de aprendizaje logrados**

Al finalizar este laboratorio, el estudiante habrá aprendido a:

- Levantar infraestructura Docker de forma reproducible

- Verificar servicios base

- Crear y desplegar un stack usando Dockge

- Visualizar contenedores desde Portainer

- Probar persistencia y reinicios

- Limpiar contenedores y redes huérfanas

- Mantener un entorno ordenado y profesional
