## 👋 Welcome to nodejs 🚀  

nodejs README  
  
  
## Install my system scripts  

```shell
 sudo bash -c "$(curl -q -LSsf "https://github.com/systemmgr/installer/raw/main/install.sh")"
 sudo systemmgr --config && sudo systemmgr install scripts  
```
  
## Automatic install/update  
  
```shell
dockermgr update nodejs
```
  
## Install and run container
  
```shell
dockerHome="/var/lib/srv/$USER/docker/casjaysdevdocker/nodejs/nodejs/latest/rootfs"
mkdir -p "/var/lib/srv/$USER/docker/nodejs/rootfs"
git clone "https://github.com/dockermgr/nodejs" "$HOME/.local/share/CasjaysDev/dockermgr/nodejs"
cp -Rfva "$HOME/.local/share/CasjaysDev/dockermgr/nodejs/rootfs/." "$dockerHome/"
docker run -d \
--restart always \
--privileged \
--name casjaysdevdocker-nodejs-latest \
--hostname nodejs \
-e TZ=${TIMEZONE:-America/New_York} \
-v "$dockerHome/data:/data:z" \
-v "$dockerHome/config:/config:z" \
-p 80:80 \
casjaysdevdocker/nodejs:latest
```
  
## via docker-compose  
  
```yaml
version: "2"
services:
  ProjectName:
    image: casjaysdevdocker/nodejs
    container_name: casjaysdevdocker-nodejs
    environment:
      - TZ=America/New_York
      - HOSTNAME=nodejs
    volumes:
      - "/var/lib/srv/$USER/docker/casjaysdevdocker/nodejs/nodejs/latest/rootfs/data:/data:z"
      - "/var/lib/srv/$USER/docker/casjaysdevdocker/nodejs/nodejs/latest/rootfs/config:/config:z"
    ports:
      - 80:80
    restart: always
```
  
## Get source files  
  
```shell
dockermgr download src casjaysdevdocker/nodejs
```
  
OR
  
```shell
git clone "https://github.com/casjaysdevdocker/nodejs" "$HOME/Projects/github/casjaysdevdocker/nodejs"
```
  
## Build container  
  
```shell
cd "$HOME/Projects/github/casjaysdevdocker/nodejs"
buildx 
```
  
## Authors  
  
🤖 casjay: [Github](https://github.com/casjay) 🤖  
⛵ casjaysdevdocker: [Github](https://github.com/casjaysdevdocker) [Docker](https://hub.docker.com/u/casjaysdevdocker) ⛵  
