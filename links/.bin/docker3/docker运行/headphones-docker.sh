docker create \
    --name="headphones" \
    -v /storage/headphones/config:/config \
    -v /storage/incomplete:/downloads \
    -v /storage/music:/music \
    -e PGID=1000 -e PUID=1000 \
    -e TZ=Americas/Los_Angeles \
    -p 8181:8181 \
    linuxserver/headphones
