# Alpine Linux miniconda with Jupyter php
# youske/alpine-jupyter based

FROM youske/alpine-jupyter:latest
MAINTAINER youske miyakoshi <youske@gmail.com>

ENV JUPYTER_HOME=/jupyter_notebook \
    LANG=C.UTF-8 \
    PORT=8888 \
    PACKAGE="git ca-certificates php php-json php-phar php-mcrypt php-curl php-openssl php-zlib zeromq" \
    BUILD_PACKAGE='wget autoconf build-base musl-dev php-dev zeromq-dev linux-headers'

USER root
WORKDIR /

# php package
RUN apk update --no-cache && apk add ${PACKAGE} --no-cache && apk add ${BUILD_PACKAGE} --no-cache -t buildtool

# composer
RUN cd /tmp && wget -q "https://getcomposer.org/installer" && \
    php installer --install-dir=/usr/local/bin

# php-zmq
RUN cd /tmp && git clone git://github.com/mkoppanen/php-zmq.git && \
    cd php-zmq && phpize && ./configure && make && make install && \
    echo "extension=zmq.so" > /etc/php/conf.d/zmq.ini

# install php kernel
RUN cd /tmp && wget -q --no-check-certificate https://litipk.github.io/Jupyter-PHP-Installer/dist/jupyter-php-installer.phar && \
    mkdir -p /opt/jupyter-php && \
    php ./jupyter-php-installer.phar install /opt/jupyter-php

USER admin
WORKDIR /home/admin

USER root
#RUN apk del buildtool --no-cache && rm -rf /tmp/* /var/cache/apk/*

#EXPOSE ${PORT}

WORKDIR ${JUPYTER_HOME}
#ENTRYPOINT ["render","/home/admin/.jupyter/jupyter_notebook_config.py","--","render","/home/admin/.ipython/profile_default/ipython_config.py","--","switch","shell=su admin -c /bin/bash","--","switch","root=/bin/bash","--","sh","-c","/conda/bin/jupyter notebook --no-browser --ip=*"]
