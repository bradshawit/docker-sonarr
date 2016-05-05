FROM ubuntu:xenial

RUN apt-get update -q && \
    apt-get upgrade -qy && \
    apt-get install -qy bzip2 && \
    apt-get install -qy libcurl4-openssl-dev && \
    apt-get install -qy mono-devel && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC && \
    echo "deb http://apt.sonarr.tv/ master main" | tee /etc/apt/sources.list.d/sonarr.list && \
    apt-get update -q && \
    apt-get install -qy nzbdrone && \
    apt-get clean

# http://www.htpcguides.com/install-jackett-ubuntu-15-x-for-custom-torrents-in-sonarr/
ADD ["https://github.com/zone117x/Jackett/archive/v0.6.9.tar.gz", "/tmp/jackett.tar.gz"]
RUN cd /tmp && tar -xvf jackett*
ADD ["jackett.service", "/etc/systemd/system/"]
RUN adduser jackett
#RUN addgroup jackett
RUN adduser jackett jackett
RUN mkdir /opt/jackett && mv /tmp/Jackett*/* /opt/jackett

# RUN touch /etc/systemd/system/jackett.service

RUN chown -R jackett:jackett /opt/jackett

RUN systemctl enable jackett && service jackett start

EXPOSE 8989
EXPOSE 9117

CMD ["mono --debug /opt/NzbDrone/NzbDrone.exe"]

