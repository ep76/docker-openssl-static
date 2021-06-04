#!/bin/sh
set -eo pipefail

cd /tmp
$(./configdata.pm --command-line | sed -e 's/no-tests//p;d')
touch -r config configdata.pm

if uname -m | grep -qE 'armv7l|aarch64'; then
  # https://github.com/openssl/openssl/issues/12242
  make test TESTS=-test_afalg
else
  make test
fi
