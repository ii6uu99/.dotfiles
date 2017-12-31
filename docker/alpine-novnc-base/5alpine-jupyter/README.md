dockerfile alpine with jupyter
==============================

# base images
youske/alpine-conda

# run
docker-compose up --no-color --no-deps jupyterimage

1. docker run youske/alpine-jupyter
2. root権限で動作
3. /jupyter_notebookをホームディレクトリとする


# volume
/jupyter_notebookにマウントさせるとnotebookのルートとなるため
以下のようにデータコンテナを作り

    docker run -it -v /jupyter_notebook busybox -t jupyternotebook_container

--volumes-fromを利用してjupyterコンテナ側の起動設定を変更する

    docker run -it --volumes-from jupyternotebook_container youske/alpine-jupyter


# 諸設定
利便性のためにこのイメージには次のカーネルを初期インストールしている

  + metakernel_bash
  + metakernel_python
  + redis_kernel
