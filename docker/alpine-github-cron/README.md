istepanov/cron
==============

[![Docker Stars](https://img.shields.io/docker/stars/istepanov/cron.svg)](https://hub.docker.com/r/istepanov/cron/)
[![Docker Pulls](https://img.shields.io/docker/pulls/istepanov/cron.svg)](https://hub.docker.com/r/istepanov/cron/)
[![Docker Build](https://img.shields.io/docker/automated/istepanov/cron.svg)](https://hub.docker.com/r/istepanov/cron/)
[![Layers](https://images.microbadger.com/badges/image/istepanov/cron.svg)](https://microbadger.com/images/istepanov/cron)
[![Version](https://images.microbadger.com/badges/version/istepanov/cron.svg)](https://microbadger.com/images/istepanov/cron)

Docker image that runs cron that periodically executes bash script.

### Usage

    docker run [-d] [-e 'CRON_SCHEDULE=...'] istepanov/cron [no-cron] command

### Base image parameters

* `-e 'CRON_SCHEDULE=0 1 * * *'`: specifies when cron job starts ([details](http://en.wikipedia.org/wiki/Cron)). Default is `0 1 * * *` (runs every day at 1:00 am).
* `no-cron`: if specified, run container once and exit (no cron scheduling).
* `command`: the actual command that will be run by cron job.

### Example

Print 'Hello World!' every minute:

    docker run -e 'CRON_SCHEDULE=* * * * *' istepanov/cron echo 'Hello World!'

Do it in the background:

    docker run -d -e 'CRON_SCHEDULE=* * * * *' istepanov/cron echo 'Hello World!'

Run immediately once:

    docker run -e 'CRON_SCHEDULE=* * * * *' istepanov/cron no-cron echo 'Hello World!'

### Advanced example - build your own image based on this image

Let's build an image that will run Docker-flavored `cowsay` periodically.

`Dockerfile`

    FROM istepanov/cron

    RUN apk add --no-cache perl ca-certificates wget && \
        wget -O /usr/local/bin/cowsay https://raw.githubusercontent.com/docker/whalesay/master/cowsay && \
        mkdir -p /usr/local/share/cows && \
        wget -O /usr/local/share/cows/default.cow https://raw.githubusercontent.com/docker/whalesay/master/docker.cow && \
        chmod +x /usr/local/bin/cowsay && \
        apk del wget ca-certificates

`command.sh`

    #!/bin/bash

    cowsay "$COW_SPEECH"

Build the image:

    docker build -t cowsay .

Run the image in background:

    docker run -e 'CRON_SCHEDULE=* * * * *' -e COW_SPEECH='Hello World!' cowsay

Output:

    Job started: Fri Oct  6 04:48:00 UTC 2017

    < Hello World! >
     --------------
        \
         \
          \
                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
          {                       /  ===-
           \______ O           __/
             \    \         __/
              \____\_______/

    Job finished: Fri Oct  6 04:48:00 UTC 2017
    Job started: Fri Oct  6 04:49:00 UTC 2017
     ______________
    < Hello World! >
     --------------
        \
         \
          \
                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
          {                       /  ===-
           \______ O           __/
             \    \         __/
              \____\_______/

    Job finished: Fri Oct  6 04:49:00 UTC 2017
