# <p align="center">  <p align="center">![http://s7.picofile.com/file/8246886692/teleadvan_v3.jpg](http://s7.picofile.com/file/8246886692/teleadvan_v3.jpg)
# <p align="center">😯SuperAdvan😯
# <p align="center">👉 Bot: [@TeleAdvan](http://telegram.me/teleadvan)
# <p align="center">👉 Channel: [@AdvanTM](http://telegram.me/AdvanTM)

# <p align="left">Clone Source:
```
cd $home
```
```
git clone https://github.com/janlou/AdvanSource
```
# <p align="left">Clone tg folder:
```
git clone --recursive https://github.com/vysheng/tg.git
```
# <p align="left">Firt install:
```
sudo apt-get update
```
```
sudo apt-get upgrade
```
```bash
sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev make unzip git redis-server g++ libjansson-dev libpython-dev expat libexpat1-dev
```
# <p align="left">install bot:
```
cd AdvanSource
```
***
```bash
chmod +x fix.sh
chmod +x steady.sh
chmod +x start.sh
```
***
`./start.sh install`
***
***
```bash
cd .luarocks
cd bin
./luarocks-5.2 install luafilesystem
./luarocks-5.2 install lub
./luarocks-5.2 install luaexpat
cd ..
cd ..
```
***
`./start.sh install`
***
```bash
tmux new-session -s script "bash steady.sh -t"
```
***
`./start.sh`
***
