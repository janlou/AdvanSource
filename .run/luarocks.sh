#!/usr/bin/env bash

THIS_DIR=$(cd $(dirname $0); pwd)
cd $THIS_DIR


luarocks() {
cd $home
cd AdvanSource
cd .luarocks
cd bin
./luarocks-5.2 install luafilesystem
./luarocks-5.2 install lub
./luarocks-5.2 install luaexpat
cd ..
cd ..
}
  if [ "$1" = "install" ]; then
  luarocks
 else
  echo "Run $0 install"
 #This is a helper for create anti spam bot.
 #created by: @janlou and powered by: @AdvanTm
  fi
	