# Alpine Linux miniconda with Jupyter word2vec

FROM youske/alpine-jupyter:latest
MAINTAINER youske miyakoshi <youske@gmail.com>

ENV JUPYTER_HOME=/workdir \
    LANG=C.UTF-8 \
    PORT=8888 \
    PACKAGE="git nodejs ncurses ncurses5-widec-libs" \
    BUILD_PACKAGE='build-base musl-dev python-dev libffi-dev openssl-dev zeromq-dev linux-headers'

USER root
WORKDIR /

COPY requirements.txt /tmp/requirements.txt

# kerneldev package
#RUN apk update --no-cache && apk add ${PACKAGE} --no-cache && apk add ${BUILD_PACKAGE} --no-cache -t buildtool
RUN pip install -r /tmp/requirements.txt
#RUN apk del buildtool --no-cache && rm -rf /tmp/* /var/cache/apk/*
