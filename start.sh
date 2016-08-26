#!/usr/bin/env bash

THIS_DIR=$(cd $(dirname $0); pwd)
cd $THIS_DIR

update() {
  git pull
  git submodule update --init --recursive
  install_rocks
}
#By: @AdvanTm
# Will install luarocks on THIS_DIR/.luarocks
install_luarocks() {
  git clone https://github.com/keplerproject/luarocks.git
  cd luarocks
  git checkout tags/v2.2.1 # Current stable

  PREFIX="$THIS_DIR/.luarocks"

  ./configure --prefix=$PREFIX --sysconfdir=$PREFIX/luarocks --force-config

  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi

  make build && make install
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting.";exit $RET;
  fi

  cd ..
  rm -rf luarocks
}

install_rocks() {
  ./.luarocks/bin/luarocks install luasocket
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi

  ./.luarocks/bin/luarocks install oauth
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi

  ./.luarocks/bin/luarocks install redis-lua
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi

  ./.luarocks/bin/luarocks install lua-cjson
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi

  ./.luarocks/bin/luarocks install fakeredis
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi

  ./.luarocks/bin/luarocks install xml
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi

  ./.luarocks/bin/luarocks install feedparser
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi

  ./.luarocks/bin/luarocks install serpent
  RET=$?; if [ $RET -ne 0 ];
    then echo "Error. Exiting."; exit $RET;
  fi
}

install() {
  rm -rf tg
  git clone --recursive https://github.com/janlou/tg.git
  git pull
  git submodule update --init --recursive
  patch -i "system/bot/disable.patch" -p 0 --batch --forward
  RET=$?;

  cd tg
  if [ $RET -ne 0 ]; then
    autoconf -i
  fi
  ./configure && make

  RET=$?; if [ $RET -ne 0 ]; then
    echo "Error. Exiting."; exit $RET;
  fi
  cd ..
  install_luarocks
  install_rocks
  
  sleep 0.9
  echo ""
  echo ""
  echo "Bot has been installed! you can run bot with:"
  echo ""
  echo "RUN BOT WITH CLI MOD:"
  echo "$0"
  sleep 0.9
  echo ""
  echo "RUN BOT WITH SELF MOD:"
  echo "$0 self"
  echo ""
  sleep 0.9
  echo ""
  echo "RUN BOT WITH API MOD:"
  echo "$0 api"
  echo ""
  echo ""
}
#By: @AdvanTm
if [ "$1" = "install" ]; then
  install
elif [ "$1" = "update" ]; then
  update
else
  if [ ! -f ./tg/telegram.h ]; then
    echo "Tg not found, use:"
    echo "$0 install"
    exit 1
  fi

  if [ ! -f ./tg/bin/telegram-cli ]; then
    echo "Tg not found, use:"
    echo "$0 install"
    exit 1
fi
  
if [ "$1" = "api" ]; then
   echo -e "\033[38;5;208m"
   echo -e "----------------------------------------------"
   echo -e "     ___    ____ __    __ ___    _   _        "
   echo -e "    / _ \  |  _ \\ \  / // _ \  | \  ||       "
   echo -e "   / /_\ \ | |_| |\ \/ // /_\ \ ||\\_||       "
   echo -e "  /_/   \_\|____/  \__//_/   \_\|| \__|       "
   echo -e "                                              "
   echo -e "----------------------------------------------"
   echo -e "                  API MOD                     "
   echo -e "         ----------------------------         "
   echo -e "         CopyRight all right reserved         "
   echo -e "----------------------------------------------"
   echo -e "                                              \033[0;00m"
   echo -e "\e[36m"
   
  while true; do
   rm -r ../.telegram-cli/state
   ./tg/bin/telegram-cli -b ./tg/tg-server.pub -s ./system/bot/bot.lua -l 1 -E $@
   sleep 3
  done
elif [ "$1" = "self" ]; then
  git clone https://gitlab.com/antispam/plugins-self
   echo -e "\033[38;5;208m"
   echo -e "----------------------------------------------"
   echo -e "     ___    ____ __    __ ___    _   _        "
   echo -e "    / _ \  |  _ \\ \  / // _ \  | \  ||       "
   echo -e "   / /_\ \ | |_| |\ \/ // /_\ \ ||\\_||       "
   echo -e "  /_/   \_\|____/  \__//_/   \_\|| \__|       "
   echo -e "                                              "
   echo -e "----------------------------------------------"
   echo -e "                   SELF MOD                   "
   echo -e "         ----------------------------         "
   echo -e "         CopyRight all right reserved         "
   echo -e "----------------------------------------------"
   echo -e "                                              \033[0;00m"
   echo -e "\e[36m"
   
  while true; do
   rm -r ../.telegram-cli/state
   ./tg/bin/telegram-cli -k ./tg/tg-server.pub -s ./system/bot/self.lua -l 1 -E $@
   sleep 3
  done
elif [ "$1" = "help" ]; then
  echo ""
  echo "You can use:"
  sleep 0.5
  echo ""
  echo "$0 api"
  echo "Api mod for your bot"
  sleep 2
  echo ""
  echo "$0 self"
  echo "Self mod for your account"
  sleep 2
  echo ""
  echo "$0"
  echo "Cli mod for your bot's account"
  echo ""
fi
   echo -e "\033[38;5;208m"
   echo -e "----------------------------------------------"
   echo -e "     ___    ____ __    __ ___    _   _        "
   echo -e "    / _ \  |  _ \\ \  / // _ \  | \  ||       "
   echo -e "   / /_\ \ | |_| |\ \/ // /_\ \ ||\\_||       "
   echo -e "  /_/   \_\|____/  \__//_/   \_\|| \__|       "
   echo -e "                                              "
   echo -e "----------------------------------------------"
   echo -e "                   CLI MOD                    "
   echo -e "         ----------------------------         "
   echo -e "         CopyRight all right reserved         "
   echo -e "----------------------------------------------"
   echo -e "                                              \033[0;00m"
   echo -e "\e[36m"
   
  while true; do
   rm -r ../.telegram-cli/state
   ./tg/bin/telegram-cli -k ./tg/tg-server.pub -s ./system/bot/bot.lua -l 1 -E $@
   sleep 3
  done
fi
