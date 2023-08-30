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
mkdir -p "$HOME/.local/share/srv/docker/nodejs/rootfs"
git clone "https://github.com/dockermgr/nodejs" "$HOME/.local/share/CasjaysDev/dockermgr/nodejs"
cp -Rfva "$HOME/.local/share/CasjaysDev/dockermgr/nodejs/rootfs/." "$HOME/.local/share/srv/docker/nodejs/rootfs/"
docker run -d \
--restart always \
--privileged \
--name casjaysdevdocker-nodejs \
--hostname nodejs \
-e TZ=${TIMEZONE:-America/New_York} \
-v "$HOME/.local/share/srv/docker/casjaysdevdocker-nodejs/rootfs/data:/data:z" \
-v "$HOME/.local/share/srv/docker/casjaysdevdocker-nodejs/rootfs/config:/config:z" \
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
      - "$HOME/.local/share/srv/docker/casjaysdevdocker-nodejs/rootfs/data:/data:z"
      - "$HOME/.local/share/srv/docker/casjaysdevdocker-nodejs/rootfs/config:/config:z"
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
