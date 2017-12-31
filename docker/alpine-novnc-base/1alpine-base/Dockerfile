#标准alpine基础镜像
#来源 https://github.com/youske/alpine-stdmachine

FROM alpine:edge

#语言设置
ENV LC_ALL=zh_CN.UTF-8 \
    LANG=zh_CN.UTF-8 \
    WORK_DIR=/workdir

#时区设置，先安装tzdata
ENV TZ=Asia/Shanghai
ENV LANGUAGE=zh_CN.UTF-8

RUN echo "http://mirrors.aliyun.com/alpine/edge/main/"> /etc/apk/repositories && \
    echo "https://mirrors.aliyun.com/alpine/edge/community/" >> /etc/apk/repositories && \
    echo "https://mirrors.aliyun.com/alpine/edge/testing/" >> /etc/apk/repositories && \
    # 时区设置
    apk --update add tzdata && \
    cp /usr/share/zoneinfo/${TZ} /etc/localtime && echo $TZ > /etc/timezone && \
    apk del tzdata && \
    # 包安装和更新
    apk update upgrade --no-cache && \
    apk add bash wget git ca-certificates ncurses gawk --no-cache && \
    # 安装entrykit https://github.com/progrium/entrykit
    ENTRYKIT_VERSION='0.4.0' && \
    ENTRYKIT_FILE=entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz && \
    wget -q -nc https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/${ENTRYKIT_FILE} -P /tmp/ && \
    tar zxf /tmp/${ENTRYKIT_FILE} -C /usr/bin && \
    chmod +x /usr/bin/entrykit && /usr/bin/entrykit --symlink && \
    # 安装gosu https://github.com/tianon/gosu
    GOSU_VERSION='1.10' && \
    wget -q -nc https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64 -P /usr/bin/ && \
    chmod +x /usr/bin/gosu-amd64 && ln -s /usr/bin/gosu-amd64 /usr/bin/gosu && \
    #安装S6OVERLAY
    S6OVERLAY_VERSION='v1.18.1.5' && \
    wget -q -nc https://github.com/just-containers/s6-overlay/releases/download/${S6OVERLAY_VERSION}/s6-overlay-amd64.tar.gz -P /tmp/ && \
    tar zxf /tmp/s6-overlay-amd64.tar.gz -C / && \
    # 预安装软件包删除
    rm -rf /tmp/* /var/cache/apk/* /root/.wget-hsts && \
    # admin用户及工作
    adduser -D -h /home/admin -s /bin/bash admin admin && \
    mkdir -p ${WORK_DIR} && chmod 777 ${WORK_DIR} && chown -R admin:admin ${WORK_DIR}

WORKDIR ${WORK_DIR}
ENTRYPOINT ["switch","shell=gosu admin /bin/bash","--","switch","root=/bin/bash","--","/init"]
CMD ["gosu","admin","/bin/bash"]
