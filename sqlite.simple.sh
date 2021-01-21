#!/usr/bin/env zsh

set -e
set -x

_DIR=$(dirname $(realpath "$0"))

tmp=$_DIR/tmp

mkdir -p $tmp

cd $tmp

if [[ ! -d "simple" ]] ; then
git clone git@github.com:rmw-lib/simple.git --depth=1
cd simple
else
cd simple
git pull
fi

rm -rf build
mkdir build; cd build
cmake ..
make -j 12
make install
cd ..
cd output/bin/

os=$(node -e "console.log(process.platform.toLowerCase())")

ext=${$(ls libsimple.*)##*.}
outdir=$_DIR/../os.$os/sqlite
mkdir -p $outdir
mv libsimple.$ext $outdir/simple.$ext

rm -rf $tmp/simple
