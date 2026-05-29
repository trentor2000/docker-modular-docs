#!/bin/bash

docker run -d \
  --name portainer \
  --restart unless-stopped \
  -p 9443:9443 \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -v /opt/portainer:/data \
  portainer/portainer-ce:latest
