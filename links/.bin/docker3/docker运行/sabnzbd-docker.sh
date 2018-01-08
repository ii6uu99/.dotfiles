docker create --name=sabnzbd \
-v /storage/sabnzbd/config:/config \
-v /storage/complete:/downloads \
-v /storage/incomplete:/incomplete-downloads \
-v /storage/videos:/tv \
-v /storage/music:/music \
-v /storage/movies:/movies \
-e PGID=1000 -e PUID=1000 \
-e TZ=America/Los_Angeles \
-p 8080:8080 -p 9090:9090 \
linuxserver/sabnzbd
