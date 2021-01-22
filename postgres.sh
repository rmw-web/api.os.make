#!/usr/bin/env bash

set -e
set -x

version="13.1.0-1"

os=$(node -e "console.log(process.platform.toLowerCase())")

if [ "$os" = "darwin" ];then
osfix="darwin-amd64"
fi

_DIR=$(dirname $(realpath "$0"))

tmp=$_DIR/tmp/postgres

mkdir -p $tmp

cd $tmp

wget -c "https://repo1.maven.org/maven2/io/zonky/test/postgres/embedded-postgres-binaries-$osfix/$version/embedded-postgres-binaries-$osfix-$version.jar" -O postgres.zip

unzip postgres.zip

mkdir -p postgres
tar -xvf postgres-*.txz -C ./postgres
rm -rf postgres/bin/pg_ctl*

osdir=$_DIR/../os.$os
rm -rf $osdir/postgres
mv postgres $osdir
rm -rf $tmp
