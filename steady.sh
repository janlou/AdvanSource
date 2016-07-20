#!/bin/bash
# =====================================================================================================
# Copyright (C) steady.sh v1.2 2016 iicc (@iicc1)
# =====================================================================================================
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# this program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
# =======================================================================================================
# It depends on Tmux https://github.com/tmux/tmux which is BSD-licensed
# and Screen https://www.gnu.org/software/screen GNU-licensed.
# =======================================================================================================
# This script is intended to control the state of a telegram-cli telegram bot running in background.
# The idea is to get the bot fully operative all the time without any supervision by the user.
# It should be able to recover the telegram bot in any case telegram-cli crashes, freezes or whatever.
# This script works by tracing ctxt swithes value in kernel procces at a $RELOADTIME 
# So it can detect any kind of kernel interruption with the procces and reload the bot.
#
#--------------------------------------------------
#--    ▒▒▒▒▒▒▒▒▒                                --
#--    ▒▒█████▒▒                                --
#--    ▒█▒▒▒▒▒█▒                                --
#--    ▒█▒▒▒▒▒█▒                                --
#--    ▒█▒█▒▒▒█▒                                --
#--    ▒▒██▒▒█▒▒                                --
#--    ▒▒▒▒▒▒▒▒▒                                --
#--    ▒███████▒                                --
#--    ▒▒▒▒█▒▒█▒                                --
#--    ▒▒▒▒█▒▒█▒                                --
#--    ▒▒▒▒█▒▒█▒                                --
#--    ▒▒▒▒▒██▒▒                                --
#--    ▒▒▒▒▒▒▒▒▒                                --
#--    ▒███████▒                                --
#--    ▒▒▒▒▒▒█▒▒                                --
#--    ▒▒▒▒██▒▒▒                                --
#--    ▒▒▒▒▒▒█▒▒                                --
#--    ▒███████▒                                --
#--    ▒▒▒▒▒▒▒▒▒                                --
#--    ▒▒█████▒▒                                --
#--    ▒█▒▒▒▒▒█▒                                --
#--    ▒█▒▒▒▒▒█▒                                --
#--    ▒█▒▒▒▒▒█▒                                --
#--    ▒▒█████▒▒                                --
#--    ▒▒▒▒▒▒▒▒▒                                --
#--    ▒███████▒                                --
#--    ▒█▒▒▒▒▒█▒                                --
#--    ▒█▒▒▒▒▒█▒                                --
#--    ▒█▒▒▒▒▒█▒                                --
#--    ▒▒█████▒▒                                --
#--    ▒▒▒▒▒▒▒▒▒                                --                
#--                                              --                   
#--------------------------------------------------
#--                                              --
#--       Developers: @CRUEL                     --
#--                                              --
#--                                              --
#--------------------------------------------------


# Some script variables
OK=0
BAD=0
NONVOLUNTARY=1
NONVOLUNTARYCHECK=0
VOLUNTARY=1
VOLUNTARYCHECK=0
I=1
BOT=AdvanSource  # You can put here other bots. Also you can change it to run more than one bot in the same server.
RELOADTIME=10  # Time between checking cpu calls of the cli process. Set the value high if your bot does not receive lots of messages.


function tmux_mode {

sleep 0.5
clear
# Space invaders thanks to github.com/windelicato
f=3 b=4
for j in f b; do
  for i in {0..7}; do
    printf -v $j$i %b "\e[${!j}${i}m"
  done
done
bld=$'\e[1m'
rst=$'\e[0m'

cat << EOF

 $f1  ▀▄   ▄▀     $f2 ▄▄▄████▄▄▄    $f3  ▄██▄     $f4  ▀▄   ▄▀     $f5 ▄▄▄████▄▄▄    $f6  ▄██▄  $rst
 $f1 ▄█▀███▀█▄    $f2███▀▀██▀▀███   $f3▄█▀██▀█▄   $f4 ▄█▀███▀█▄    $f5███▀▀██▀▀███   $f6▄█▀██▀█▄$rst
 $f1█▀███████▀█   $f2▀▀███▀▀███▀▀   $f3▀█▀██▀█▀   $f4█▀███████▀█   $f5▀▀███▀▀███▀▀   $f6▀█▀██▀█▀$rst
 $f1▀ ▀▄▄ ▄▄▀ ▀   $f2 ▀█▄ ▀▀ ▄█▀    $f3▀▄    ▄▀   $f4▀ ▀▄▄ ▄▄▀ ▀   $f5 ▀█▄ ▀▀ ▄█▀    $f6▀▄    ▄▀$rst
 
EOF
echo -e "                \e[100m                Steady script          \e[00;37;40m"
echo -e "\033[38;5;208m            ___          _____                       ___           ___       \033[0;00m"
echo -e "\033[38;5;208m           /  /\        /  /::\         ___         /  /\         /__/\      \033[0;00m"
echo -e "\033[38;5;208m          /  /::\      /  /:/\:\       /__/\       /  /::\        \  \:\     \033[0;00m"
echo -e "\033[38;5;208m         /  /:/\:\    /  /:/  \:\      \  \:\     /  /:/\:\        \  \:\    \033[0;00m"
echo -e "\033[38;5;208m        /  /:/~/::\  /__/:/ \__\:|      \  \:\   /  /:/~/::\   _____\__\:\   \033[0;00m"
echo -e "\033[38;5;208m       /__/:/ /:/\:\ \  \:\ /  /:/  ___  \__\:\ /__/:/ /:/\:\ /__/::::::::\  \033[0;00m"
echo -e "\033[38;5;208m       \  \:\/:/__\/  \  \:\  /:/  /__/\ :  |:| \  \:\/:/__\/ \  \:\~~\~~\/  \033[0;00m"
echo -e "\033[38;5;208m        \  \::/        \  \:\/:/   \  \:\|  |:|  \  \::/       \  \:\  ~~~   \033[0;00m"
echo -e "\033[38;5;208m         \  \:\         \  \::/     \  \:\__|:|   \  \:\        \  \:\       \033[0;00m"
echo -e "\033[38;5;208m          \  \:\         \__\/       \__\::::/     \  \:\        \  \:\      \033[0;00m"
echo -e "\033[38;5;208m           \__\/                         ~~~~       \__\/         \__\/      \033[0;00m"
echo -e "\033[38;5;208m               \e[01;34m       https://github.com/janlou/AdvanSource             \e[00;37;40m"
echo ""
cat << EOF
 $bld$f1▄ ▀▄   ▄▀ ▄   $f2 ▄▄▄████▄▄▄    $f3  ▄██▄     $f4▄ ▀▄   ▄▀ ▄   $f5 ▄▄▄████▄▄▄    $f6  ▄██▄  $rst
 $bld$f1█▄█▀███▀█▄█   $f2███▀▀██▀▀███   $f3▄█▀██▀█▄   $f4█▄█▀███▀█▄█   $f5███▀▀██▀▀███   $f6▄█▀██▀█▄$rst
 $bld$f1▀█████████▀   $f2▀▀▀██▀▀██▀▀▀   $f3▀▀█▀▀█▀▀   $f4▀█████████▀   $f5▀▀▀██▀▀██▀▀▀   $f6▀▀█▀▀█▀▀$rst
 $bld$f1 ▄▀     ▀▄    $f2▄▄▀▀ ▀▀ ▀▀▄▄   $f3▄▀▄▀▀▄▀▄   $f4 ▄▀     ▀▄    $f5▄▄▀▀ ▀▀ ▀▀▄▄   $f6▄▀▄▀▀▄▀▄$rst

EOF

sleep 1.2

# Checking if the bot folder is in HOME
echo -e "$bld$f4 در حال چک کردن...$rst"
sleep 0.5
ls ../ | grep $BOT > /dev/null
if [ $? != 0 ]; then
  echo -e "$f1 مشکلی به وجود آمد: پوشه ربات با نام اورجینال یافت نمیشود$rst"
  sleep 4
  exit 1
fi
echo -e "$f2 $BOT در سرور شما یافت شد$rst"
sleep 0.5


echo ""
echo -e "\033[38;5;208m 𝓟𝓸𝔀𝒆𝓻𝒆𝓭 𝓫𝔂: \033[0;00m"
echo -e "\033[38;5;208m Ａｄｖａｎ Ｔｅａｍ \033[0;00m"
echo ""
echo -e "\033[38;5;208m 𝓣𝓻𝓪𝓷𝓼𝓵𝓪𝓽𝒆𝓭 𝓫𝔂 \033[0;00m"
echo -e "\033[38;5;208m @ｋａｍｒａｎｙａ \033[0;00m"
echo -e "\033[38;5;208m @ｊａｎｌｏｕ \033[0;00m"
echo ""

sleep 1.5
echo -e "$bld$f4 در حال چک کردن فرآیندها...$rst"
sleep 0.7

# Looks for the number of screen/telegram-cli processes
CLINUM=`ps -e | grep -c telegram-cli`
echo "$f2 $CLINUM با موفقیت ران شد$rst"
sleep 0.9

# =====Setup ends===== #

# Opening new tmux in a daemon
echo -e "$bld$f4 تلاش برای اتصال...$rst"
# It is recommended to clear cli status always before starting the bot
rm ../.telegram-cli/state  > /dev/null 
# Nested TMUX sessions trick 
TMUX= tmux new-session -d -s $BOT "./start.sh"
sleep 1.3

CLIPID=`ps -e | grep telegram-cli | head -1 | sed 's/^[[:space:]]*//' | cut -f 1 -d" "`
echo -e "$f2 عمل جدید: $CLIPID$rst"
echo ""
echo ""

# Locating telegram-cli status
cat /proc/$CLIPID/task/$CLIPID/status > STATUS
NONVOLUNTARY=`grep nonvoluntary STATUS | cut -f 2 -d":" | sed 's/^[[:space:]]*//'`

sleep 3

# :::::::::::::::::::::::::
# ::::::: MAIN LOOP :::::::
# :::::::::::::::::::::::::

while true; do
  
	echo -e "$f2 تعداد دفعات چک شده:$f5 $OK $rst"
	echo -e "$f2 دفعات بازیافت کرش:$f5 $BAD $rst"
	echo ""
	
	cat /proc/$CLIPID/task/$CLIPID/status > CHECK
	if [ $? != 0 ]; then
		I=$(( $I + 1 ))
		if [ $I -ge 3 ]; then
			kill $CLIPID
			tmux kill-session -t $BOT
			rm ../.telegram-cli/state  > /dev/null 
			NONVOLUNTARY=0
			NONVOLUNTARYCHECK=0
			VOLUNTARY=0
			VOLUNTARYCHECK=0
		fi
	else
		I=1
	fi
	VOLUNTARYCHECK=`grep voluntary CHECK | head -1 | cut -f 2 -d":" | sed 's/^[[:space:]]*//'`
	NONVOLUNTARYCHECK=`grep nonvoluntary CHECK | cut -f 2 -d":" | sed 's/^[[:space:]]*//'`
	
	if [ $NONVOLUNTARY != $NONVOLUNTARYCHECK ] || [ $VOLUNTARY != $VOLUNTARYCHECK ]; then
		echo -e "$f5 ربات با موفقیت اجرا شد!$rst"
		OK=$(( $OK + 1 ))

	else
		echo -e "$f5 ربات اجرا نشده است در حال تلاش برای اجرا...$rst"
		BAD=$(( $BAD + 1 ))
		sleep 1
		
		rm ../.telegram-cli/state  > /dev/null 

		kill $CLIPID
		tmux kill-session -t $BOT
	
		TMUX= tmux new-session -d -s $BOT "./start.sh"
		sleep 1
		
		CLIPID=`ps -e | grep telegram-cli | head -1 | sed 's/^[[:space:]]*//' | cut -f 1 -d" "`
		
		if [ -z "${CLIPID}" ]; then
			echo -e "$f1 مشکلی رخ داد$rst"
			echo -e "$f1 مشکلی در بازیافت ربات رخ داد$rst"
			sleep 3
			exit 1
		fi

	fi
	
	VOLUNTARY=`echo $VOLUNTARYCHECK`
	NONVOLUNTARY=`echo $NONVOLUNTARYCHECK`
	sleep $RELOADTIME
	rm CHECK
	
done

}


function screen_mode {

clear
sleep 0.5

# Space invaders thanks to github.com/windelicato
f=3 b=4
for j in f b; do
  for i in {0..7}; do
    printf -v $j$i %b "\e[${!j}${i}m"
  done
done
bld=$'\e[1m'
rst=$'\e[0m'

cat << EOF

 $f1  ▀▄   ▄▀     $f2 ▄▄▄████▄▄▄    $f3  ▄██▄     $f4  ▀▄   ▄▀     $f5 ▄▄▄████▄▄▄    $f6  ▄██▄  $rst
 $f1 ▄█▀███▀█▄    $f2███▀▀██▀▀███   $f3▄█▀██▀█▄   $f4 ▄█▀███▀█▄    $f5███▀▀██▀▀███   $f6▄█▀██▀█▄$rst
 $f1█▀███████▀█   $f2▀▀███▀▀███▀▀   $f3▀█▀██▀█▀   $f4█▀███████▀█   $f5▀▀███▀▀███▀▀   $f6▀█▀██▀█▀$rst
 $f1▀ ▀▄▄ ▄▄▀ ▀   $f2 ▀█▄ ▀▀ ▄█▀    $f3▀▄    ▄▀   $f4▀ ▀▄▄ ▄▄▀ ▀   $f5 ▀█▄ ▀▀ ▄█▀    $f6▀▄    ▄▀$rst
 
EOF
echo -e "                \e[100m                Steady script          \e[00;37;40m"
echo -e "\033[38;5;208m            ___          _____                       ___           ___       \033[0;00m"
echo -e "\033[38;5;208m           /  /\        /  /::\         ___         /  /\         /__/\      \033[0;00m"
echo -e "\033[38;5;208m          /  /::\      /  /:/\:\       /__/\       /  /::\        \  \:\     \033[0;00m"
echo -e "\033[38;5;208m         /  /:/\:\    /  /:/  \:\      \  \:\     /  /:/\:\        \  \:\    \033[0;00m"
echo -e "\033[38;5;208m        /  /:/~/::\  /__/:/ \__\:|      \  \:\   /  /:/~/::\   _____\__\:\   \033[0;00m"
echo -e "\033[38;5;208m       /__/:/ /:/\:\ \  \:\ /  /:/  ___  \__\:\ /__/:/ /:/\:\ /__/::::::::\  \033[0;00m"
echo -e "\033[38;5;208m       \  \:\/:/__\/  \  \:\  /:/  /__/\ :  |:| \  \:\/:/__\/ \  \:\~~\~~\/  \033[0;00m"
echo -e "\033[38;5;208m        \  \::/        \  \:\/:/   \  \:\|  |:|  \  \::/       \  \:\  ~~~   \033[0;00m"
echo -e "\033[38;5;208m         \  \:\         \  \::/     \  \:\__|:|   \  \:\        \  \:\       \033[0;00m"
echo -e "\033[38;5;208m          \  \:\         \__\/       \__\::::/     \  \:\        \  \:\      \033[0;00m"
echo -e "\033[38;5;208m           \__\/                         ~~~~       \__\/         \__\/      \033[0;00m"
echo -e "\033[38;5;208m               \e[01;34m       https://github.com/janlou/AdvanSource             \e[00;37;40m"
echo ""
cat << EOF
 $bld$f1▄ ▀▄   ▄▀ ▄   $f2 ▄▄▄████▄▄▄    $f3  ▄██▄     $f4▄ ▀▄   ▄▀ ▄   $f5 ▄▄▄████▄▄▄    $f6  ▄██▄  $rst
 $bld$f1█▄█▀███▀█▄█   $f2███▀▀██▀▀███   $f3▄█▀██▀█▄   $f4█▄█▀███▀█▄█   $f5███▀▀██▀▀███   $f6▄█▀██▀█▄$rst
 $bld$f1▀█████████▀   $f2▀▀▀██▀▀██▀▀▀   $f3▀▀█▀▀█▀▀   $f4▀█████████▀   $f5▀▀▀██▀▀██▀▀▀   $f6▀▀█▀▀█▀▀$rst
 $bld$f1 ▄▀     ▀▄    $f2▄▄▀▀ ▀▀ ▀▀▄▄   $f3▄▀▄▀▀▄▀▄   $f4 ▄▀     ▀▄    $f5▄▄▀▀ ▀▀ ▀▀▄▄   $f6▄▀▄▀▀▄▀▄$rst

EOF

sleep 1.3

# Checking if the bot folder is in HOME
echo -e "$bld$f4 CHECKING INSTALLED BOT...$rst"
sleep 0.5
ls ../ | grep $BOT > /dev/null
if [ $? != 0 ]; then
  echo -e "$f1 ERROR: BOT: $BOT NOT FOUND IN YOUR HOME DIRECTORY$rst"
  sleep 4
  exit 1
fi
echo -e "$f2 $BOT FOUND IN YOUR HOME DIRECTORY$rst"
sleep 0.5


echo ""
echo -e "\033[38;5;208m 𝓟𝓸𝔀𝒆𝓻𝒆𝓭 𝓫𝔂: \033[0;00m"
echo -e "\033[38;5;208m Ａｄｖａｎ Ｔｅａｍ \033[0;00m"
echo ""
echo -e "\033[38;5;208m 𝓣𝓻𝓪𝓷𝓼𝓵𝓪𝓽𝒆𝓭 𝓫𝔂 \033[0;00m"
echo -e "\033[38;5;208m @ｋａｍｒａｎｙａ \033[0;00m"
echo -e "\033[38;5;208m @ｊａｎｌｏｕ \033[0;00m"
echo ""

# Starting preliminar setup
sleep 1.5
echo -e "$bld$f4 CHECKING PROCESSES...$rst"
sleep 0.7

# Looks for the number of screen/telegram-cli processes
SCREENNUM=`ps -e | grep -c screen`
CLINUM=`ps -e | grep -c telegram-cli`

if [ $SCREENNUM -ge 3 ]; then
  echo -e "$f1 خطا: بیش از 2 روند از صفحه نمایش در حال اجرا است $rst"
  echo -e "$f1 این فرآیندها کشته خواهند شد. سپس راه اندازی مجدد کنید اسکریپت را $rst"
  echo -e '$f1 اجرا: "از بین بردن تمام صفحه نمایش" $rst'
  if [ $CLINUM -ge 2 ]; then
    echo -e "$f1 خطا : بيش از 1 فرايند تلگرام اجرا می شود $rst"
    echo -e "$f1 این فرآیندها کشته خواهد شد. سپس راه اندازی مجدد کنید اسکریپت را $rst"
	echo -e "$f1 اجرا: از بین بردن تمام تلگرام - سی ال آی $rst"
  fi
  sleep 4
  exit 1
fi
echo "$f2 شماره صفحه و شماره  تحت محدوده پشتیبانی"
sleep 0.7
echo "$f2 RUNNING $SCREENNUM SCREEN PROCESS$rst"
echo "$f2 RUNNING $CLINUM TELEGRAM-CLI PROCESS$rst"
sleep 0.9

# Getting screen pid's
ps -e | grep screen | sed 's/^[[:space:]]*//' | cut -f 1 -d" " | while read -r line ; do
  sleep 0.5
  echo -e "$f2 SCREEN NUMBER $I PID: $line$rst"
  if [ $I -eq 1 ]; then
    echo $line > SC1
  else
    echo $line > SC2
  fi
  I=$(( $I + 1 ))
done

# I had some weird errors, so I had to do this silly fix:
SCREENPID1=`cat SC1`
SCREENPID2=`cat SC2`
rm SC1 SC2 >/dev/null

sleep 0.7
CLIPID=`ps -e | grep telegram-cli | sed 's/^[[:space:]]*//' | cut -f 1 -d" "`
if [ $CLINUM -eq 1 ]; then
  echo -e "$f2 RUNNING ONE PROCESS OF TELEGRAM-CLI: $CLIPID1$rst"
  echo -e "$bld$f4 KILLING TELEGRAM-CLI PROCESS. NOT NEEDED NOW$rst"
  kill $CLIPID1
else
  echo -e "$f2 RUNNING ZERO PROCESS OF TELEGRAM-CLI$rst"
fi
sleep 0.7


CLINUM=`ps -e | grep -c telegram-cli`
if [ $CLINUM -eq 1 ]; then
  echo -e "$f1 ERROR: TELEGRAM-CLI PID COULDN'T BE KILLED. IGNORE.$rst"
fi
sleep 1


# =====Setup ends===== #

# Opening new screen in a daemon
echo -e "$bld$f4 ATTACHING SCREEN AS DAEMON...$rst"
# Better to clear cli status before
rm ../.telegram-cli/state  > /dev/null 
screen -d -m bash start.sh

sleep 1.3

SCREENNUM=`ps -e | grep -c screen`
if [ $SCREENNUM != 3 ]; then
  echo -e "$f1 ERROR: SCREEN RUNNING: $SCREENNUM \n SCREEN ESPECTED: 3$rst"
  exit 1
fi

# Getting screen info
sleep 0.7
echo -e "$bld$f4 RELOADING SCREEN INFO...$rst"
sleep 1
echo -e "$f2 NUMBER OF SCREEN ATTACHED: $SCREENNUM$rst"
echo -e "$f2 SECONDARY SCREEN: $SCREENPID1 AND $SCREENPID2$rst"
SCREEN=`ps -e | grep -v $SCREENPID1 | grep -v $SCREENPID2 | grep screen | sed 's/^[[:space:]]*//' | cut -f 1 -d" "`

sleep 0.5
echo -e "$f2 PRIMARY SCREEN: $SCREEN$rst"

sleep 0.7
echo -e "$bld$f4 RELOADING TELEGRAM-CLI INFO...$rst"
sleep 0.7

# Getting new telegram-cli PID
CLIPID=`ps -e | grep telegram-cli | sed 's/^[[:space:]]*//' |cut -f 1 -d" "`
echo -e "$f2 NEW TELEGRAM-CLI PID: $CLIPID$rst"
if [ -z "${CLIPID}" ]; then
  echo -e "$f1 ERROR: TELEGRAM-CLI PROCESS NOT RUNNING$rst"
  sleep 3
  exit 1
fi


# Locating telegram-cli status
cat /proc/$CLIPID/task/$CLIPID/status > STATUS
NONVOLUNTARY=`grep nonvoluntary STATUS | cut -f 2 -d":" | sed 's/^[[:space:]]*//'`


sleep 5

# :::::::::::::::::::::::::
# ::::::: MAIN LOOP :::::::
# :::::::::::::::::::::::::

  while true; do
  
	echo -e "$f2 تعداد دفعات چک شده:$f5 $OK $rst"
	echo -e "$f2 دفعات بازیافت کرش:$f5 $BAD $rst"
	echo ""
	
	cat /proc/$CLIPID/task/$CLIPID/status > CHECK
	VOLUNTARYCHECK=`grep voluntary CHECK | head -1 | cut -f 2 -d":" | sed 's/^[[:space:]]*//'`
	NONVOLUNTARYCHECK=`grep nonvoluntary CHECK | cut -f 2 -d":" | sed 's/^[[:space:]]*//'`
	#echo -e "NONVOLUNTARYCHECK CTXT SWITCHES: $NONVOLUNTARYCHECK"
	#echo -e "NONVOLUNTARY CTXT SWITCHES: $NONVOLUNTARY"
	
	if [ $NONVOLUNTARY != $NONVOLUNTARYCHECK ] || [ $VOLUNTARY != $VOLUNTARYCHECK ]; then
		echo -e "$f5 BOT RUNNING!$rst"
		OK=$(( $OK + 1 ))

	else
		echo -e "$f5 ربات اجرا نشده است درحال تلاش برای اتصال مجدد...$rst"
		BAD=$(( $BAD + 1 ))
		sleep 1
		
		rm ../.telegram-cli/state  > /dev/null 

		kill $CLIPID
		kill $SCREEN
		
		screen -d -m bash start.sh
		sleep 1
		
		CLIPID=`ps -e | grep telegram-cli | sed 's/^[[:space:]]*//' | cut -f 1 -d" "`
		
		if [ -z "${CLIPID}" ]; then
			echo -e "$f1 ERROR: TELEGRAM-CLI PROCESS NOT RUNNING$rst"
			echo -e "$f1 FAILED TO RECOVER BOT$rst"
			sleep 1
		fi
		
		SCREENNUM=`ps -e | grep -c screen`
		if [ $SCREENNUM != 3 ]; then
			echo -e "$f1 ERROR: SCREEN RUNNING: $SCREENNUM \n SCREEN ESPECTED: 3$rst"
			echo -e "$f1 FAILED TO RECOVER BOT$rst"
			exit 1
		fi

		SCREEN=`ps -e | grep -v $SCREENPID1 | grep -v $SCREENPID2 | grep screen | sed 's/^[[:space:]]*//' | cut -f 1 -d" "`
		echo -e "$f5 BOT HAS BEEN SUCCESFULLY RELOADED!$rst"
		echo -e "$f2 TELEGRAM-CLI NEW PID: $CLIPID$rst"
		echo -e "$f2 SCREEN NEW PID: $SCREEN$rst"
		sleep 3
		
	fi
	
	VOLUNTARY=`echo $VOLUNTARYCHECK`
	NONVOLUNTARY=`echo $NONVOLUNTARYCHECK`
	sleep $RELOADTIME
	rm CHECK
	
  done

}

function tmux_detached {
clear
TMUX= tmux new-session -d -s script_detach "bash steady.sh -t"
echo -e "\e[1m"
echo -e ""
echo "Bot running in the backgroud with TMUX"
echo ""
echo -e "\e[0m"
sleep 3
tmux kill-session script
exit 1
}

function screen_detached {
clear
screen -d -m bash start.sh
echo -e "\e[1m"
echo -e ""
echo "ربات با اسکرین در حال اجراست!"
echo ""
echo -e "\e[0m"
sleep 3
quit
exit 1
}



if [ $# -eq 0 ]
then
	echo -e "\e[1m"
	echo -e ""
	echo "چنین دستوری وجود ندارد! از دستور زیر برای مشاهده راهنما استفاده کنید"
	echo "bash steady.sh -h"
	echo ""
	echo -e "\e[0m"
    sleep 1
	exit 1
fi

while getopts ":tsTSih" opt; do
  case $opt in
    t)
	echo -e "\e[1m"
	echo -e ""
	echo "در حال پاکسازی ترمینال" >&2
	echo "اسکریپت درحال اجرا شدن میباشد..."
	sleep 1.5
	echo -e "\e[0m"
	tmux_mode
	exit 1
      ;;
	s)
	echo -e "\e[1m"
	echo -e ""
	echo "در حال پاکسازی ترمینال" >&2
	echo "اسکریپت درحال اجرا شدن میباشد..."
	sleep 1.5
	echo -e "\e[0m"
	screen_mode
	exit 1
      ;;
    T)
	echo -e "\e[1m"
	echo -e ""
	echo "در حال پاکسازی ترمینال" >&2
	echo "اسکریپت درحال اجرا شدن میباشد..."
	sleep 1.5
	echo -e "\e[0m"
	tmux_detached
	exit 1
      ;;
	S)
	echo -e "\e[1m"
	echo -e ""
	echo "درحال پاکسازی و اجرا توسط اسکرین" >&2
	echo "اسکریپت درحال اجرا شدن میباشد..."
	sleep 1.5
	echo -e "\e[0m"
	screen_detached
	exit 1
      ;;
	i)
	echo -e "\e[1m"
	echo -e ""
	echo "steady.sh bash script v1 CRUEL 2016 GPMOD (original) & translation by @AdvanTm" >&2
	echo ""
	echo -e "\e[0m"

echo -e "\033[38;5;208m ▂▃▅▇█▓▒░𝓪𝓓𝓿𝓐𝓷𝓣𝓶░▒▓█▇▅▃▂ \033[0;00m"
echo -e "\033[38;5;208m ▂▃▅▇█▓▒░𝓪𝓓𝓿𝓐𝓷𝓣𝓶░▒▓█▇▅▃▂ \033[0;00m"
echo -e "\033[38;5;208m ▂▃▅▇█▓▒░𝓪𝓓𝓿𝓐𝓷𝓣𝓶░▒▓█▇▅▃▂ \033[0;00m"
echo -e "\033[38;5;208m ▂▃▅▇█▓▒░𝓪𝓓𝓿𝓐𝓷𝓣𝓶░▒▓█▇▅▃▂ \033[0;00m"
echo -e "\033[38;5;208m ▂▃▅▇█▓▒░𝓪𝓓𝓿𝓐𝓷𝓣𝓶░▒▓█▇▅▃▂ \033[0;00m"
echo ""
	exit 1
      ;;
	h)
	echo -e "\e[1m"
	echo -e ""
	echo "Usage:"
	echo -e ""
	echo "steady.sh -t"
	echo "steady.sh -s"
	echo "steady.sh -T"
	echo "steady.sh -S"
	echo "steady.sh -h"
	echo "steady.sh -i"
    echo ""
	echo "Options:"
	echo ""
    echo "   -t     select TMUX terminal multiplexer"
	echo "   -s     select SCREEN terminal multiplexer"
	echo "   -T     select TMUX and detach session after start"
	echo "   -S     select SCREEN and detach session after start"
	echo "   -h     script options help page"
	echo "   -i     information about the script"
	echo -e "\e[0m"
	exit 1
	;;
	  
    \?)
	echo -e "\e[1m"
	echo -e ""
    echo "Invalid option: -$OPTARG" >&2
	echo "Run bash $0 -h for help"
	echo -e "\e[0m"
	exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done
