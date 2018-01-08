https://github.com/unixorn/docker-helpers.zshplugin

DocToc生成的目录

码头工人，佣工
安装
抗原
哦，我，岩组
zgen
泊坞窗助手脚本
其他有用的多克的东西
码头工人，佣工
这是一个码头辅助程序脚本的集合，打包成一个zsh中的插件，使其更容易与抗原一起使用。

其中大部分是从博客文章，要点等收集来的，我已经在我知道源代码的地方给予了信任。

安装
抗原
添加antigen bundle unixorn/docker-helpers.zshplugin到您.zshrc的其他插件。您可以通过antigen bundle unixorn/docker-helpers.zshplugin在正在运行的zsh会话中运行来测试驱动器，而无需编辑.zshrc 。

哦，我，岩组
cd到你的oh-my-zsh插件目录（〜/ .oh-my-zsh / custom / plugins）
git clone https://github.com/unixorn/docker-helpers.zshplugin docker-helpers
将泊坞窗，助手添加到您的插件中 .zshrc
...
plugins =（... docker-helpers ...）
...
zgen
添加zgen load unixorn/docker-helpers.zshplugin到你.zshrc加载其他插件的地方。

泊坞窗助手脚本
命令	描述	信用
boot2docker，时间同步	每当我的MacBook Pro睡眠时，boot2docker都会失去时间同步。运行这个重新同步	
搬运工容器体积	列出附加到容器的卷	http://www.tech-d.net/2014/05/05/docker-quicktip-5-backing-up-volumes/）
搬运工创建备份容器	使用主机上所有容器的所有卷创建一个容器	[From http://www.tech-d.net/2014/05/05/docker-quicktip-5-backing-up-volumes/](From http://www.tech-d.net/2014/05 / 05 / docker-quicktip-5-backing-up-volumes /）
泊坞窗 - 删除 - 停容器	清理陈旧停止的容器	
泊坞窗进入	安装/运行jpetazzo的nsenter	
搬运工，最后	打印您运行的最后一个容器的ID	
搬运工 - 吹扫无名图像	通过删除所有未命名的图像来清理图像。	
泊坞窗，超净	清除任何停止的容器或陈旧的图像	
其他有用的多克的东西
如果你使用崇高的文字2/3，看看崇高码头。允许您直接从Sublime Text Docker容器。
