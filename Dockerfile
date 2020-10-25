FROM ubuntu:18.04

ARG TS3_VERSION=3.12.1
ARG TS3_UID=1000
ARG TS3_SHA256=cfbffba30a570f0ba33a74ce5e5dbda54ce564d917a27183cdcaf82cc2b4abb7

LABEL maintainer "tom@neovatar.org"
LABEL ts3_version=$TS3_VERSION

ENV DEBIAN_FRONTEND=noninteractive \
    TS3_VERSION=$TS3_VERSION \
    TS3_UID=$TS3_UID \
    TS3_SHA256=$TS3_SHA256  \
    LANG=en_US.UTF-8 \
    TZ=Europe/Berlin

COPY src/ /tmp/docker/
WORKDIR "/tmp/docker"

RUN apt-get update -q \
 && apt-get upgrade -qy \
 && ./install_basepackages.sh \
 && ./install_locale.sh \
 && ./install_timezone.sh \
 && ./install_s6.sh \
 && ./install_ts3.sh \
 && rm -rf /tmp/* \
 && rm -rf /var/lib/apt

ENTRYPOINT ["/init"]

VOLUME ["/ts3/data"]
