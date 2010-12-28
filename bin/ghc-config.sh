#!/bin/bash
MYROOT=${0%/bin\/*}

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
if [[ -r "/opt/local/etc/xml/catalog" ]]; then 
  export XML_CATALOG_FILES="/opt/local/etc/xml/catalog"
fi 
# expose HsColour and hasktags
export PATH=$PATH:/usr/local/ghc-6.12.3/bin

FILEROOT=$MYROOT/files/ghc-${GHCVER}
if [[ -d "$FILEROOT" ]] ; then 
    echo cp -vR $FILEROOT ..
    cp -vR $FILEROOT ..
fi

echo "About to make clean and reconfigure.  ^c to abort"
echo -n ">"
read || exit 1


./configure --prefix=/usr/local/ghc-${GHCVER} $*


fgrep -q -e "HSCOLOUR=''" config.log && fail 1 \
  "HsColour not found by configure. Is it installed and in your path?" \
  "Documentation will not link to source code without HsColour" 



echo "About to make.  ^c to abort"
echo -n ">"
read || exit 1

make



