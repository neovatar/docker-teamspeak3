#!/bin/bash
set -e

echo "===> set locale to $LANG"
apt-get install --no-install-recommends -qy locales
sed -i -e "s/# $LANG UTF-8/$LANG UTF-8/" /etc/locale.gen
echo "LANG=\"$LANG\"">/etc/default/locale
dpkg-reconfigure --frontend=noninteractive locales
update-locale LANG=$LANG
