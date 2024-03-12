#!/bin/sh

RELEASE=$(curl -s https://api.github.com/repos/jetpack-io/devbox/releases/latest | jq -r .tag_name)

curl -sLo /tmp/devbox.tar.gz https://github.com/jetpack-io/devbox/releases/download/"$RELEASE"/devbox_"$RELEASE"_linux_amd64.tar.gz
tar xf /tmp/devbox.tar.gz -C /usr/bin/
