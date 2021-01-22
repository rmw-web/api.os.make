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

# openssldir=openssl-1.1.1i
# if [[ ! -d "$openssldir" ]] ; then
# openssltgz=$openssldir.tar.gz
# wget -c https://www.openssl.org/source/$openssltgz
# tar zxcf $openssltgz
# rm -rf $openssltgz
# fi
#
# version=1.19.3.1
# xdir=openresty-$version
# tgz=$xdir.tar.gz
# if [[ ! -d "$xdir" ]] ; then
# wget -c https://openresty.org/download/$tgz
# tar zxvf $tgz
# rm -rf $tgz
# fi
#
# cd $xdir
# installdir=$tmp/openresty
# mkdir -p $installdir
# ./configure --prefix=$installdir --with-cc-opt="-I/usr/local/include" --with-luajit --without-http_redis2_module --with-ld-opt="-L/usr/local/lib" --with-openssl="$tmp/$openssldir"
#
# make
# make install
# cp $installdir/nginx/sbin/nginx $_DIR/../os.$os/openresty.exe
# cd $tmp && rm -rf $openssldir && rm -rf $xdir && rm -rf $installdir
