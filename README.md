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
$ docker images myip 
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
myip                latest              514f7415b920        About an hour ago   6.694 MB
$ 
```

hint: 6.6 MB
