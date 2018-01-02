# Supported tags and respective `Dockerfile` links

  * [`latest` (Dockerfile)](https://github.com/wernight/docker-compose/blob/master/Dockerfile) [![](https://images.microbadger.com/badges/image/wernight/docker-compose.svg)](https://microbadger.com/images/wernight/docker-compose "Get your own image badge on microbadger.com")
  * [`1`, `1.8`, `1.8.0`, (Dockerfile)](https://github.com/wernight/docker-compose/blob/v1.8.0/Dockerfile) [![](https://images.microbadger.com/badges/image/wernight/docker-compose:1.8.svg)](https://microbadger.com/images/wernight/docker-compose "Get your own image badge on microbadger.com")
  * [`1.7`, `1.7.1` (Dockerfile)](https://github.com/wernight/docker-compose/blob/v1.7.1/Dockerfile) [![](https://images.microbadger.com/badges/image/wernight/docker-compose:1.7.svg)](https://microbadger.com/images/wernight/docker-compose "Get your own image badge on microbadger.com")
  * [`1.6`, `1.6.2` (Dockerfile)](https://github.com/wernight/docker-compose/blob/v1.6.2/Dockerfile) [![](https://images.microbadger.com/badges/image/wernight/docker-compose:1.6.svg)](https://microbadger.com/images/wernight/docker-compose "Get your own image badge on microbadger.com")
  * [`1.5`, `1.5.2` (Dockerfile)](https://github.com/wernight/docker-compose/blob/v1.5.2/Dockerfile) [![](https://images.microbadger.com/badges/image/wernight/docker-compose:1.5.svg)](https://microbadger.com/images/wernight/docker-compose "Get your own image badge on microbadger.com")

Note: This is similar to [docker/compose](https://hub.docker.com/r/docker/compose/) image, but this image is based on Alpine on an auto-build.

## What is `docker-compose`

[Docker Compose](https://docs.docker.com/compose/) Docker Compose在开发过程中很有用，可以简化构造和运行链接的Docker镜像

## 用法

    $ docker run --rm \
        -v /var/run/docker.sock:/var/run/docker.sock:ro \
        -v $PWD:/code:ro \
        wernight/docker-compose build

  - **Entrypoint** is `docker-compose` so do **not** run `wernight/docker-compose docker-compose`.
  - `/code是当前的默认工作目录
  - You can **run as any user**, for example as yourself by adding `--user $UID:$GID`.

可以您像任何用户一样运行，例如通过添加--user $UID:$GID。
### Alias
你如果docker-compose直接运行，你可以设置别名来运行。这是一个适用于击/ ZSH的函数（除了名字，它是POSIX兼容的）：


    docker-compose () {
      DIRNAME=$"$(basename \"$PWD\")"
      docker run --rm -it \
        -v /var/run/docker.sock:/var/run/docker.sock:ro \
        -w "/$DIRNAME" -v "$PWD":"/$DIRNAME":ro \
        wernight/docker-compose "$@"
    }

