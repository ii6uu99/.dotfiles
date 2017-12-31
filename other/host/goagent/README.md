Linux终端输入sudo rcnscd restart关于systemd发行版，请使用命令sudo systemctl restart NetworkManager







# goagent
> host翻墙，用成本最低，配置最简单的方式实现科学上网，写给新人

---

实现原理(其实挺low的): 从github上下载google host，然后写到系统hosts中，这样浏览器访问google、facebook等网站时就不会走dns去外面寻址，直接读取hosts中的ip实现访问了

所以，基于原理，你可以完全不用使用上面那些脚本，自己实现hosts写入

1. Mac or Linux: 从[hosts](https://raw.githubusercontent.com/racaljk/hosts/master/hosts)下载hosts，复制所有内容到`/etc/hosts`即可【需要sudo权限，可以sudo vim /etc/hosts, 把内容粘进去即可】

2. Windows: 从[hosts](https://raw.githubusercontent.com/racaljk/hosts/master/hosts)下载hosts，复制所有内容到`C:\Windows\System32\drivers\etc\hosts`即可【写入时需要管理员权限，所以我一般先用管理员打开记事本，然后记事本再打开c盘中这个host文件，再粘贴保存就好了】

3. 访问google.com   facebook.com   twitter.com    gmail.com 试试吧

---

知道了原理，并且能认识到给的脚本都无害之后，你就可以不用像上面那样手动搞了，脚本一键执行即可，哈哈~
脚本有些细节地方需要注意，可以看看里面的注释，比如：

1. Mac && Linux 用户，需要先给脚本执行权限 `sudo chmod +x forMacAndLinux.sh`【仅第一次需要】,然后每次`./forMacAndLinux.sh`即可

2. Windows用户，这个，，不好办了，所以推荐安装git bash，他会补全一些windows中没有的工具，然后再执行bat脚本即可
	1. `git bash` 下载地址 https://git-scm.com/download 选择版本 安装
	2. 之后将git安装目录下的`usr\bin`文件夹添加到环境变量中的`path`属性，可自行百度如何添加环境变量
	3. 在脚本`fowWindows.bat`上右键，以管理员身份运行即可

