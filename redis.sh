#!/usr/bin/env bash

set -e
set -x

_DIR=$(dirname $(realpath "$0"))

tmp=$_DIR/tmp

mkdir -p $tmp

cd $tmp

version=6.2-rc2
tarname=$version.tar.gz
wget -c https://github.com/redis/redis/archive/$tarname

tar zxvf $tarname

redisDir=redis-$version

cd $redisDir

make

os=$(node -e "console.log(process.platform.toLowerCase())")

mv src/redis-server $_DIR/../os.$os/redis-server.exe

rm -rf $tmp/$redisDir
cd ..
rm -rf $tarname
