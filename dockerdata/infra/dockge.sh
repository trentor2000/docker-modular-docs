#!/bin/bash
# dockge.sh - Infraestructura Base Portátil

docker run -d \
  --name dockge \
  -p 5001:5001 \
  -e DOCKGE_STACKS_DIR="$HOME/dockerdata/stacks" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /usr/bin/docker:/usr/bin/docker \
  -v /opt/dockge:/app/data \
  -v "$HOME/dockerdata:$HOME/dockerdata" \
  louislam/dockge:latest
