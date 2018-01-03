#https://github.com/youske/alpine-conda
#https://github.com/ownport/docker-alpine-miniconda

FROM youske/alpine-stdmachine-glibc:latest
MAINTAINER youske miyakoshi <youske@gmail.com>

LABEL com.stdmachine.description="alpine miniconda3 image" \
      com.stdmachine.role="miniconda3 image"

ENV CONDA_DIR="/conda"
ENV PATH="$CONDA_DIR/bin:$PATH"

WORKDIR /tmp

ADD .pip/ /root/.pip
ADD .jupyter/ /root/.jupyter

RUN apk add --no-cache libstdc++

RUN CONDA_VERSION="4.2.12" && \
    mkdir -p "$CONDA_DIR" && \
    wget -q "https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh" -O installer.sh && \
    bash installer.sh -f -b -p "$CONDA_DIR" && \
    echo "export PATH=$CONDA_DIR/bin:\$PATH" > /etc/profile.d/conda.sh && \
    conda update --all --yes && conda clean --all --yes && \
    conda config --set auto_update_conda False && \
    rm -rf $(find "$CONDA_DIR/pkgs/" -maxdepth 1 -name "python-3*" | sort | head -n -1) && \
    rm -rf /tmp/* /root/.wget-hists && \
    # 添加Anaconda的TUNA镜像
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/ &&\
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ && \
    # 设置搜索时显示通道地址  
    conda config --set show_channel_urls yes &&\
    
    #复制阿里云pip源到容器的根目录下
    #cp -r .pip /root/ &&\
    
    #不缓存目录升级pip
    pip install --no-cache-dir --upgrade pip setuptools &&\

    #安装jupyter notebook
    #conda install jupyter notebook -y
    pip install jupyter notebook

WORKDIR /
EXPOSE 8888

CMD ["jupyter", "notebook","--allow-root"]
