FROM x11vnc
MAINTAINER FanLin <linfan.china@gmail.com>

# 安装Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install google-chrome-stable

# 设置启动命令
ENV APP_START "/opt/google/chrome/chrome infoq.com.cn"
