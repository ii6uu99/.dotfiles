https://github.com/oott123/docker-novnc.git

igervnc，websokify，novnc和Nginx的在码头图像中的S6覆盖。

环境变量
VNC_GEOMETRY- VNC几何; 默认：800x600
VNC_PASSWD- VNC密码，不超过8个字符; 默认：MAX8char
USER_PASSWD- 用户user密码。如果您指定它，它将更改用户的密码user并将其添加到sudoers。注意：该密码可以通过程序获得，因此不安全。默认:( 空白）
端口
5911 - tigervnc
9000 - Nginx
9001 - websockify
添加你的前台进程
vncmain.sh 是在VNC中运行的前台进程占位符的文件。

你可以这样写一个Dockerfile：

从 oott123 / novnc：最新的
  COPY vncmain.sh /app/vncmain.sh
并在你的下面添加前台命令vncmain.sh：

＃！ / bin / bash 
＃将它们设置为空不是安全的，但避免它们显示在随机日志中。
导出 VNC_PASSWD = ' '
导出 USER_PASSWD = ' '

的的xterm
然后构建并运行您的泊坞窗图像。而已！
