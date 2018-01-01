用于Python中的中的基于高山的Dockerimage和SciPy的的的堆叠

这个仓库包含一个Dockerfile，用于构建一个基于Alpine 3.4和Python 3.6的python图像

它提供了以下的的的的Python库：
- numpy (numpy==1.13.1)
- pandas (pandas==0.20.3)
- scipy (scipy==0.19.1)
- scikit-learn (scikit-learn[alldeps]==0.18.2)
To build the image execute the following command in the repository root directory:

构建命令
docker build -t ii6uu99/alpine-science .
```

dockerhub 中的 nikeee/alpine-python3-scipy 作为基础镜像
