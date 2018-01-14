docker create \
  --name=znc \
  -v /znc:/config \
  -e PGID=1000 -e PUID=1000  \
  -e TZ=America/Los_Angeles \
  -p 4096:4096 \
  linuxserver/znc
