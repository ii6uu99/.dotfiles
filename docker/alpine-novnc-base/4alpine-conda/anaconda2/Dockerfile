FROM youske/alpine-stdmachine-glibc:latest
MAINTAINER youske miyakoshi <youske@gmail.com>

LABEL com.stdmachine.description="alpine anaconda2 image" \
      com.stdmachine.role="anaconda2 image"

ENV CONDA_DIR="/conda"
ENV PATH="$CONDA_DIR/bin:$PATH"

WORKDIR /tmp
RUN CONDA_VERSION="4.2.0" && \
    mkdir -p "$CONDA_DIR" && \
    wget -q "https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda2-${CONDA_VERSION}-Linux-x86_64.sh" -O installer.sh && \
    bash installer.sh -f -b -p "$CONDA_DIR" && \
    echo "export PATH=$CONDA_DIR/bin:\$PATH" > /etc/profile.d/conda.sh && \
    conda update --all --yes && conda clean --all --yes && \
    rm -rf /tmp/* /root/.wget-hists && \
    # 添加Anaconda的TUNA镜像
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/ &&\
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ && \
    # 设置搜索时显示通道地址  
    conda config --set show_channel_urls yes 

WORKDIR /
