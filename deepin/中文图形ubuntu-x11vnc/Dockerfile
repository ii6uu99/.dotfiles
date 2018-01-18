FROM ubuntu:14.04
MAINTAINER FanLin <linfan.china@gmail.com>

# 使用root用户
USER root

# 使用Ubuntu官方的Apt-get源
RUN  echo "deb http://archive.ubuntu.com/ubuntu trusty main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu trusty-updates main universe\n" >> /etc/apt/sources.list

# 更新源
RUN apt-get update -qqy

# 配置中文语言
ENV LANGUAGE zh_CN.UTF-8
ENV LANG zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8
RUN /usr/share/locales/install-language-pack zh_CN \
  && locale-gen zh_CN.UTF-8 \
  && dpkg-reconfigure --frontend noninteractive locales \
  && apt-get -qqy --no-install-recommends install language-pack-zh-hans

# 安装基本字体
RUN apt-get -qqy --no-install-recommends install \
    fonts-ipafont-gothic \
    xfonts-100dpi \
    xfonts-75dpi \
    xfonts-cyrillic \
    xfonts-scalable

# 安装文泉驿微米黑字体
RUN apt-get -qqy install ttf-wqy-microhei \
  && ln /etc/fonts/conf.d/65-wqy-microhei.conf /etc/fonts/conf.d/69-language-selector-zh-cn.conf

# 设置时区
ENV TZ "PRC"
RUN echo "Asia/Shanghai" | tee /etc/timezone \
  && dpkg-reconfigure --frontend noninteractive tzdata

# 添加具有免密码sudo权限的普通用用户
RUN useradd linfan --shell /bin/bash --create-home \
  && usermod -a -G sudo linfan \
  && echo 'linfan ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'linfan:pa55w0rd' | chpasswd

# 安装其他基础软件
RUN apt-get -qqy --no-install-recommends install curl wget

# 删除不必要的软件和Apt缓存包列表
RUN apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*



##################UI###########################

# 更新源
RUN apt-get update -qqy

# 安装 VNC、Xvfb 和 Fluxbox
RUN apt-get -qqy install x11vnc xvfb fluxbox

# 生成Hash过的密码文件
RUN mkdir -p ~/.vnc \
  && x11vnc -storepasswd pa55w0rd4vnc ~/.vnc/passwd

# 删除不必要的软件和Apt缓存包列表
RUN apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# 屏蔽交互界面
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

# 屏幕尺寸和颜色深度
ENV SCREEN_WIDTH 1360
ENV SCREEN_HEIGHT 1020
ENV SCREEN_DEPTH 24

# 可以使用任意Unix套接字编号
ENV DISPLAY :99.0

# 暴露VNC的端口
EXPOSE 5900

# 拷贝启动脚本
COPY entry_point.sh /opt/bin/entry_point.sh
RUN chmod +x /opt/bin/entry_point.sh

CMD ["/opt/bin/entry_point.sh"]


#docker build -t x11vnc .
































