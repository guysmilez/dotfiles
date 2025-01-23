#!/bin/bash

PATH="$(brew --prefix bison)/bin:$(brew --prefix icu4c)/bin:$(brew --prefix icu4c)/sbin:$PATH" \
PHP_CONFIGURE_OPTIONS="\
  --with-iconv=$(brew --prefix libiconv) \
  --with-openssl=$(brew --prefix openssl) \
  --with-pgsql=$(brew --prefix libpq) \
  --with-pdo-pgsql=$(brew --prefix libpq) \
  --with-zlib=$(brew --prefix zlib)" \
  asdf install php 8.3.16
