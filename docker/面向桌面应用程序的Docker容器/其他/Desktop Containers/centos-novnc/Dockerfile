#
# docker build -t appsoa/centos-base-java:1.8.0_60 -t appsoa/centos-base-java:latest .
#
FROM appsoa/centos-base-java:latest
MAINTAINER Matthew Davis <matthew@appsoa.io>

ENV INSTALL4J_JAVA_HOME=/usr/java/jdk1.8.0_60 \
    TZ=America/Phoenix

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

COPY src/home /home
COPY src/bin /bin

RUN chown -R user /home/user/noVNC && \
    yum -y install net-tools bind-utils nmap && \
    yum clean all -y

WORKDIR /home/user/noVNC
EXPOSE 6901

ENTRYPOINT ["/bin/entrypoint.sh"]