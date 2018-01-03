#https://github.com/buuhsmead/alpine-openjdk8
# Alpine Linux - OpenJDK8 Dockerfile
#

FROM alpine:latest

MAINTAINER Huub Daems <buuhsmead@gmail.com>

ENV JAVA_HOME=/usr/lib/jvm/default-jvm

RUN apk add --no-cache openjdk8 && ln -sf "${JAVA_HOME}/bin/"* "/usr/bin/"

RUN java -Xshare:dump
