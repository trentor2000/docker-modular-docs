# 🛡️ **Laboratorio Docker — Seguridad y Auditoría del Host**

Este laboratorio cubre:

- Auditoría del host Docker

- Revisión de permisos y usuarios

- Validación del aislamiento de contenedores

- Ejecución de *Docker Bench for Security*

- Corrección de hallazgos comunes

- Buenas prácticas de seguridad

# 🧩 **Concepto visual: Seguridad en Docker**

### 1 Preparar el entorno de auditoría

Inicio

![](https://ts1.mm.bing.net/th?id=OIP.NlkpC7lCweFxNr_H4OTSRwHaEK&pid=15.1&o=7&rm=3)

### 2 Ejecutar Docker Bench for Security

Recomendado

![](https://ts4.mm.bing.net/th?id=OIP.touDzWCkRzx2mhkXRcw_YgHaE9&pid=15.1&o=7&rm=3)

### 3 Revisar permisos y usuarios

Seguridad

![](https://ts2.mm.bing.net/th?id=OIP.3M8Okv72hfBsYUk98kHpTAHaDt&pid=15.1&o=7&rm=3)

### 4 Validar aislamiento de contenedores

### 5 Corregir hallazgos comunes

### 6 Repetir auditoría y validar mejoras

## Guía de laboratorio 5

Antes de auditar, asegúrate de que el host Docker esté funcionando correctamente.

- Ejecuta `./infra-up.sh` para levantar la infraestructura.

- Verifica el estado con `./infra-status.sh`.

- Confirma que Docker Engine está activo con `docker info`.

Docker Bench analiza más de 100 configuraciones de seguridad del host y contenedores.

- Ejecuta:

```bash
docker run -it --net host --pid host --cap-add audit_control \
-v /etc:/etc:ro -v /usr/bin/docker:/usr/bin/docker:ro \
-v /var/lib:/var/lib:ro -v /var/run/docker.sock:/var/run/docker.sock:ro \
--name docker-bench-security docker/docker-bench-security
```

```text
- Espera el reporte completo.
- Identifica secciones con **WARN** y **FAIL**.
```

Muchos fallos de seguridad provienen de permisos incorrectos en el host.

- Verifica que tu usuario esté en el grupo `docker`.

- Revisa permisos del socket: `ls -l /var/run/docker.sock`.

- Asegúrate de que solo usuarios autorizados puedan ejecutar Docker.

Comprueba que los contenedores no puedan acceder a recursos del host.

- Ejecuta un contenedor aislado: `docker run -it alpine sh`.

- Intenta acceder a `/proc` del host.

- Intenta hacer ping a otros contenedores fuera de su red.

- Verifica que el aislamiento funcione correctamente.

Aplica correcciones basadas en el reporte de Docker Bench.

- Configura auditoría del daemon.

- Restringe permisos de archivos sensibles.

- Habilita logging adecuado.

- Evita contenedores privilegiados.

- Usa imágenes oficiales y actualizadas.

La seguridad es un proceso continuo, no un evento único.

- Vuelve a ejecutar Docker Bench.

- Verifica que los FAIL hayan disminuido.

- Documenta los cambios aplicados.

- Deja el entorno limpio con `./stacks-clean.sh`.

# 🎓 **Resultados de aprendizaje**

Al finalizar este laboratorio, el estudiante será capaz de:

- Ejecutar auditorías de seguridad en Docker

- Interpretar reportes de *Docker Bench for Security*

- Identificar configuraciones inseguras

- Validar aislamiento de contenedores

- Aplicar buenas prácticas de seguridad

- Documentar y corregir vulnerabilidades
