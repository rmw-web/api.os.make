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

fi

brew install pcre openssl

_DIR=$(dirname $(realpath "$0"))

tmp=$_DIR/tmp

mkdir -p $tmp

cd $tmp

version=1.19.3.1
tardir=openresty-$version
tarname=$tardir.tar.gz
wget -c https://openresty.org/download/$tarname


tar zxvf $tarname

cd $tardir


# make
#

# mv src/redis-server $_DIR/../os.$os/redis-server.exe
#
# rm -rf $tmp/$redisDir
# cd ..
# rm -rf $tarname
