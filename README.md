# caddy-docker-proxy_with-acmedns
[lucaslorentz/caddy-docker-proxy](https://github.com/lucaslorentz/caddy-docker-proxy) with the Caddy DNS Module for acmedns

## Usage
For further information and more detailed instructions on the use of this container/caddy-module, please refer to the https://github.com/lucaslorentz/caddy-docker-proxy

## Docker Compose Example (excluding backend/reverse proxy target)
docker-compose.yml
```
version: "3.8"

services:
  caddy:
    image: glopix/caddy-docker-proxy-with-acmedns
    restart: unless-stopped
    ports:
      - 80:80
      - 443:443
    environment:
      - CADDY_INGRESS_NETWORKS=caddy
# if you want an additional  Caddyfile:
#      - CADDY_DOCKER_CADDYFILE_PATH=/data/Caddyfile

    networks:
      - caddy
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - caddy_data:/data
# if you want an additional  Caddyfile:      
#      - ./Caddyfile:/data/Caddyfile

networks:
  caddy:
    name: caddy
    driver: bridge

# persistant storage for certs etc.
volumes:
  caddy_data:
```
