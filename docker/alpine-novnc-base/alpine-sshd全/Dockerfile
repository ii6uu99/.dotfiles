#https://github.com/fasrc/container-alpine-sshd
#https://github.com/Gaff/alpine-sshd


FROM alpine:3.4

LABEL edu.harvard.fas.rc.origin="sickp/alpine-sshd:latest"

RUN apk add --no-cache openssh bash rsync

ENV USERNAME=transfer
ENV PASSWORD='ming'
ENV GROUP=grid
ENV UID=1004
ENV GID=20031
ENV PUBKEY=''
ENV ROOT_PASSWORD='rootming'
ENV MOTD=''


RUN sed -i s/#PubkeyAuthentication.*/PubkeyAuthentication\ yes/ /etc/ssh/sshd_config && \
    sed -i s/#PermitRootLogin.*/PermitRootLogin\ no/ /etc/ssh/sshd_config && \
    sed -i s/PermitRootLogin.*/PermitRootLogin\ no/ /etc/ssh/sshd_config && \
    sed -i s/#LogLevel.*/LogLevel\ DEBUG/ /etc/ssh/sshd_config && \
    rm -rf /var/cache/apk/*

COPY ./entrypoint.sh /entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]
#＃在启动时运行的脚本
#COPY 脚本名.sh /etc/cont-init.d/脚本名
#RUN chmod 755 /etc/cont-init.d/脚本名


#-D = don't detach, -e = output to stderr, -f = config file
CMD [ "/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config"]



