# 🐳 Instalación de Docker Engine en WSL2 (Ubuntu)

*(Guía oficial, simplificada y validada para tu arquitectura Docker Modular)*

Este anexo explica cómo instalar **Docker Engine** correctamente dentro de **WSL2 (Ubuntu)**, evitando:

- errores de systemd

- conflictos con Docker Desktop

- problemas con permisos del socket

- rutas incorrectas del Docker Root Dir

Esta guía funciona para:

- Ubuntu 22.04 / 24.04 en WSL2

- Windows 10 / 11

- WSL2 con kernel actualizado

# 🧱 1. Requisitos previos

### Verificar que estás en WSL2

```bash
wsl.exe -l -v
```

Debe mostrar:

```text
Ubuntu    Running    2
```

### Actualizar paquetes

```bash
sudo apt update
sudo apt upgrade -y
```

# 🧩 2. Habilitar systemd en WSL2 (obligatorio para Docker Engine)

Editar el archivo de configuración de WSL:

```bash
sudo nano /etc/wsl.conf
```

Agregar:

```ini
[boot]
systemd=true
```

Salir de WSL:

```bash
wsl.exe --shutdown
```

Volver a entrar.

Verificar:

```bash
systemctl is-active systemd
```

Debe mostrar:

```text
active
```

[nota: en ocasiones ubuntu muestra el estado inactive de systemctl, puedes comprobar si efectivamente esta inactivo con systemctl start o stop docker ]

# 🧩 3. Instalar dependencias

```bash
sudo apt install -y ca-certificates curl gnupg lsb-release
```

# 🧩 4. Agregar la clave GPG oficial de Docker

```bash
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

# 🧩 5. Agregar el repositorio oficial de Docker

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

```bash
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

[si se presentan errores en las claves verifica en [Install Docker Engine on Ubuntu | Docker Docs](https://docs.docker.com/engine/install/ubuntu/)]

# 🧪 7. Verificar instalación

```bash
docker --version
docker compose version
sudo systemctl status docker
```

# 🧠 8. Habilitar Docker sin sudo

```bash
sudo usermod -aG docker $USER
```

Cerrar sesión de WSL y volver a entrar.

# 🧩 9. Configurar Docker Root Dir para tu arquitectura

Tu arquitectura Docker Modular usa:

```text
/home/usuario/.docker-storage
```

Crear carpeta:

```bash
mkdir -p ~/.docker-storage
```

Crear archivo de configuración:

```bash
sudo mkdir -p /etc/docker
sudo nano /etc/docker/daemon.json
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

# 🧩 10. Verificar que Docker usa el nuevo directorio

```bash
docker info | grep "Docker Root Dir"
```

Debe mostrar:

```text
Docker Root Dir: /home/usuario/.docker-storage
```

# 🧭 11. Probar Docker

```bash
docker run hello-world
```

Si ves el mensaje de bienvenida, Docker está funcionando correctamente dentro de WSL2.

# 🎓 12. Uso docente

Para estudiantes:

> “Esta guía te permite instalar Docker Engine en WSL2 sin depender de Docker Desktop.”

Para docentes:

> “Garantiza entornos homogéneos incluso en Windows, sin inconsistencias entre máquinas.”
