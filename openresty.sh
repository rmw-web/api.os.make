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
openssltgz=$openssldir.tar.gz
wget -c https://www.openssl.org/source/$openssltgz
tar zxcf $openssltgz
rm -rf $openssltgz
fi

version=1.19.3.1
xdir=openresty-$version
tgz=$xdir.tar.gz
if [[ ! -d "$xdir" ]] ; then
wget -c https://openresty.org/download/$tgz
tar zxvf $tgz
rm -rf $tgz
fi

cd $xdir
installdir=$tmp/openresty
mkdir -p $installdir
./configure --prefix=$installdir --with-cc-opt="-I/usr/local/include" --with-luajit --without-http_redis2_module --with-ld-opt="-L/usr/local/lib" --with-openssl="$tmp/$openssldir"

make
make install
cp $installdir/nginx/sbin/nginx $_DIR/../os.$os/openresty.exe
cd $tmp && rm -rf $openssldir && rm -rf $xdir && rm -rf $installdir
