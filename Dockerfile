FROM ubuntu:18.04

ARG TS3_VERSION=3.7.1
ARG TS3_UID=1000
ARG TS3_SHA256=6787d4c9fd6f72d1386872a61f38f932a8ee745046b1497168286ffd0311c0f0

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
