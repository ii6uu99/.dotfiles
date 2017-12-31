# Alpine Linux miniconda with Jupyter js phosphide
# youske/alpine-jupyter based

FROM youske/alpine-jupyter:latest
MAINTAINER youske miyakoshi <youske@gmail.com>

ENV JUPYTER_HOME=/jupyter_notebook \
    LANG=C.UTF-8 \
    PORT=8888 \
    PACKAGE="nodejs " \
    BUILD_PACKAGE='build-base musl-dev nodejs-dev linux-headers'

USER root
WORKDIR /tmp
RUN apk update --no-cache && apk add ${PACKAGE} --no-cache && apk add ${BUILD_PACKAGE} --no-cache -t buildtool


USER admin
# phosphide
RUN git clone https://github.com/jupyter/jupyter-js-phosphide.git && \
    cd jupyter-js-phosphide && npm install && npm run build



USER root
#RUN apk del buildtool --no-cache && rm -rf /tmp/* /var/cache/apk/*
