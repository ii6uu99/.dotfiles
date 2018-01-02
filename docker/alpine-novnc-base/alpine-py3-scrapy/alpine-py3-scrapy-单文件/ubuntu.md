有关Scrapy的说明

安装

要在Ubuntu（或基于Ubuntu的）系统上安装scrapy，您需要安装这些依赖关系：

sudo apt-get install python-dev python -pip libxml2-dev libxslt1-dev zlib1g-dev libffi-dev libssl-dev
python-dev，zlib1g-dev，libxml2-dev和libxslt1-dev是lxml所必需的
密码学需要libssl-dev和libffi-dev
如果你想在Python 3上安装scrapy，你还需要Python 3的开发头文件：

sudo apt-get install python3 python3-dev
在virtualenv里面，你可以用pip安装Scrapy：

点安装scrapy
有用的链接

- [How to control the access a container has](https://medium.com/@mccode/understanding-how-uid-and-gid-work-in-docker-containers-c37a01d01cf)
