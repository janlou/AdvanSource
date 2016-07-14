#!/usr/bin/env bash

THIS_DIR=$(cd $(dirname $0); pwd)
cd $THIS_DIR

adv() {
 sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev make unzip git redis-server g++ libjansson-dev libpython-dev expat libexpat1-dev -y
 }
 
 if [ "$1" = "r" ]; then
  adv
 else
 echo "Use:"
 echo "$0 r"
 #This is a helper for create anti spam bot.
 #created by: @janlou and powered by: @AdvanTm
 #warning: CopyRight all right reserved, we can block you channel or bot.
fi