FROM ubuntu:xenial

RUN apt-get update -q && \
    apt-get upgrade -qy && \
    apt-get install -qy mono-devel && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC && \
    echo "deb http://apt.sonarr.tv/ master main" | tee /etc/apt/sources.list.d/sonarr.list && \
    apt-get update -q && \
    apt-get install nzbdrone && \
    apt-get clean

EXPOSE 8989

RUN mono --debug /opt/NzbDrone/NzbDrone.exe

