# Alpine based autossh server
FROM alpine
MAINTAINER Shachaf Karvat <shachaf@karvat.biz>

ENV AUTOSSH_PIDDIR="/var/run/" \
    AUTOSSH_PIDFILE="autossh.pid" \
    AUTOSSH_POLL=60 \
    AUTOSSH_FIRST_POLL=30 \
    AUTOSSH_GATETIME=0 \
    AUTOSSH_DEBUG=1 \
    AUTOSSH_PORT=22 \
    AUTOSSH_USER="user"

COPY ["autossh.sh","/root"]

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
 && apk update \
 && apk add openssh autossh \
 && if [ ! -d "${AUTOSSH_PIDDIR}" ] ; then mkdir ${AUTOSSH_PIDDIR} ; fi

CMD "/bin/sh"
