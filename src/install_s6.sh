#!/bin/bash
set -e

S6OVERLAY_VERSION="1.19.1.1"
S6OVERLAY_SHA256="b5d360383dd519a33bd39651c43c49b4cf0e95344a94ba65dd8628eefd9ee5cb"
S6OVERLAY_ARCHIVE=/tmp/s6-overlay-amd64.tar.gz
S6OVERLAY_URL=https://github.com/just-containers/s6-overlay/releases/download/v$S6OVERLAY_VERSION/$(basename $S6OVERLAY_ARCHIVE)

echo "===> install s6 overlay v$S6OVERLAY_VERSION"
curl -sSL -o $S6OVERLAY_ARCHIVE $S6OVERLAY_URL
echo "$S6OVERLAY_SHA256 $S6OVERLAY_ARCHIVE" | sha256sum -c -
tar xvzf $S6OVERLAY_ARCHIVE -C /
rm $S6OVERLAY_ARCHIVE
