#!/bin/sh
docker build --build-arg TS3_UID=$(id -u docker 2>/dev/null || id -u) -t neovatar/ts3 .