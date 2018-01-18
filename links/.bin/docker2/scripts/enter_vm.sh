#!/bin/bash
PID=$(docker inspect --format {{.State.Pid}} $1)

nsenter --target $PID --mount --uts --ipc --net --pid
