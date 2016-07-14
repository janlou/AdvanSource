

THIS_DIR=$(cd $(dirname $0); pwd)
cd $THIS_DIR

update() {
 cd $home
 sudo apt-get update
 sudo apt-get upgrade -y
 sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev make unzip git redis-server g++ libjansson-dev libpython-dev expat libexpat1-dev -y
 cd AdvanSource
 }
 
 echo "تمامی مراحل با موفقیت انجام شدند!"
 echo "آیا مایل به نصب فایل لانچ هستید؟"
 echo -e "\27[31m"
 read -p "(yes/no):"
 echo -e "\27[39m"
 if [ "$REPLY" != "yes" ]; then
	 exit 1
	else
	 chmod +x fix.sh
     chmod +x steady.sh
     chmod +x start.sh
	 ./start.sh install
	fi
 #This is a helper for create anti spam bot.
 #created by: @janlou and powered by: @AdvanTm