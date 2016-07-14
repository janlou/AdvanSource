
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
  
    echo -e "\27[31m"
    echo -e "Godbye luarock :)"
	echo -e "\27[39m"
	