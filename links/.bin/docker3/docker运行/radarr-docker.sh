docker create \
  --name=radarr \
    -v /storage/radarr/config:/config \
    -v /storage/radarr/downloads:/downloads \
    -v /storage/:/movies \
    -e TZ=Americas/Los_Angeles \
    -e PGID=1000 -e PUID=1000  \
    -p 7878:7878 \
  linuxserver/radarr
