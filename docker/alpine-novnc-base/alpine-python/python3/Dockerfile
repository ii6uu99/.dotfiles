# alpine linux with python3

FROM youske/alpine-stdmachine:base
MAINTAINER youske miyakoshi <youske@gmail.com>

LABEL com.stdmachine.description="alpine python3 image" \
      com.stdmachine.role="python3 image"

RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -rf /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools virtualenv && \
    rm -rf /root/.cache /tmp/*
