#!/bin/bash
set -e

echo "===> set timezone to $TZ"
apt-get install --no-install-recommends -qy tzdata
rm /etc/localtime
ln -s /usr/share/zoneinfo/$TZ /etc/localtime
dpkg-reconfigure --frontend=noninteractive tzdata
