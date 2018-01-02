#!/bin/sh
set -e

# env
RMQ_USER=${RMQ_USER:-"user"}
RMQ_PWD=${RMQ_PWD:-"123456"}

rmq_wait()
{
    while ! nc -zw2 127.0.0.1 5672 || ! nc -zw2 127.0.0.1 4369 || ! nc -zw2 127.0.0.1 15672; do
    sleep 2
    done
}

# install plugins
rabbitmq-plugins enable --offline rabbitmq_management
sleep 3

# start server
rabbitmq-server &
RMQ_PID=$!
rmq_wait

# set user and pwd
if [ ! -z "$RMQ_USER" ] && [ ! -z "$RMQ_PWD" ]; then
    echo "****set user and pwd ****"
    rabbitmqctl add_user ${RMQ_USER} ${RMQ_PWD}
    rabbitmqctl set_user_tags ${RMQ_USER} administrator
    rabbitmqctl set_permissions -p / ${RMQ_USER} ".*" ".*" ".*"
fi

echo "******Done******"

wait $RMQ_PID 2> /dev/null