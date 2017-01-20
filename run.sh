#!/bin/sh
VOLUME=$(pwd)/data
[ -d "$VOLUME" ] || mkdir "$VOLUME"

/usr/bin/docker run \
  -d \
  --name ts3 \
  --net=host \
  -v "$VOLUME":/ts3/data \
  neovatar/ts3:latest