#!/bin/bash

cd $(dirname $0)

if [[ $(jq -r .reference.P854 meta.json) == http* ]]
then
  TMPFILE=$(mktemp)
  CURLOPTS='-L -b /tmp/cookies -c /tmp/cookies --compressed'

  OPENSSL_CONF=../.openssl_allow_tls1.0.cnf curl $CURLOPTS -A 'Chrome/51.0.2704.103 Safari/537.36' -o $TMPFILE $(jq -r .reference.P854 meta.json)

  if grep -q "403 Forbidden" $TMPFILE; then
    echo "403 Forbidden"
    exit
  else
    mv $TMPFILE official.html
  fi
fi

cd ~-
