#!/bin/bash
set -e

IMAGE_REPOSITORY=neovatar/ts3
export TS3_UID=$(id -u teamspeak || echo 1000)

[ -f REPOSITORY ] && rm REPOSITORY
[ -f BUILDTAG ] && rm BUILDTAG

UUID=$(cat /proc/sys/kernel/random/uuid)
TIMESTAMP=$(date +%Y%m%d%H%M%S)

docker build --no-cache=true -t $IMAGE_REPOSITORY:$UUID .

IMAGE_TAG=$(docker inspect $IMAGE_REPOSITORY:$UUID | jq -r '.[0] | .ContainerConfig.Labels.ts3_version')-$TIMESTAMP
docker tag $IMAGE_REPOSITORY:$UUID $IMAGE_REPOSITORY:$IMAGE_TAG
docker rmi $IMAGE_REPOSITORY:$UUID

echo $IMAGE_REPOSITORY > REPOSITORY
echo $IMAGE_TAG > BUILDTAG
