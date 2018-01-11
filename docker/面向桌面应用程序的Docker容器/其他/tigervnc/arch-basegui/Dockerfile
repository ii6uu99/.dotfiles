FROM binhex/arch-base:2017102500
MAINTAINER binhex

# 附加文件
##################

# 添加管理员conf文件的应用程序
ADD build/*.conf /etc/supervisor/conf.d/

# 添加安装bash脚本
ADD build/root/*.sh /root/

# 添加bash脚本来运行 deluge
ADD run/nobody/*.sh /home/nobody/

# add pre-configured配置for nobody
ADD config/nobody/ /home/nobody/

# 安装应用程序
#############

# 使可执行文件运行bash脚本来安装应用程序
RUN chmod +x /root/*.sh && \
	/bin/bash /root/install.sh

# docker设置
#################

# 地图/配置来承载定义配置路径（用于存储配置从应用程序）
VOLUME /config

#为vnc客户端公开端口（直接连接）
EXPOSE 5900

# 暴露novnc的端口（网络界面）
EXPOSE 6080

# env
#####

#为用户nobody设置环境变量
ENV HOME /home/nobody

#设置终端的环境变量
ENV TERM xterm

#为语言设置环境变量
ENV LANG en_GB.UTF-8
