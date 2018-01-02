#https://github.com/rizkidoank/scrapy-miniconda

FROM alpine
MAINTAINER Rizki Ariyanto<rizkidoank.com>

ENV CONDA_DIR=/opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH
ENV SHELL=/bin/bash LANG=en_US.utf-8

# 安装所需的工具
RUN apk update \
&& apk add bash git curl ca-certificates bzip2 unzip sudo libstdc++ glib libxext libxrender tini openssl gcc \
&& export SHELL=/bin/bash

# 安装gcc进行lxml编译
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
&& wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk -O /tmp/glibc-2.23-r3.apk \
&& wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-i18n-2.23-r3.apk -O /tmp/glibc-i18n-2.23-r3.apk \
&& wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-bin-2.23-r3.apk -O /tmp/glibc-bin-2.23-r3.apk \
&& apk add --allow-untrusted /tmp/glibc*.apk

#配置gcc
RUN /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib \
&& /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8

#安装Miniconda 3
RUN mkdir -p $CONDA_DIR \
&& wget -O /tmp/miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
&& /bin/bash /tmp/miniconda.sh -f -b -p $CONDA_DIR


# 安装Scrapy
RUN conda install -c scrapinghub scrapy
#RUN apk add --no-cache musl-dev openssl-dev libxml2-dev libxslt-dev libffi-dev libxml2 libxslt \
#&& pip install scrapy \
#&& apk del gcc musl-dev openssl-dev libxml2-dev libxslt-dev libffi-dev

# 删除缓存
RUN rm -Rf glib* \
/var/cache/apk/* \
/tmp/miniconda.sh \
~/.cache/pip/ \
&& conda clean -a

CMD ["/bin/bash"]
