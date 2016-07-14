#!/usr/bin/env bash

THIS_DIR=$(cd $(dirname $0); pwd)
cd $THIS_DIR

adv() {
 chmod 777 1.sh
 chmod 777 2.sh
 chmod 777 3.sh
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