#!/usr/bin/env bash

set -e
set -x

_DIR=$(dirname $(realpath "$0"))

tmp=$_DIR/tmp

mkdir -p $tmp

cd $tmp

git clone git@github.com:rmw-lib/simple.git --depth=1

cd simple

mkdir build; cd build
cmake ..
make -j 12
make install

os=$(node -e "console.log(process.platform.toLowerCase())")

cd ..

mv output/bin/libsimple.* $_DIR/../os.$os
