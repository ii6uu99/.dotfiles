::google host update shell for Windows

::原理: 从github上下载google host，然后写到C:\Windows\System32\drivers\etc\hosts中，如果不相信脚本，可以 自己实现这个功能

::windows没有自带的脚本工具，所以需要先安装git bash来装上这些工具
::git bash 下载地址 https://git-scm.com/download 选择版本 安装
::之后将git安装目录下的usr\bin文件夹添加到环境变量中的path属性，可自行百度如何添加环境变量

::在该脚本上右键，以管理员身份运行即可

curl -O https://raw.githubusercontent.com/racaljk/hosts/master/hosts

cat hosts > C:\Windows\System32\drivers\etc\hosts

rm hosts

echo '如果提示curl、cat等命令找不到，请先阅读该脚本顶部的注释部分，如果正常请忽略'

pause

