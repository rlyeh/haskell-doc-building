#!/bin/bash

fail() {
  local code=$1
  shift
  echo "------------------------------------------------------------"
  while [[ -n "${1}" ]]; do
    echo $1 ; shift
  done
  exit $code
}

if [[ ! -r "VERSION" ||
      ! -d "ghc" ]]; then
  echo "$0 must be run while cd'd to ghc src distro"
  exit 1
fi

GHCVER=$(cat VERSION)
export XML_CATALOG_FILES="/opt/local/etc/xml/catalog"
# expose HsColour and hasktags
export PATH=$PATH:/usr/local/ghc-6.12.3/bin

echo "About to make clean and reconfigure.  ^c to abort"
echo -n ">"
read || exit 1


./configure --prefix=/usr/local/ghc-${GHC-VER} $*

fgrep -q -e "HSCOLOUR=''" config.log && fail 1 \
  "HsColour not found by configure. Is it installed and in your path?" \
  "Documentation will not link to source code without HsColour" 








