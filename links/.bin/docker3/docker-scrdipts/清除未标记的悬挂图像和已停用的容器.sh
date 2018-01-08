#清除未标记的悬挂图像和已停用的容器
#我认为这样可以擦拭容器，所以要小心
docker rm $(docker ps -a -q)
docker rmi $(docker images -q --filter "dangling=true")
