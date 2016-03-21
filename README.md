# myip-docker
repo to build a docker container for myip-cli

## build

make

## test

make test

ie:
```bash
$ make test
docker run --rm myip
202.202.202.111
```

## generated docker 

```bash
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
myip                latest              7e53a5d0d95a        13 seconds ago      5.51 MB
```

hint: 5.5 MB
