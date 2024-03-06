#!/bin/sh

set -oue pipefail

TAG=$(curl -sL https://api.github.com/repos/slimtoolkit/slim/releases/latest | jq -r .tag_name)
URL="https://downloads.dockerslim.com/releases/${TAG}"
DIST="dist_linux"
WORKDIR="/tmp"
FILENAME="${DIST}.tar.gz"

curl -sLo "${WORKDIR}/${FILENAME}" "${URL}/${FILENAME}"
tar -xf "${WORKDIR}/${FILENAME}" -C ${WORKDIR}
mv "${WORKDIR}/${DIST}/slim" /usr/bin/
mv "${WORKDIR}/${DIST}/slim-sensor" /usr/bin/
