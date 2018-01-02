FROM alpine:3.6

ARG SCRAPY_VERSION

RUN apk --update add \
        python3 \
        ca-certificates \
        openssl \
        libxslt \
        libxml2 && \ 
    apk --update add --virtual \
        build-deps \
        python3-dev \
        build-base \
        libxslt-dev \
        libxml2-dev \
        libffi-dev \
        openssl-dev && \
    pip3 install scrapy${SCRAPY_VERSION} && \
    apk del build-deps && \
    rm -rf /var/cache/apk*
