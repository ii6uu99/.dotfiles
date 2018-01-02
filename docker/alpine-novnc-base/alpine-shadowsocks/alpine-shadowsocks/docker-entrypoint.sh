#!/bin/sh

SERVER_ADDR=${SERVER_ADDR:-"0.0.0.0"}
METHOD=${METHOD:-"aes-256-cfb"}
PASSWORD=${PASSWORD:-"shadowsocks"}

echo "***** Run with Password [${PASSWORD}] and Method [${METHOD}] *****"

ss-server -s ${SERVER_ADDR} -p "8388" -m ${METHOD} -k ${PASSWORD} -u --fast-open