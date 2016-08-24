MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
PROJECT_PATH := $(patsubst %/,%,$(dir $(MKFILE_PATH)))

DOCKER_USER := user
DOCKER_APP_HOME := /home/$(DOCKER_USER)
DOCKER_PROJECT_PATH := $(DOCKER_APP_HOME)/app

default: test

build:
	docker build -t xcflushd $(PROJECT_PATH)

test: build
	docker run -t xcflushd

bash: build
	docker run -t -i -v $(PROJECT_PATH):$(DOCKER_PROJECT_PATH) xcflushd /bin/bash
