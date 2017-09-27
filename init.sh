#!/bin/sh
set -e
echo "Running startup scripts"
find /opt/init/startup -type f -name *.sh -exec chmod +x {} \;
find /opt/init/startup -type f -name *.sh -print -exec exec {} \;
echo "Startup scripts completed"
/usr/bin/runsvdir -P /etc/service
