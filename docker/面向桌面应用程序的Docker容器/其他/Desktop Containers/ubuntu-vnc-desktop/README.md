https://github.com/CarlAmbroselli/vnc-desktop.git

# vnc-desktop

Runs Ubuntu 14.04 in a docker container and exposes a full desktop over VNC.




```bash
docker run -p 5900:5900 -d ambroselli/vnc-desktop
open vnc://user:pazzword@localhost:5900 # (using Screen Sharing on a Mac, use a VNC tool on Windows/Linux)
```

分辨率设置为1680×1050像素。这可以通过在运行后添加以下参数来设置：-e SCREEN_WIDTH=1680 -e SCREEN_HEIGHT=1050
