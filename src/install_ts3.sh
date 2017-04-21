#!/bin/bash
set -e
TS3_ARCHIVE=/tmp/teamspeak3-server_linux_amd64-$TS3_VERSION.tar.bz2
TS3_DOWNLOAD_URL=http://dl.4players.de/ts/releases/$TS3_VERSION/$(basename $TS3_ARCHIVE)
TS3_PATH=/ts3

echo "===> install ts3 version $TS3_VERSION"
useradd -u $TS3_UID ts3
mkdir -p /ts3
curl -sSL -o $TS3_ARCHIVE $TS3_DOWNLOAD_URL
echo "$TS3_SHA256 $TS3_ARCHIVE" | sha256sum -c -
tar xvjf $TS3_ARCHIVE -C $TS3_PATH
rm $TS3_ARCHIVE
mkdir -p $TS3_PATH/data/logs
mkdir -p $TS3_PATH/data/files
ln -s $TS3_PATH/data/ts3server.sqlitedb $TS3_PATH/teamspeak3-server_linux_amd64/ts3server.sqlitedb
ln -s $TS3_PATH/data/licensekey.dat $TS3_PATH/teamspeak3-server_linux_amd64/licensekey.dat
ln -s $TS3_PATH/data/serverkey.dat /ts3/teamspeak3-server_linux_amd64/serverkey.dat
chown -R ts3 $TS3_PATH
mkdir /etc/services.d/ts3
cp ts3/run /etc/services.d/ts3/run
cp ts3/finish /etc/services.d/ts3/finish
cp ts3/01-ts3-data  /etc/fix-attrs.d/01-ts3-data
