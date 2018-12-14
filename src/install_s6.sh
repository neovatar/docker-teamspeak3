#!/bin/bash
set -e

S6OVERLAY_VERSION="1.21.7.0"
S6OVERLAY_SHA256="7ffd83ad59d00d4c92d594f9c1649faa99c0b87367b920787d185f8335cbac47"
S6OVERLAY_ARCHIVE=/tmp/s6-overlay-amd64.tar.gz
S6OVERLAY_URL=https://github.com/just-containers/s6-overlay/releases/download/v$S6OVERLAY_VERSION/$(basename $S6OVERLAY_ARCHIVE)

echo "===> install s6 overlay v$S6OVERLAY_VERSION"
curl -sSL -o $S6OVERLAY_ARCHIVE $S6OVERLAY_URL
echo "$S6OVERLAY_SHA256 $S6OVERLAY_ARCHIVE" | sha256sum -c -
tar xvzf $S6OVERLAY_ARCHIVE -C /
rm $S6OVERLAY_ARCHIVE
