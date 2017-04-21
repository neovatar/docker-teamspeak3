#!/bin/bash
set -e
BASE_PACKAGES="curl bzip2 ca-certificates apt-transport-https"

echo "===> install base packages: $BASE_PACKAGES"
apt-get install --no-install-recommends -qy $BASE_PACKAGES
