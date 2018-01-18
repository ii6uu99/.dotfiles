https://github.com/dockerhome/bin.git


Dockerhome共享脚本来帮助您使用Docker！

安全
发现任何安全问题？给我们发电子邮件到contact@budhi.com.br我们将会感激！

脚本
1.设置主机（文件：set_host.sh）
如果可以的话，这个脚本将发布你的活动docker容器到/ etc / hosts。

您必须拥有root权限才能使用此脚本

为什么我们需要这个？那么，每次你重新启动一台机器或停止一个容器并重新开始，它可能会改变你的容器的IP地址。在某些情况下，例如在本地服务器上运行某些服务，您可能希望将容器发布到本地计算机上，以便通过容器名称而不是IP地址进行访问。

用法
sudo ./set_hosts.sh
这样你将发布所有活动的容器到你的/ etc / hosts文件中，如果你只想发布onde容器，只需添加容器名称：

sudo ./set_hosts.sh srv-elasticsearch-001
如果您将在cron中使用它，我们建议您对输出结果进行评论，我们将很快发布一个新的版本。

积分
在其中一项研究中，我们得到了一个名为@steeldriver的StackOverFlow用户的帮助，请查看帖子。
