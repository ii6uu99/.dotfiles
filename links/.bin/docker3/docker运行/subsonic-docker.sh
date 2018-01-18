docker run  \
-d --net=host  \
--name subsonic \
-p 4040:4040 \
-e APP_UID=999 \
-e APP_GID=998 \
-e APP_USER=subsonic \
-e HTTP_PORT=4040 \
-e MAX_MEM=150 \
-e CONTEXT_PATH=/subsonic \
-v /storage/subsonic:/subsonic \
-v /storage/music:/music \
-v /storage/subsonic/config:/config \
-e TZ=America/Los_Angeles \
 hurricane/subsonic
