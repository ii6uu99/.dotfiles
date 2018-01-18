#https://github.com/mviereck/dockerfile-x11docker-deepin

FROM deepin/deepin-core
ENV DEBIAN_FRONTEND noninteractive

# 使用root用户
USER root

RUN echo "deb [by-hash=force] http://mirrors.aliyun.com/deepin unstable main contrib non-free " > /etc/apt/sources.list &&\
echo "deb-src http://mirrors.aliyun.com/deepin unstable main contrib non-free">>/etc/apt/sources.list

#更新源
RUN apt-get update -y && apt-get install -y apt-utils && apt-get upgrade -y

# 配置中文语言
ENV LANGUAGE zh_CN.UTF-8
ENV LANG zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8
RUN /usr/share/locales/install-language-pack zh_CN \
  && locale-gen zh_CN.UTF-8 \
  && dpkg-reconfigure --frontend noninteractive locales \
  && apt-get -qqy --no-install-recommends install language-pack-zh-hans

# 设置时区
ENV TZ "PRC"
RUN echo "Asia/Shanghai" | tee /etc/timezone \
  && dpkg-reconfigure --frontend noninteractive tzdata

# 中文字体
RUN apt-get install -y fonts-arphic-uming

# 添加具有免密码sudo权限的普通用用户,chpasswd这项是修改密码的
RUN useradd ming --shell /bin/bash --create-home \
  && usermod -a -G sudo ming \
  && echo 'ming ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'ming:ming' | chpasswd

# deepin桌面dde
RUN apt-get install -y --no-install-recommends dde

# 缺少依赖，dconf，mesa
RUN apt-get install -y --no-install-recommends at-spi2-core dbus-x11 dconf-cli dconf-editor \
    gnome-themes-standard gtk2-engines-murrine gtk2-engines-pixbuf \
    mesa-utils mesa-utils-extra

# 附加应用程序
RUN apt-get install -y deepin-calculator deepin-image-viewer deepin-screenshot \
    deepin-system-monitor deepin-terminal deepin-movie deepin-music \
    gedit sudo synaptic oneko

#添加路径环境变量
ENV DEBIAN_FRONTEND newt
ENV PATH /usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/games:/usr/games

# Mask units在容器中失败
RUN systemctl mask \
    bluetooth \
    iptables \
    systemd-hostnamed \
    systemd-tmpfiles-setup

# 在容器中使用Mask units
RUN systemctl mask \
    lastore-daemon lastore-update-metadata-info \
    NetworkManager \
    plymouth-start plymouth-read-write plymouth-quit plymouth-quit-wait

# 删除不必要的软件和Apt缓存包列表
RUN apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*


#删除dbus服务失败或无用的容器。（蓝牙/蓝牙是最烦人的）
RUN cd /usr/share/dbus-1/services && rm \
    com.deepin.daemon.Audio.service \
    com.deepin.daemon.Bluetooth.service \
    com.deepin.daemon.InputDevices.service \
    com.deepin.daemon.Power.service \
    com.deepin.dde.welcome.service
RUN cd /usr/share/dbus-1/system-services && rm \
    org.bluez.service \
    com.deepin.lastore.service

# config文件中使用deepin-WM具有3D效果
RUN echo '{\n\
    "last_wm": "deepin-wm"\n\
}\n\
' >/wm3d.json

#安装docker
ADD aliyun.sh /usr/bin/aliyun.sh
RUN chmod +x /usr/bin/aliyun.sh &&\
    sh aliyun.sh

# 创建start脚本
RUN echo '#! /bin/sh\n\
[ -e "$HOME/.config" ] || cp -R /etc/skel/. $HOME/ \n\
[ -e /dev/dri/card0 ] && { \n\
  mkdir -p $HOME/.config/deepin/deepin-wm-switcher \n\
  cp -n /wm3d.json $HOME/.config/deepin/deepin-wm-switcher/config.json \n\
} \n\
dconf write /com/deepin/dde/daemon/network false \n\
dconf write /com/deepin/dde/daemon/bluetooth false \n\
dconf write /com/deepin/dde/watchdog/dde-polkit-agent false \n\
dconf write /com/deepin/dde/daemon/power false \n\
exec startdde \n\
' > /usr/bin/start 
RUN chmod +x /usr/bin/start 

CMD start
