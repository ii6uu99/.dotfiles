docker create \
--name sonarr \
-p 8989:8989 \
-e PUID=1000 \
-e PGID=1000 \
-e TZ=America/Los_Angeles \
-v /storage/sonarr/config:/config \
-v /storage/videos:/tv \
-v /storage/complete:/downloads \
linuxserver/sonarr
