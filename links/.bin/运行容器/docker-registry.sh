#!/bin/sh
docker run -d -p 443:5000 --restart=always --name registry \
  -v /srv/registry/data:/var/lib/registry \
  -v /srv/registry/certs:/certs \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/fdu13ss.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/fdu13ss.key \
  registry:2
