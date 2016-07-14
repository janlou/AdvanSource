#!/usr/bin/env bash

THIS_DIR=$(cd $(dirname $0); pwd)
cd $THIS_DIR

update() {
 sudo apt-get update
 }
 
 upgrade() {
 sudo apt-get upgrade -y
 }
 
 sudo() {
 sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev make unzip git redis-server g++ libjansson-dev libpython-dev expat libexpat1-dev -y
 }
 
 if [ "$1" = "1" ]; then
  update
 elif [ "$1" = "2" ]; then
  upgrade
 elif [ "$1" = "3" ]; then
  sudo
 else
 echo "You can:"
 echo "use ($0 1) to install sudo apt-get update"
 echo "use ($0 2) to install sudo apt-get upgrade"
 echo "use ($0 3) to install sudo apt-get install libreadline-dev libconfig-dev ..."
 #This is a helper for create anti spam bot.
 #created by: @janlou and powered by: @AdvanTm
fi