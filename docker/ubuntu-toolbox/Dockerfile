FROM ubuntu:16.04
MAINTAINER Lee Haixin <noreply@lihaixin.name>

LABEL vendor="lihaixin.name" \
      release-date="2017-04-29" \
      version="0.0.1"

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y apt-utils && \
    apt-get install -y  \
			curl \
			wget \
			net-tools \
			iputils-ping \
			iproute2 \
			mtr && \
    apt-get clean all && rm -rf /var/lib/apt/lists/*		

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y nano \
	               openssh-client \
		       strace \
		       tcpdump \
		       iftop && \
    apt-get clean all && rm -rf /var/lib/apt/lists/* 

WORKDIR /bin
USER root
CMD ["ping","localhost"]
