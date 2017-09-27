#!/bin/sh
set -e
find /opt/init/startup -type f -name *.sh -exec chmod +x {}
find /opt/init/startup -type f -name *.sh -exec exec {}
/usr/bin/runsvdir -P /etc/service
