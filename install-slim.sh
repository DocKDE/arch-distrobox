#!/bin/sh

set -oue pipefail

TAG=$(curl -sL https://api.github.com/repos/slimtoolkit/slim/releases/latest | jq -r .tag_name)
URL="https://downloads.dockerslim.com/releases/${TAG}"
DIST="dist_linux"
FILENAME="${DIST}.tar.gz"

curl -sLo "/tmp/${FILENAME}" "${URL}/${FILENAME}"
tar -xf "/tmp/${FILENAME}" 
install -c -m 0755 "/tmp/${DIST}/slim" /usr/bin/
install -c -m 0755 "/tmp/${DIST}/slim-sensor" /usr/bin/
