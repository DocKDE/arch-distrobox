#!/bin/sh

TAG=$(curl -sL https://api.github.com/repos/slimtoolkit/slim/releases/latest | jq -r .tag_name)
URL="https://downloads.dockerslim.com/releases/${TAG}"
DIST="dist_linux"
FILENAME="${DIST}.tar.gz"

curl -sLo "/tmp/${FILENAME}" "${URL}/${FILENAME}"
mv "/tmp/${DIST}/slim" /usr/bin/
mv "/tmp/${DIST}/slim-sensor" /usr/bin/
chmod +x /usr/bin/slim
chmod +x /usr/bin/slim-sensor
