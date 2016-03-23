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
	@-rm myip.tar
	@-docker rmi -f myip
	@-docker rmi -f alpine-sdk
	@-docker rmi -f alpine-sdk-aports

test: all
	-docker run --rm myip -h
	-docker run --rm myip -i eth0
	-docker run --rm -i builtin_myip bash -c 'enable -f root/builtin_myip builtin_myip && myip -h'
	-docker run --rm -i builtin_myip bash -c 'enable -f root/builtin_myip builtin_myip && myip -i eth0'
	-docker run --rm -i builtin_myip bash -c 'enable -f root/builtin_myip builtin_myip && myip -v myvar -i eth0 && echo "var myvar=$${myvar}"'

