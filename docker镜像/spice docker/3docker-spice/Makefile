# Copyright (C) 2017 AOSP/QEMU/SPICE build environment using docker
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#******************************************************************************
#
# Makefile - Make file for the docker build
#
# Copyright (c) 2017 Roger Ye.  All rights reserved.
#
#******************************************************************************
#
# Makefile to build and test docker containers
#   VOL1 - the one used to build source code
#   VOL2 - the one used to store build cache
# Both can be defined in your environment, otherwise the below default values
# will be used.

TAG_NAME = ubuntu14.04_qemu-m
DOCKER = docker
IMAGE = shugaoye/docker-spice:$(TAG_NAME)
VOL1 ?= $(HOME)/vol1
VOL2 ?= $(HOME)/.ccache
USER_ID := $(shell id -u)
GROUP_ID := $(shell id -g)

all: Dockerfile
	$(DOCKER) build -t $(IMAGE) .

run:
	$(DOCKER) run --privileged --name "$(TAG_NAME)-v1" -v /tmp/.X11-unix:/tmp/.X11-unix:ro -v "$(VOL1):/home/aosp" \
	-v "$(VOL2):/tmp/ccache" -it -e DISPLAY=$(DISPLAY) -e USER_ID=$(USER_ID) -e GROUP_ID=$(GROUP_ID) \
	$(IMAGE) /bin/bash

.PHONY: all
