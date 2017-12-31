#https://github.com/lihaixin2/openvpn

FROM ubuntu:16.04
MAINTAINER Haixin Lee <docker@lihaixin.name>
ENV DEBIAN_FRONTEND noninteractive
#https://support.purevpn.com/linux-openvpn-command
RUN apt-get update  && \
             apt-get install -y --no-install-recommends gettext-base wget curl  \
             iputils-ping iproute2 mtr vim net-tools supervisor iptables openvpn \
             unzip dnsutils

WORKDIR /

RUN wget --no-check-certificate "https://s3-us-west-1.amazonaws.com/heartbleed/linux/linux-files.zip" && \
unzip linux-files.zip

RUN cd "Linux OpenVPN Updated files"

WORKDIR /Linux OpenVPN Updated files

RUN /bin/mv  ca.crt  /etc/openvpn/
RUN /bin/mv  Wdc.key /etc/openvpn/
RUN /bin/mv  TCP/* /etc/openvpn/
RUN /bin/mv  UDP/* /etc/openvpn/


RUN cd /etc/openvpn/ && \
sed -i "s/auth-user-pass/auth-user-pass pass.txt/g" *.ovpn

COPY myrun /usr/bin/myrun
RUN chmod +x /usr/bin/myrun

# 升级到最新版本 删除不必要的软件和Apt缓存包列表
RUN  apt-get upgrade --yes && \
         apt-get autoclean && \
         apt-get autoremove && \
         rm -rf /var/lib/apt/lists/*


# 运行各种Service

#ENTRYPOINT ["/usr/bin/myrun"]

WORKDIR /etc/openvpn
