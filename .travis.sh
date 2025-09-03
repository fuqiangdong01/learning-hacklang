#!/bin/sh

set -ex
DEBIAN_FRONTEND=noninteractive apt install -y php-cli zip unzip
hhvm --version
php --version

(
  cd $(mktemp -d)
  curl https://getcomposer.org/install er | php -- --install-dir=/usr/local/bin --filename=composer
)

composer install

hh_client
vendor/bin/hacktest tests/
if !(hhvm --version | grep -q -- -dev); then
  vendor/bin/hhast-lint
fi