# Docker

Test if docker runs
```
# @see: https://hub.docker.com/_/centos/
docker pull centos:7
docker run -i -t centos /bin/bash
```

Build the docker image and export it.
```
cd /path/to/happy-deployer/docker/centos-7-systemd
#docker build --rm -t happy-deployer/c7$(date +%Y%m) .
docker build --rm -t happy-deployer/c7201608 .

docker save happy-deployer/c7201608 | gzip > centos-7-201608.docker.tgz
md5sum -b centos-7-201608.docker.tgz > centos-7-201608.docker.tgz.md5
```

You can import your docker images by using the load command.
```
zcat centos-7-201608.docker.tgz | docker load
```
