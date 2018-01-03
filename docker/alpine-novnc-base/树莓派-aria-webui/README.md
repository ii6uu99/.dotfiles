webui-aria2
===========

![Main interface](/screenshots/overview.png?raw=true)

这个项目的目标是创造世界上最好和最热门的界面来与aria2互动。aria2是世界上最好的文件下载器，但有时命令行会带来更多的功能。该项目最初是作为GSOC计划的一部分而创建的，但是它在aria2社区的大力支持和反馈下迅速发展和变化。

使用非常简单，不需要构建脚本，也不需要安装脚本。首先在本地机器或远程机器的后台启动aria2。你可以这样做，如下所示：
````bash
aria2c --enable-rpc --rpc-listen-all
````
如果aria2未安装在您的本地计算机上，请转到https://aria2.github.io/并按照说明进行操作。

然后下载webui，你可以通过下载这个版本库并在浏览器中运行index.html。或者你可以直接去http://ziahamza.github.io/webui-aria2/并开始下载文件！之后，您还可以通过保存浏览器保存页面作为选项将其保存为脱机使用。

提示

您可以随时选择要下载哪些文件以防止种子或metalinks。只要暂停下载，应该会在设置按钮旁边出现一个列表图标。要在开始下载之前选择要下载的文件，请将标志--pause-metadata指定给aria2。请参阅链接
组态

阅读并编辑configuration.js。

DirectURL

此功能允许用户直接从webui仪表板下载从aria2下载的文件。如果您熟悉网络服务器的工作方式，请设置指向已配置的aria2下载目录的http服务器，检查权限。然后http://server:port/在webui directURL配置中指定一个完整的url：

如果上述不明显，请继续阅读directurl.md中的内容

依赖

那么，你需要aria2。和一个网页浏览器（如果这甚至是重要的！）


Docker support
==============
您也可以在Docker沙箱内的LAN中尝试或使用webui-aria2。

建立图像

````bash
sudo docker build -t yourname/webui-aria2 .
````

运行它！它将在以下地址提供：http://localhost:9100

````bash
sudo docker run -v /Downloads:/data -p 6800:6800 -p 9100:8080 --name="webui-aria2" yourname/webui-aria2
````

`/Downloads`  是要保留下载的文件的主机中的目录


