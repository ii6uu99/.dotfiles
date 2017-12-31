#!/bin/bash

set -e

if [[ "$1" == 'no-cron' ]]; then
    export COMMAND="${@:2}"
    exec /command.sh
else
    LOGFIFO='/var/log/cron.fifo'
    if [[ ! -e "$LOGFIFO" ]]; then
        mkfifo "$LOGFIFO"
    fi

    printf -v COMMAND "%q " "$@"
    export COMMAND

    echo -e "$CRON_SCHEDULE /onstart.sh > $LOGFIFO 2>&1; /command.sh > $LOGFIFO 2>&1; /onfinish.sh > $LOGFIFO 2>&1" | crontab -
    crontab -l
    crond
    tail -f "$LOGFIFO"
fi






