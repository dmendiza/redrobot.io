#!/usr/bin/env bash

set -o errexit
set -o pipefail

container=$(buildah from fedora:31)

buildah config --author 'Douglas Mendizábal <douglas@redrobot.io>' $container

buildah run $container -- dnf upgrade -y --refresh
buildah run $container -- dnf install -y httpd

buildah add $container www /var/www/html

buildah config --port 80 $container
buildah config --port 443 $container

buildah commit $container redrobot
buildah rm $container
