FROM ubuntu:rolling
MAINTAINER Neil Cawse <neilcawse@hotmail.com>

ENV DEBIAN_FRONTEND noninteractive

ADD startup.sh /startup.sh
ADD ["https://go.microsoft.com/fwlink/?LinkID=760868", "code.deb"]

RUN apt-get update -y && \
    apt-get install -y dirmngr apt-transport-https && \
    sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ yakkety main" > /etc/apt/sources.list.d/dotnetdev.list' && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893 && \
    apt-get update -y && \
    apt-get install -y git wget python python-numpy x11vnc unzip xvfb net-tools openbox menu chromium-browser libnotify4 dotnet-dev-1.0.4 && \
    dpkg -i code.deb && \
    apt-get install -f && \
    rm code.deb && \
    cd /root && git clone https://github.com/kanaka/noVNC.git && \
    cd noVNC/utils && git clone https://github.com/kanaka/websockify websockify && \
    cd /root && \
    chmod 0755 /startup.sh && \
    apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

CMD /startup.sh
EXPOSE 8080

#docker build -t neil .
#docker run -td -p 8080:8080 neil
