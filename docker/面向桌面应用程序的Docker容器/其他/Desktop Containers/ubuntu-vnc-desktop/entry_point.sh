#!/bin/bash
export GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"

function shutdown {
  kill -s SIGTERM $NODE_PID
  wait $NODE_PID
}

export DISPLAY=:0

sudo -E -i -u user \
  Xvfb $DISPLAY -screen 0 $GEOMETRY &
NODE_PID=$!

#trap shutdown SIGTERM SIGINT
for i in $(seq 1 10)
do
  xdpyinfo -display $DISPLAY >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "vnc server started"
    break
  fi
  echo Waiting xvfb...
  sleep 0.5
done

sudo -E -i -u user \
  fluxbox -display $DISPLAY &

sudo -E -i -u user \
  x11vnc -display $DISPLAY -bg -nopw -xkb -usepw -shared -repeat -loop -forever &

sudo -E -i -u user \
  /opt/google/chrome/google-chrome --no-sandbox --no-default-browser-check &

wait $NODE_PID
