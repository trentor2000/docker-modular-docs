#!/bin/bash

docker run -d \
  --name traefik \
  --restart unless-stopped \
  -p 80:80 \
  -p 443:443 \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -v /opt/traefik:/etc/traefik \
  traefik:latest
