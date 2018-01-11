FROM ubuntu:xenial
MAINTAINER atomney <atomney+docker@gmail.com>

# Tell APT that humans aren't going to answer package questions
ENV DEBIAN_FRONTEND noninteractive

# Set a default Password for VNC
ENV VNCPASS letmein

# Copy start script into root of container
COPY startup.sh /startup.sh

# Install general packages
RUN apt-get update -y && \
    apt-get install -y libtasn1-3-bin libglu1-mesa git net-tools wget python python-numpy unzip firefox menu mtr remmina \
    iputils-ping geany htop tmux screen iperf netcat wireshark curl dnsutils snmp zenmap telnet filezilla nano vim autocutsel sshfs sudo \
    sysstat openssh-server scrot pavucontrol openconnect && \
    apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# Install Desktop Environment
RUN apt-get update -y && \
    apt-get install -y xfce4 xfce4-goodies && \
    apt-get autoclean && \
    apt-get autoremove && \
    apt-get remove -y xscreensaver && \
    rm -rf /var/lib/apt/lists/*

# Install novnc
RUN cd /root && git clone https://github.com/kanaka/noVNC.git && \
    cd /root && \
    chmod 0755 /startup.sh

# Install tigervnc
RUN cd /root && wget https://bintray.com/tigervnc/stable/download_file?file_path=ubuntu-16.04LTS%2Famd64%2Ftigervncserver_1.8.0-1ubuntu1_amd64.deb -O tigervncserver.deb && \
    dpkg -i tigervncserver.deb && \
    rm tigervncserver.deb

# Create non root user
RUN adduser tux && \
    echo "tux ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/tux && \
    chmod 0440 /etc/sudoers.d/tux

# Copy files into users home folder
COPY xstartup /home/tux/.vnc/xstartup

# Fix permissions on users home folder
RUN chown -R tux:tux /home/tux && \
    chmod 0755 /home/tux/.vnc/xstartup

# Set the script to run on container launch
CMD /startup.sh

# Expose the noVNC port
EXPOSE 6080
