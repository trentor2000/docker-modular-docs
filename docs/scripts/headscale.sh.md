# 🟦 headscale.sh

El script `headscale.sh` despliega Headscale, el control plane de código abierto compatible con Tailscale. En tu arquitectura **Docker Modular**, Headscale permite:

- Gestionar identidades de dispositivos.

- Crear redes privadas seguras (Mesh VPN).

- Administrar nodos sin depender de la infraestructura en la nube de Tailscale Inc.

- Integrar acceso remoto seguro a tu laboratorio de infraestructura.

Este script usa `docker run` para garantizar la simplicidad, reproducibilidad y compatibilidad con entornos educativos y de laboratorio.

## 🧱 1. Ubicación del script

`~/dockerdata/infra/headscale.sh`

*(Forma parte del paquete base que el estudiante gestiona en su `$HOME`).*

## 🧩 2. ¿Qué hace exactamente headscale.sh?

- Elimina instancias previas colgadas para evitar conflictos de nombre.

- Crea el contenedor bajo la política de resiliencia `--restart unless-stopped`.

- Expone el puerto `8080` (API y control plane).

- **Segmentación Estricta de Persistencia:** Aísla la configuración (`/etc/headscale`) de los datos dinámicos como la base de datos y llaves (`/var/lib/headscale`) usando la estructura centralizada `/opt/headscale`.

## 🧪 3. Modelo oficial del script

```bash
#!/bin/bash
echo "=== Iniciando Configuración de Headscale ==="

# 1. Asegurar la existencia de los directorios de infraestructura
sudo mkdir -p /opt/headscale/config
sudo mkdir -p /opt/headscale/data

# 2. Inyección y aprovisionamiento automático de la configuración (Alineación Core)
if [ ! -f /opt/headscale/config/config.yaml ]; then
    echo "[!] config.yaml no detectado. Descargando plantilla oficial v0.28.0..."
    sudo wget -q https://github.com/juanfont/headscale/raw/v0.28.0/config-example.yaml -O /opt/headscale/config/config.yaml
    
    echo "[*] Aplicando parches de red y seguridad automatizados..."
    
    # Parche A: Forzar escucha en todas las interfaces (Evita bloqueo de puerto en localhost)
    sudo sed -i 's|listen_addr: 127.0.0.1:8080|listen_addr: 0.0.0.0:8080|g' /opt/headscale/config/config.yaml
    sudo sed -i 's|metrics_listen_addr: 127.0.0.1:9090|metrics_listen_addr: 0.0.0.0:9090|g' /opt/headscale/config/config.yaml
    
    # Parche B: Configurar la URL base por defecto para entorno local
    sudo sed -i 's|server_url: http://127.0.0.1:8080|server_url: http://localhost:8080|g' /opt/headscale/config/config.yaml
    
    # Parche C: Desactivar anulación de DNS local para mitigar colisiones en el host
    sudo sed -i 's|override_local_dns: true|override_local_dns: false|g' /opt/headscale/config/config.yaml
    
    # Parche D: Definir la ruta interna obligatoria para la llave criptográfica Noise
    sudo sed -i 's|noise:#\s*private_key_path:.*|noise:\n  private_key_path: /var/lib/headscale/noise_private.key|g' /opt/headscale/config/config.yaml
    
    echo "[🟢] Configuración aprovisionada y protegida con éxito."
else
    echo "[✓] Archivo config.yaml existente detectado. Conservando parámetros actuales."
fi

# 3. Limpieza de runtime previo
echo "=== Desplegues en Runtime ==="
docker rm -f headscale 2>/dev/null

# 4. Despliegue del contenedor Core
docker run -d \
  --name headscale \
  --restart unless-stopped \
  -p 8080:8080 \
  -v /opt/headscale/config:/etc/headscale \
  -v /opt/headscale/data:/var/lib/headscale \
  headscale/headscale:latest \
  serve

echo "=== Headscale iniciado correctamente en http://localhost:8080 ==="
```

> ⚠️ **Notas Críticas de Configuración:**
> 
> - El directorio `/opt/headscale/config/` debe contener obligatoriamente un archivo `config.yaml` válido antes de la ejecución.
> 
> - Dentro de `config.yaml`, las directivas de red deben escuchar en la interfaz global del contenedor (`listen_addr: 0.0.0.0:8080`) para permitir el reenvío de puertos hacia el host.

## 🧭 4. Cómo usar este script

1. **Ir a la carpeta de infraestructura:**
   
   ```bash
   cd ~/dockerdata/infra
   ```

2. **Asignar permisos de ejecución (solo la primera vez):**
   
   ```bash
   chmod +x headscale.sh
   ```

3. **Ejecutar el script:**
   
   ```bash
   ./headscale.sh
   ```

4. **Verificar el estado en el runtime:**
   
   
   
   ```bash
   docker ps --filter "name=headscale"
   ```

## 🧠 5. ¿Cuándo usar headscale.sh?

- Durante la inicialización del ecosistema con `infra-up.sh`.

- Cuando el contenedor entra en estado de error o falla de red.

- Al aplicar parches de seguridad o cambios manuales directos en el archivo `config.yaml`.

## 🧩 6. Relación con otros scripts

| **Script**      | **Función**                                          | **Capa Operativa**     |
| --------------- | ---------------------------------------------------- | ---------------------- |
| `dockge.sh`     | Despliega el orquestador visual de stacks.           | Control de Usuario     |
| `portainer.sh`  | Despliega el panel de observabilidad global.         | Infraestructura Base   |
| `watchtower.sh` | Automatiza la actualización silenciosa de imágenes.  | Mantenimiento Base     |
| `traefik.sh`    | Proxy inverso y terminación de certificados SSL.     | Enrutamiento e Ingress |
| `infra-up.sh`   | Orquesta el levantamiento en cadena de la capa base. | Automatización         |

## 🎓 7. Uso docente

- **Para estudiantes:** *“Headscale es tu propio servidor central de VPN. Te permite conectar tu computadora, tu teléfono y tus contenedores en una sola red privada segura que funciona en cualquier parte del mundo, sin abrir puertos en el módem de tu casa y con cifrado de grado militar.”*

- **Para el docente:** *“Provee el tejido de red necesario para auditorías de conectividad y acceso seguro a los laboratorios de los alumnos, aislando el tráfico de administración del tráfico general de la red del campus.”*
