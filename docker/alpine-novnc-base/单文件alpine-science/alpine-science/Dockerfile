#https://github.com/nikeee/docker.alpine.scipy
#python2的 https://github.com/marcelmfs/docker-alpine

FROM alpine:3.6

RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime
RUN echo "http://nl.alpinelinux.org/alpine/v3.6/main" > /etc/apk/repositories

COPY libs/* /tmp/

RUN apk update &&\
    apk add python3 \
            python3-dev \
            ca-certificates \
            openntpd \
            build-base \
            musl-dev \
            gfortran \
            libgfortran
#升级pip
RUN python3 /tmp/get-pip.py

# 创建BLAS and LAPACK
RUN source /tmp/blas.sh
RUN source /tmp/lapack.sh

RUN ln -s /usr/include/locale.h /usr/include/xlocale.h

# python安装numpy, pandas, scipy and scikit
RUN BLAS=~/src/BLAS/libfblas.a LAPACK=~/src/lapack-3.5.0/liblapack.a pip3.6 install -v numpy==1.13.1
RUN BLAS=~/src/BLAS/libfblas.a LAPACK=~/src/lapack-3.5.0/liblapack.a pip3.6 install -v pandas==0.20.3
RUN BLAS=~/src/BLAS/libfblas.a LAPACK=~/src/lapack-3.5.0/liblapack.a pip3.6 install -v scipy==0.19.1
RUN BLAS=~/src/BLAS/libfblas.a LAPACK=~/src/lapack-3.5.0/liblapack.a pip3.6 install -v scikit-learn[alldeps]==0.18.2

#安装其他python库
#RUN BLAS=~/src/BLAS/libfblas.a LAPACK=~/src/lapack-3.5.0/liblapack.a pip install ipython
#COPY requirements.txt /tmp/
#RUN BLAS=~/src/BLAS/libfblas.a LAPACK=~/src/lapack-3.5.0/liblapack.a pip install -r /tmp/requirements.txt


# 清理
RUN mv ~/src/BLAS/libfblas.a /tmp/
RUN mv ~/src/lapack-3.5.0/liblapack.a /tmp/
RUN rm -rf ~/src
RUN rm -rf ~/.cache/pip
RUN mkdir -p ~/src/BLAS ~/src/lapack-3.5.0
RUN mv /tmp/libfblas.a ~/src/BLAS/libfblas.a
RUN mv /tmp/liblapack.a ~/src/lapack-3.5.0/liblapack.a
RUN rm -rf /tmp/*

# 删除所有构建过程中额外的东西
RUN apk del build-base "*-dev"
