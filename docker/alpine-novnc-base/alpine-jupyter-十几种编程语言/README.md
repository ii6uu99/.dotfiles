
https://github.com/nbgallery/jupyter-docker



# jupyter-docker

This is a minimal docker image (currently 230 MB) for running the Jupyter notebook server.  It is hosted on [Docker Hub](https://hub.docker.com/r/nbgallery/jupyter-alpine/).

The small size is achieved by using the Alpine Linux base image and by installing language kernels on the fly.  We currently support about a dozen languages, but only Python 2 is baked into the image.  The other kernels are packaged into [apks](https://github.com/nbgallery/apks) that get [installed](kernels/installers) on first use.


jupyter - 泊坞窗

这是运行Jupyter笔记本服务器的最小码头镜像（当前为230 MB）。它托管在Docker Hub上。

通过使用Linux的高山基本映像和动态安装语言内核，实现了小尺寸，我们目前支持十几种语言，但是只有Python 2里才能被映射到映像中。与其他核打包成APK的的英文那些获得安装在首次使用。
