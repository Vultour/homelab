FROM alpine:3.4
RUN apk add --no-cache bind
COPY dns/named.conf /etc/bind/named.conf
COPY dns/zones/root.servers /var/named/root.servers
COPY dns/local.zones /var/named/local.zones
COPY dns/zones/local.zone /var/named/local.zone
COPY dns/zones/local.rev.zone /var/named/local.rev.zone
EXPOSE 53/tcp
EXPOSE 53/udp
CMD named -g
