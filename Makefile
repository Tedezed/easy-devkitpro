SHELL := /bin/bash

all: git start

git:
	cd custom && git clone ${MAKE_URL}

start:
	docker-compose -f local.yaml up