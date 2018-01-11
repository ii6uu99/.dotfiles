# Pull base image
FROM ubuntu:14.04

#========================
#杂项包
#========================
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    ca-certificates \
    unzip \
    wget \
    vim  \
  && rm -rf /var/lib/apt/lists/*

#========================================
# 使用无密码sudo添加普通用户
#========================================
RUN sudo useradd user --shell /bin/bash --create-home \
  && sudo usermod -a -G sudo user \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'user:pazzword' | chpasswd

#============================
# 一些配置选项
#============================
ENV SCREEN_WIDTH 1680
ENV SCREEN_HEIGHT 1050
ENV SCREEN_DEPTH 24
ENV DISPLAY :0

#===============
# 谷歌浏览器
#===============
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install \
    google-chrome-stable \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/*

#=================================
# Chrome的启动脚本Modication
#=================================
COPY chrome_launcher.sh /opt/google/chrome/google-chrome
RUN chmod +x /opt/google/chrome/google-chrome

#=================================
# x11vnc
#=================================
#安装vnc，xvfb以创建一个“假”显示屏和firefox
RUN apt-get update -qqy
RUN apt-get install -y x11vnc xvfb

# 设置密码
USER user
RUN mkdir ~/.vnc
RUN x11vnc -storepasswd pazzword ~/.vnc/passwd
USER root

#=================
# 区域设置
#=================
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
RUN locale-gen en_US.UTF-8 \
  && dpkg-reconfigure --frontend noninteractive locales \
  && apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    language-pack-en \
  && rm -rf /var/lib/apt/lists/*

#=======
# 字体
#=======
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    fonts-ipafont-gothic \
    xfonts-100dpi \
    xfonts-75dpi \
    xfonts-cyrillic \
    xfonts-scalable \
  && rm -rf /var/lib/apt/lists/*

#=========
# fluxbox
# 一个快速，轻量级和响应式窗口管理器
#=========
RUN apt-get update -qqy \
  && apt-get -qqy install \
    fluxbox \
  && rm -rf /var/lib/apt/lists/*

#==============================
# 脚本运行
#==============================
COPY entry_point.sh /opt/bin/entry_point.sh
RUN chmod +x /opt/bin/entry_point.sh

EXPOSE 5900
USER user

ENTRYPOINT ["/opt/bin/entry_point.sh"]
