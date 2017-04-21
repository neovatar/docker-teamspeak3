FROM ubuntu:16.04

ARG TS3_VERSION=3.0.13.6
ARG TS3_UID=1000

LABEL maintainer "tom@neovatar.org"
LABEL ts3_version=$TS3_VERSION

ENV DEBIAN_FRONTEND=noninteractive \
    TS3_VERSION=$TS3_VERSION \
    TS3_UID=$TS3_UID \
    TS3_SHA256=19ccd8db5427758d972a864b70d4a1263ebb9628fcc42c3de75ba87de105d179 \
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
