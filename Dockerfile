FROM caddy:builder AS builder
RUN xcaddy build \
--with github.com/caddyserver/caddy/v2=github.com/caddyserver/caddy@master
--with github.com/lucaslorentz/caddy-docker-proxy@master \
--with github.com/caddy-dns/acmedns@main

FROM caddy:latest
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
CMD ["caddy", "docker-proxy"]
