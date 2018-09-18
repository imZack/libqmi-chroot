#!/bin/bash

set -x
export DEB_VERSION=sid

docker run --rm --privileged multiarch/qemu-user-static:register

curl -LO https://github.com/multiarch/qemu-user-static/releases/download/v2.12.0-1/qemu-armeb-static

if [ "$ARCH" = "armv7" ]; then
  docker run -i --rm -v "$(pwd)/output:/var/jail" \
    -v "$(pwd)/create-chroot.sh:/create-chroot.sh" \
    -v "$(pwd)/qemu-armeb-static:/usr/bin/qemu-armeb-static" \
    arm32v7/debian:$DEB_VERSION bash /create-chroot.sh
fi

if [ "$ARCH" = "amd64" ]; then
docker run -i --rm -v "$(pwd)/output:/var/jail" \
  -v "$(pwd)/create-chroot.sh:/create-chroot.sh" \
  debian:$DEB_VERSION bash /create-chroot.sh
fi
