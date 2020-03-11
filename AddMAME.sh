#!/bin/bash
# Download and distribute the files required for MAME-4-PicoChess

# Closing PicoChess
clear
echo "Closing PicoChess"
sudo service picochess stop
wait

# Download MAME
echo "Downloading MAME as mame_emulation, this will take a while"
cd ~/
sudo git clone https://github.com/mamedev/mame/ mame_emulation
wait

# Move mame_emulation to /opt/picochess/engines/
echo "Moving mame_emulation to /opt/picochess/engines/ unless it exists"
sleep 1
sudo mv -vn ~/mame_emulation/ /opt/picochess/engines/

# Copy the provided mess compile to mame_emulation
echo "Unzipping & Copying mess to mame_emulation and initialise it"
sleep 1
cd ~/MAME-4-PicoChess/files/
sudo unzip mess.zip
wait
sudo cp -r mess /opt/picochess/engines/mame_emulation/
wait
cd /opt/picochess/engines/mame_emulation/
sudo ./mess -cc

# Copy Dirk's lua files for the PicoChess interface
echo "Copy Dirk's interface lua files to mame_emulation"
sleep 1
cd ~/MAME-4-PicoChess/files/
sudo cp -r plugins /opt/picochess/engines/mame_emulation/

# Copy the provided lua files to mame_emulation
echo "Copy the Engine lua interfaces to mame_emulation"
sleep 1
cd ~/MAME-4-PicoChess/files/interfaces/
sudo cp -r *.lua /opt/picochess/engines/mame_emulation/plugins/chessengine/interfaces/

# Copy Dirk's lua plugins for some engines
echo "Copy Dirk's engine lua plugins for some engines"
sleep 1
cd /opt/picochess/engines/mame_emulation/plugins/chessengine/interfaces/molli-plugins/
sudo cp -r *.lua /opt/picochess/engines/mame_emulation/plugins/chessengine/interfaces/

# Copy the ROMs allowed from Ed Schröder's Rebel13 site:
echo "Copy the allowed ROMs from Ed Schröder's Rebel13 site, this is also where you copy the full set of ROMs"
sleep 1
cd ~/MAME-4-PicoChess/files/roms/
sudo cp *.zip /opt/picochess/engines/mame_emulation/roms/

# Rename your existing armv7l to armv7lPICO and copy the relevant armv7l file to /opt/picochess/engines/
echo "Rename your existing armv7l to armv7lPICO (unless it exists) and copy the 2 armv7l folders for part & full ROMs"
sleep 1
cd ~/MAME-4-PicoChess/files/
sudo cp -r armv7l-MAME-* /opt/picochess/engines/
cd /opt/picochess/engines/
sudo mv -vn armv7l armv7lPICO
sudo cp -r armv7l-MAME-part armv7l
#sudo cp -r armv7l-MAME-full armv7l  #if you have all ROMs

echo "You can revert to your existing engines by copying armv7lPICO to armv7l, this still keeps a copy of them plus the 2 possible MAME engine folders"
sleep 1
echo "Now reboot and enjoy the 6 MAME engines. If you find the full set of ROMs copy them to /opt/picochess/engines/mame_emulation/roms/  and then copy /opt/picochess/engines/armv7l-MAME-full as armv7l instead"
