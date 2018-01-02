#!/bin/sh

kcptun -t "127.0.0.1:8388" -l ":29900" -mode fast2 > /dev/null 2>&1 &

ss-server -s "0.0.0.0" -p "8388" -m "aes-256-cfb" -k "test123" --fast-open

# 配置信息



if [ "$KCP_FLAG" == "true" ] && [ "$KCP_CONFIG" != "" ]; then
    echo -e "\033[32mStarting kcptun......\033[0m"
    kcptun $KCP_CONFIG 2>&1 &
else
    echo -e "\033[33mKcptun not started......\033[0m"
fi

echo -e "\033[32mStarting shadowsocks......\033[0m"
if [ "$SS_CONFIG" != "" ]; then
    $SS_MODULE $SS_CONFIG
else
    echo -e "\033[31mError: SS_CONFIG is blank!\033[0m"
    exit 1
fi

