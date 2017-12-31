# Alpine Linux miniconda with Jupyter julia
# youske/alpine-jupyter based

FROM youske/alpine-jupyter:latest
MAINTAINER youske miyakoshi <youske@gmail.com>

ENV JUPYTER_HOME=/jupyter_notebook \
    LANG=C.UTF-8 \
    PORT=8888 \
    GOPATH=/home/admin/.go \
    PACKAGE="git zeromq-dev julia" \
    BUILD_PACKAGE='build-base linux-headers'

USER root
WORKDIR /

# jukia package
#RUN apk update --no-cache && apk add ${PACKAGE} --no-cache && apk add ${BUILD_PACKAGE} --no-cache -t buildtool

USER admin

# julia kernel
#RUN mkdir  -p /home/admin/.go
#RUN go get golang.org/x/tools/cmd/goimports && go get -tags zmq_4_x github.com/gophergala2016/gophernotes
#RUN mkdir -p ~/.ipython/kernels/gophernotes
#RUN cp -r $GOPATH/src/github.com/gophergala2016/gophernotes/kernel/* ~/.ipython/kernels/gophernotes

USER root
#RUN apk del buildtool --no-cache && rm -rf /tmp/* /var/cache/apk/*

#EXPOSE ${PORT}

WORKDIR ${JUPYTER_HOME}
#ENTRYPOINT ["render","/home/admin/.jupyter/jupyter_notebook_config.py","--","render","/home/admin/.ipython/profile_default/ipython_config.py","--","switch","shell=su admin -c /bin/bash","--","switch","root=/bin/bash","--","sh","-c","/conda/bin/jupyter notebook --no-browser --ip=*"]
