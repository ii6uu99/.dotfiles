FROM shrek/ubuntu-enlightenment-base
MAINTAINER Shrek Is Love <github.com/ShrekIsLoveLife>



ADD root_fs /
# RUN rm /root/firefox-esr_52.5.0esr+build2-0ubuntu0.16.04.1_amd64.deb

EXPOSE 80
EXPOSE 443

WORKDIR /root
ENV HOME=/home/user \
    SHELL=/bin/bash

ENTRYPOINT ["/startup.sh"]
