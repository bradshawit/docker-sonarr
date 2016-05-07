#! /bin/sh

set -e

mono --debug /opt/NzbDrone/NzbDrone.exe -data=/data/sonarr &
wait
