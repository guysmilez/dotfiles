#!/bin/bash
VERSIONS=(8.3.16 8.4.4)

for version in ${VERSIONS[@]}; do
  PATH="$(brew --prefix bison)/bin:$(brew --prefix icu4c)/bin:$(brew --prefix icu4c)/sbin:$PATH" \
  PHP_CONFIGURE_OPTIONS="\
    --with-iconv=$(brew --prefix libiconv) \
    --with-openssl=$(brew --prefix openssl) \
    --with-pgsql=$(brew --prefix libpq) \
    --with-pdo-pgsql=$(brew --prefix libpq) \
    --with-zlib=$(brew --prefix zlib)" \
    asdf install php $version
done
