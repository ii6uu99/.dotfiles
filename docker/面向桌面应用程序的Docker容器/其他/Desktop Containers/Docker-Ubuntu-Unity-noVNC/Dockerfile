FROM ubuntu:16.04
MAINTAINER Jacob <chenjr0719@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV USER ubuntu
ENV HOME /home/$USER

# 为vnc登录创建新用户。
RUN adduser $USER --disabled-password

# 安装Ubuntu Unity
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ubuntu-desktop \
        unity-lens-applications \
        gnome-panel \
        metacity \
        nautilus \
        gedit \
        xterm \
        sudo

# 安装依赖组件。
RUN apt-get install -y \
        supervisor \
        net-tools \
        curl \
        git \
        pwgen \
        libtasn1-3-bin \
        libglu1-mesa \
        libreoffice chromium-browser \
        apt-transport-https \
        nodejs \
        npm \
    && npm install -g typescript \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

# 关闭Chrome沙箱默认启动
RUN sed -i 's/Exec=chromium-browser %U/Exec=chromium-browser --no-sandbox %U/g' /usr/share/applications/chromium-browser.desktop

# 安装VS Code & dotnet core 2.0
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
    && mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg \
    && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod xenial main" > /etc/apt/sources.list.d/dotnetdev.list' \
    && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' \
    && apt-get update && apt-get install -y code dotnet-sdk-2.0.0 \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

＃添加PostgreSQL PGP密钥来验证他们的Debian软件包。
＃它应该是在同一个按键https://www.postgresql.org/media/keys/ACCC4CF8.asc
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
# ＃添加PostgreSQL的存储库。
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list
# 安装Postgres 9.6
RUN apt-get update \
    && apt-get install -y postgresql-9.6 postgresql-contrib-9.6 \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*
# 用`vircom43`作为密码创建一个名为``geotabuser``的PostgreSQL角色。
USER postgres
RUN service postgresql start \
    && psql --command "CREATE USER geotabuser WITH SUPERUSER PASSWORD 'vircom43';" \
    && createdb -O geotabuser geotabuser
USER root

# 复制tigerVNC二进制文件
ADD tigervnc-1.8.0.x86_64 /

# Clone noVNC.
RUN git clone https://github.com/novnc/noVNC.git $HOME/noVNC

# Clone websockify for noVNC
Run git clone https://github.com/kanaka/websockify $HOME/noVNC/utils/websockify

# 下载ngrok.
ADD https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip $HOME/ngrok/ngrok.zip
RUN unzip -o $HOME/ngrok/ngrok.zip -d $HOME/ngrok && rm $HOME/ngrok/ngrok.zip

# Copy supervisor config
COPY supervisor.conf /etc/supervisor/conf.d/

# Set xsession of Unity
COPY xsession $HOME/.xsession

# Copy startup script
COPY startup.sh $HOME

EXPOSE 6080 5901 4040
CMD ["/bin/bash", "/home/ubuntu/startup.sh"]
