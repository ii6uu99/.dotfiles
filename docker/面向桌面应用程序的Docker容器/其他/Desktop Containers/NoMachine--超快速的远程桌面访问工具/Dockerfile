FROM ubuntu:xenial

ENV DEBIAN_FRONTEND=noninteractive

# Install Packages
RUN apt-get update && apt-get install -y vim xterm pulseaudio cups
RUN apt-get install -y mate-desktop-environment-core
RUN apt-get install -y wget chromium-browser remmina htop iperf sudo && \
        wget -O /nomachine.deb http://download.nomachine.com/download/5.1/Linux/nomachine_5.1.44_1_amd64.deb

RUN dpkg -i /nomachine.deb

ADD nxserver.sh /

RUN groupadd -r nomachine -g 433 && \
useradd -u 431 -r -g nomachine -d /home/nomachine -s /bin/bash -c "NoMachine" nomachine && \
mkdir /home/nomachine && \
chown -R nomachine:nomachine /home/nomachine && \
echo "AgentX11VectorGraphics 0" >> /etc/NX/server/localhost/node.cfg && \
echo 'nomachine:nomachine' | chpasswd && \
echo "nomachine ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/nomachine && \
chmod +x /nxserver.sh && \
chmod 0440 /etc/sudoers.d/nomachine

# Expose the Nomachine port
EXPOSE 4000

ENTRYPOINT ["/nxserver.sh"]
