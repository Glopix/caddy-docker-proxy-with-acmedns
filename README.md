# caddy-docker-proxy-with-acmedns
[lucaslorentz/caddy-docker-proxy](https://github.com/lucaslorentz/caddy-docker-proxy) with the Caddy [DNS Module for acmedns](https://github.com/caddy-dns/acmedns)

## Github Repository / Dockerfile
https://github.com/Glopix/caddy-docker-proxy-with-acmedns

## Usage
For further information and more detailed instructions on the use of this container/caddy-module, please refer to the https://github.com/lucaslorentz/caddy-docker-proxy and https://github.com/caddy-dns/acmedns on how to use the DNS module

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
# if you want an additional Caddyfile:
# (e.g. if you dont want to configure the ACME-DNS module via labels)
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

Caddyfile (e.g. if you dont want to configure the ACME-DNS module via labels)
```
{
        email name@example.com
#       acme_ca https://acme-staging-v02.api.letsencrypt.org/directory
}


*.example.com {
        tls {
                resolvers 1.1.1.1:53
                dns acmedns {
                        username xxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
                        password xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
                        subdomain xxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
                        server_url https://auth.acme-dns.io
                }
        }
}
```
