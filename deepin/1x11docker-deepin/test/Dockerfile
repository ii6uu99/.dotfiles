#https://github.com/mviereck/dockerfile-x11docker-deepin

FROM deepin/deepin-core

#安装docker
ADD aliyun.sh /usr/bin/aliyun.sh
RUN chmod +x /usr/bin/aliyun.sh &&\
    sh aliyun.sh

CMD docker
