#!/bin/sh
set -e

# default is to call dogecoind withoud args or with the provided args
if [ "$(echo $1|cut -b 1)" = "-" ]; then
  set -- dogecoind "$@"
fi

exec "$@"
