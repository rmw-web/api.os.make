#!/usr/bin/env bash

set -e
set -x

os=$(node -e "console.log(process.platform.toLowerCase())")

if [ "$os" = "darwin" ];then
if ! hash pcregrep 2>/dev/null; then
brew install pcre
fi

if ! hash openssl 2>/dev/null; then
brew install openssl
fi

ssldir=/usr/local/Cellar/openssl
sslver=$(ls /usr/local/Cellar/openssl@*/|sort|tail -1)

fi

_DIR=$(dirname $(realpath "$0"))

tmp=$_DIR/tmp

mkdir -p $tmp

cd $tmp

openssldir=openssl-1.1.1i
if [[ ! -d "$openssldir" ]] ; then
wget -c https://www.openssl.org/source/$openssldir.tar.gz
tar zxcf $openssldir.tar.gz
fi

version=1.19.3.1
tardir=openresty-$version
tarname=$tardir.tar.gz
if [[ ! -d "$tardir" ]] ; then
wget -c https://openresty.org/download/$tarname
tar zxvf $tarname
fi

cd $tardir

./configure --prefix=/opt/openresty --with-cc-opt="-I/usr/local/include" --with-luajit --without-http_redis2_module --with-ld-opt="-L/usr/local/lib" --with-openssl="$tmp/$openssldir"

make

# mv src/redis-server $_DIR/../os.$os/redis-server.exe
#
# rm -rf $tmp/$redisDir
# cd ..
# rm -rf $tarname
