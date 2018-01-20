FROM alpine:3.6

#二进制包安装docker  https://github.com/liumiaocn/easypack/tree/master/docker
#https://download.docker.com/linux/static/stable/x86_64/docker-17.09.0-ce.tgz

ARG DOCKER_CLI_VERSION="17.09.0-ce"
ENV DOWNLOAD_URL="https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_CLI_VERSION.tgz"



# 安装docker客户端
RUN apk --update add curl \
    && mkdir -p /tmp/download \
    && curl -L $DOWNLOAD_URL | tar -xz -C /tmp/download \
    && mv /tmp/download/docker/docker /bin/docker \
    && rm -rf /tmp/download \
    && apk del curl \
    && rm -rf /var/cache/apk/*

ARG DOCKER_COMPOSE_VERSION="1.16.1"
ENV DOWNLOAD_URL="https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-Linux-x86_64"

# 安装docker-compose
RUN apk add --update --virtual build_deps curl \
    && compose_version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq .tag_name | tr -d '"') \
    && curl -Lo /tmp/docker-compose https://github.com/docker/compose/releases/download/$compose_version/docker-compose-Linux-x86_64 \
    && chmod +x /tmp/docker-compose \
    && mv /tmp/docker-compose /bin/docker-compose \
    && apk del build_deps \
    && rm -rf /var/cache/apk/*

ENTRYPOINT ["/bin/sh"]
#CMD [""]

# install compose
 
