#!/bin/bash
set -e
set -x

IMAGE_REPOSITORY=$(cat REPOSITORY)
IMAGE_TAG=$(cat BUILDTAG)

docker tag "${IMAGE_REPOSITORY}:${IMAGE_TAG}" "${IMAGE_REPOSITORY}:latest"
