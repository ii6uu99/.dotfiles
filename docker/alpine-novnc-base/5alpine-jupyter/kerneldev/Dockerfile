# Alpine Linux miniconda with Jupyter php
# youske/alpine-jupyter based

FROM youske/alpine-jupyter:latest
MAINTAINER youske miyakoshi <youske@gmail.com>

ENV JUPYTER_HOME=/jupyter_notebook \
    LANG=C.UTF-8 \
    PORT=8888 \
    PACKAGE="git nodejs ncurses ncurses5-widec-libs" \
    BUILD_PACKAGE='build-base musl-dev python-dev libffi-dev openssl-dev zeromq-dev linux-headers'

USER root
WORKDIR /


COPY requirements.txt /tmp/requirements.txt

# kerneldev package
RUN apk update --no-cache && apk add ${PACKAGE} --no-cache && apk add ${BUILD_PACKAGE} --no-cache -t buildtool
RUN pip install -r /tmp/requirements.txt
#RUN rm -rf /tmp/* /var/cache/apk/*

COPY start.sh /start.sh


EXPOSE ${PORT}

#USER admin

WORKDIR ${JUPYTER_HOME}
ENTRYPOINT ["render","/home/admin/.jupyter/jupyter_notebook_config.py","--","render","/home/admin/.ipython/profile_default/ipython_config.py","--","switch","shell=su admin -c /bin/bash","--","switch","root=/bin/bash","--","sh","-c","/conda/bin/jupyter notebook --no-browser --ip=*"]
