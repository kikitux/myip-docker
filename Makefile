.Phony := all

image-alpine-sdk := $(shell docker images -q alpine-sdk)
image-myip := $(shell docker images -q myip)

all: image-alpine-sdk myip image-myip

image-alpine-sdk:
ifndef image-alpine-sdk
	@packer build alpine-sdk.json
endif

myip: myip-build.json
	@packer build myip-build.json
	@-docker rmi -f myip
	@docker build -t myip .

image-myip:
ifndef image-myip
	@docker build -t myip .
endif

clean:
	@-rm myip
	@-docker rmi -f myip

test: all
	-docker run --rm myip
