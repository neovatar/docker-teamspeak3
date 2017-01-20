FROM ubuntu:16.04

MAINTAINER neovatar

ARG TS3_UID

ENV TS3_DOWNLOAD_URL=http://dl.4players.de/ts/releases/3.0.13.6/teamspeak3-server_linux_amd64-3.0.13.6.tar.bz2 \
    TS3_UID=${TS3_UID:-1000} \
    TS3_SHA256SUM=19ccd8db5427758d972a864b70d4a1263ebb9628fcc42c3de75ba87de105d179 \
    LANG=en_US.UTF-8

RUN apt-get update -q \
  && DEBIAN_FRONTEND=noninteractive apt-get upgrade -qy \
  && DEBIAN_FRONTEND=noninteractive apt-get install -qy bzip2 wget locales \
  && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
  && echo 'LANG="en_US.UTF-8"'>/etc/default/locale \
  && dpkg-reconfigure --frontend=noninteractive locales \
  && update-locale LANG=en_US.UTF-8 \
  && apt-get clean \
  && rm -rf /var/lib/apt \
  && useradd -u ${TS3_UID} ts3 \
  && mkdir -p /ts3 \
  && wget -q -O /ts3/ts3.tar.bz2 ${TS3_DOWNLOAD_URL} \
  && cd /ts3 \
  && echo "${TS3_SHA256SUM} ts3.tar.bz2" > ts3.tar.bz2.sha256 \
  && sha256sum -c ts3.tar.bz2.sha256 \
  && tar --directory /ts3 -xjf /ts3/ts3.tar.bz2 \
  && rm /ts3/ts3.tar.bz2 /ts3/ts3.tar.bz2.sha256 \
  && mkdir -p /ts3/data/logs \
  && mkdir -p /ts3/data/files \
  && ln -s /ts3/data/ts3server.sqlitedb /ts3/teamspeak3-server_linux_amd64/ts3server.sqlitedb \
  && ln -s /ts3/data/licensekey.dat /ts3/teamspeak3-server_linux_amd64/licensekey.dat \
  && ln -s /ts3/data/serverkey.dat /ts3/teamspeak3-server_linux_amd64/serverkey.dat \
  && chown -R ts3 /ts3

USER ts3
ENTRYPOINT ["/ts3/teamspeak3-server_linux_amd64/ts3server_minimal_runscript.sh"]
CMD ["inifile=/ts3/data/ts3server.ini"]

VOLUME ["/ts3/data"]
