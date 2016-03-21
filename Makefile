.Phony := all

image-alpine-sdk := $(shell docker images -q alpine-sdk)
image-myip := $(shell docker images -q myip)

all: image-alpine-sdk myip.tar image-myip

image-alpine-sdk:
ifndef image-alpine-sdk
	@packer build alpine-sdk.json
endif

myip.tar: compile.json
	@packer build compile.json
	@-docker rmi -f myip
	@docker build -t myip .

image-myip:
ifndef image-myip
	@docker build -t myip .
endif


clean:
	@-rm myip
	@-docker rmi -f myip.tar
	@-docker rmi -f alpine-sdk

test: all
	-docker run --rm myip
