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
REPOSITORY          TAG                 IMAGE ID            CREATED              SIZE
myip                latest              282f4b921dc8        About a minute ago   46.67 kB
```

hint: 46.67 KB

### sample run

```bash
kikitux@nuc:~/Dropbox/work/docker/myip$ docker run --rm myip -h
use: /myip [-6] [-i ethN]
kikitux@nuc:~/Dropbox/work/docker/myip$ docker run --rm myip -i eth0
172.17.0.2
kikitux@nuc:~/Dropbox/work/docker/myip$ docker run --rm myip
202.202.202.151
kikitux@nuc:~/Dropbox/work/docker/myip$ 
```
