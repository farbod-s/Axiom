#!/bin/bash

echo "Enter Source Code Folder :"
read SourceDir
#echo "Enter Debug Output Directory :"
#read OutputDir
#mkdir ${OutputDir}/Debug
cd ${SourceDir}
sudo make uninstall
sudo make clean
sudo make distclean
./configure --enable-debug
sudo make -j8
sudo chmod 755 -R ./*
cd ${SourceDir}/src/
gnome-terminal --tab -e "rcsoccersim" --tab -e "rcsslogplayer"
sleep 10
gnome-terminal -x bash -c "./start.sh -n 1 -h localhost -p 6000 -t Axiom;cat"
for x in 1 2 3 4 5 6 7 8 9 10 11
do
	sleep 2
	gnome-terminal -x bash -c "(echo r --player-config ./player.conf --config_dir ./formations-dt -h localhost -p 6000 -t Axiom --debug_server_host localhost --debug_server_port 6032; cat) | gdb sample_player"
done
