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
myip                latest              2cb1f1bea19b        28 seconds ago      357.8 kB
kikitux@nuc:~/Dropbox/work/docker/myip$ 

```

hint: 357.8 KB
