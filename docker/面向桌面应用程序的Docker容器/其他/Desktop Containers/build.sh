#!/bin/bash

# docker build -t appsoa/docker-centos-desktop-webvnc:1.0 .
docker build --force-rm --no-cache -t appsoa/docker-centos-desktop-webvnc:latest .
