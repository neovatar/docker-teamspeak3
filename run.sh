#!/bin/sh
set -x
VOLUME=$(pwd)/data
REPOSITORY=$(cat REPOSITORY)
BUILDTAG=$(cat BUILDTAG)
[ -d "$VOLUME" ] || mkdir "$VOLUME"

/usr/bin/docker run \
  -ti \
  --rm \
  --name ts3 \
  --net=host \
  -v "$VOLUME":/ts3/data \
  $REPOSITORY:$BUILDTAG
