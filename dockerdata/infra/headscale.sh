#!/bin/bash

docker run -d \
  --name headscale \
  --restart unless-stopped \
  -p 8080:8080 \
  -v /opt/headscale/config:/etc/headscale \
  -v /opt/headscale/data:/var/lib/headscale \
  headscale/headscale:latest \
  serve
