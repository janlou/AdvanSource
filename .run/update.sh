#!/usr/bin/env bash

THIS_DIR=$(cd $(dirname $0); pwd)
cd $THIS_DIR

install() {

 cd ..
 sudo apt-get update
 sudo apt-get upgrade -y
 sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev make unzip git redis-server g++ libjansson-dev libpython-dev expat libexpat1-dev -y
 
 }
 
 if [ "$1" = "install" ]; then
  install
 else
 echo "Run $0 install"
 #This is a helper for create anti spam bot.
 #created by: @janlou and powered by: @AdvanTm
fi