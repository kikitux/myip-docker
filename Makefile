.Phony := all

image-alpine-sdk := $(shell docker images -q alpine-sdk)
image-alpine-sdk-aports := $(shell docker images -q alpine-sdk-aports)
image-alpine-sdk-aports-bash := $(shell docker images -q alpine-sdk-aports-bash)

image-myip := $(shell docker images -q myip)
image-builtin_myip := $(shell docker images -q builtin_myip)

default: test

all: image-alpine-sdk image-alpine-sdk-aports image-alpine-sdk-aports-bash myip.tar image-myip builtin_myip.tar image-builtin_myip

image-alpine-sdk:
ifndef image-alpine-sdk
	@packer build alpine-sdk.json
endif

image-alpine-sdk-aports:
ifndef image-alpine-sdk-aports
	@packer build alpine-sdk-aports.json
endif

image-alpine-sdk-aports-bash:
ifndef image-alpine-sdk-aports-bash
	@packer build alpine-sdk-aports-bash.json
endif

myip.tar: compile-cli.json
	@packer build compile-cli.json
	@-docker rmi -f myip
	@docker build -f Dockerfile.myip -t myip .

builtin_myip.tar: compile-builtin.json
	@packer build compile-builtin.json
	@-docker rmi -f builtin_myip
	@docker build -f Dockerfile.builtin_myip -t builtin_myip .

image-myip:
ifndef image-myip
	@docker build -f Dockerfile.myip -t myip .
endif

image-builtin_myip:
ifndef image-builtin_myip
	@docker build -f Dockerfile.builtin_myip -t builtin_myip .
endif

clean:
	@-rm myip.tar builtin_myip.tar
	@-docker rmi -f myip builtin_myip
	@-docker rmi -f alpine-sdk alpine-sdk-aports alpine-sdk-aports-bash

test: all
	docker run --rm myip -h
	docker run --rm myip -i eth0
	docker run --rm -i builtin_myip bash -l -c 'myip -h'
	docker run --rm -i builtin_myip bash -l -c 'myip -i eth0'
	docker run --rm -i builtin_myip bash -l -c 'myip -v myvar -i eth0 && echo "var myvar=$${myvar}"'
	docker run --rm -i builtin_myip bash -l -c 'for x in {1..2}; do myip -v myvar -i eth0; done && echo "var myvar=$${myvar}"'
	docker run --rm -i builtin_myip bash -l -c 'for x in {1..2}; do myip -v myvar -o -i eth0; done && echo "var myvar=$${myvar}"'

times ?= 2222

speed: all
	docker run --rm -i alpine time sh -c 'for x in `seq 1 $(times)`; do myvar="`ip addr show eth0 | grep 172 | cut -d" " -f6`"; done && echo "var myvar=$$myvar"'
	docker run --rm -i builtin_myip time bash -l -c 'for x in {1..$(times)}; do myip -v myvar -o -i eth0; done && echo "var myvar=$$myvar"'


