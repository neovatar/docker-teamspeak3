FROM ubuntu:18.04

ARG TS3_VERSION=3.5.0
ARG TS3_UID=1000
ARG TS3_SHA256=9bd56e115afea19351a6238a670dc93e365fe88f8a6c28b5b542ef6ae2ca677e

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
