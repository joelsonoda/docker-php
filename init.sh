#!/bin/sh
set -e
find /opt/init/startup -type f -name *.sh -exec chmod +x {} \;
find /opt/init/startup -type f -name *.sh -print -exec exec {} \;
/usr/bin/runsvdir -P /etc/service
