docker create \
  --name=plexpy \
    -v /storage/plexpy/config:/config \
    -v /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Logs:/logs:ro \
    -e TZ=Americas/Los_Angeles \
    -e PGID=1000 -e PUID=1000  \
    -p 9292:8181 \
  linuxserver/plexpy
