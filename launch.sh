#! /bin/sh

set -e

mono --debug /opt/jackett/JackettConsole.exe &
mono --debug /opt/NzbDrone/NzbDrone.exe &
wait
