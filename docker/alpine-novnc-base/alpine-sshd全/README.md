# docker-alpine-sshd
建立
docker build -t ii6uu99/alpine-sshd .

清理
docker ps --filter=name=sshd && docker rm --force sshd

运行
docker run --name=sshd --detach --restart=always --publish=2222:22 \
           --volume=$HOME:/root \
           ekapusta/alpine-sshd
进入
docker exec -it sshd sh

调试
docker run --rm ekapusta/alpine-sshd

