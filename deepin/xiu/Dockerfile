#https://github.com/mviereck/dockerfile-x11docker-deepin

FROM x11docker/deepin
ENV DEBIAN_FRONTEND noninteractive

# 使用root用户
USER root

RUN echo "deb [by-hash=force] http://mirrors.aliyun.com/deepin unstable main contrib non-free " > /etc/apt/sources.list &&\
echo "deb-src http://mirrors.aliyun.com/deepin unstable main contrib non-free">>/etc/apt/sources.list

#更新源
RUN apt-get update -y && apt-get upgrade -y

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
RUN apt-get install -y fonts-arphic-uming sudo

# 添加具有免密码sudo权限的普通用用户,chpasswd这项是修改密码的
RUN useradd ming --shell /bin/bash --create-home \
  && usermod -a -G sudo ming \
  && echo 'ming ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'ming:ming' | chpasswd

#安装docker
ADD aliyun.sh /usr/bin/aliyun.sh
RUN chmod +x /usr/bin/aliyun.sh &&\
    sh aliyun.sh

CMD start
