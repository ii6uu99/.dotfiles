FROM x11docker/deepin

ADD source.sh /

RUN chmod +x source.sh &&\
    sh source.sh
RUN \
#更新系统和升级系统
apt-get update -y &&\
apt-get upgrade -yy &&\
apt-get -y install lxterminal xrdp


ENV LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive

# Install vnc, xvfb in order to create a 'fake' display and firefox
run	apt-get install -y x11vnc xvfb firefox
run	mkdir /.vnc
# Setup a password
run	x11vnc -storepasswd 1234 ~/.vnc/passwd
# Autostart firefox (might not be the best way to do it, but it does the trick)
run	bash -c 'echo "startdde" >> /.bashrc'
