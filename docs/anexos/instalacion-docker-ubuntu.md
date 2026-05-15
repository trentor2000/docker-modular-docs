# 🐳 Instalación de Docker Engine en Ubuntu / Zorin OS

*(Guía oficial, simplificada y validada para entornos educativos y productivos)*

Este anexo explica cómo instalar **Docker Engine** correctamente en:

- Ubuntu 22.04 / 24.04

- Zorin OS 17 / 18 (basado en Ubuntu)

La instalación sigue **las instrucciones oficiales de Docker**, pero adaptadas para:

- evitar errores comunes

- garantizar compatibilidad con tu arquitectura Docker Modular

- asegurar que Docker funcione sin systemd hacks ni workarounds

# 🧱 1. Requisitos previos

### Sistema operativo compatible

- Ubuntu 22.04 LTS

- Ubuntu 24.04 LTS

- Zorin OS 17 / 18

### Paquetes necesarios

```bash
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release
```

# 🧩 2. Agregar la clave GPG oficial de Docker

```bash
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

# 🧩 3. Agregar el repositorio oficial de Docker

```bash
echo \  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \  https://download.docker.com/linux/ubuntu \  $(lsb_release -cs) stable" | \  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

# 🧩 4. Instalar Docker Engine

```bash
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

# 🧪 5. Verificar instalación

```bash
docker --version
docker compose version
sudo systemctl status docker
```

# 🧠 6. Habilitar Docker sin sudo (opcional pero recomendado)

```bash
sudo usermod -aG docker $USER
```

Cerrar sesión y volver a entrar.

# 🧭 7. Probar Docker

```bash
docker run hello-world
```

Si ves el mensaje de bienvenida, Docker está funcionando correctamente.

# 🧩 8. Ubicación del Docker Root Dir (para tu arquitectura)

Tu arquitectura Docker Modular usa:

```text
/home/usuario/.docker-storage
```

Para configurarlo:

```bash
sudo mkdir -p /home/usuario/.docker-storage
sudo chown -R $USER:$USER /home/usuario/.docker-storage
```

Crear archivo de configuración:

```bash
mkdir -p ~/.config/docker
nano ~/.config/docker/daemon.json
```

Contenido:

```json
{
  "data-root": "/home/usuario/.docker-storage"
}
```

Reiniciar Docker:

```bash
sudo systemctl restart docker
```

# 🧩 9. Verificar que Docker usa el nuevo directorio

```bash
docker info | grep "Docker Root Dir"
```

Debe mostrar:

Código

```text
Docker Root Dir: /home/usuario/.docker-storage
```

# 🎓 10. Uso docente

Para estudiantes:

> “Sigue esta guía para instalar Docker de forma limpia y compatible con el curso.”

Para docentes:

> “Garantiza que todos los alumnos tengan un entorno homogéneo y estable.”
