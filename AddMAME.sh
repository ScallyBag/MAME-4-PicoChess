#!/bin/bash
# Distribute the files required for MAME-4-PicoChess

clear
echo "This will not work alongside my new Switchable Image as the folder names have changed"
echo "Hit CTRL C to cancel this Bash script"
sleep 7

# Closing PicoChess
clear
echo "Closing PicoChess"
sudo service picochess stop
wait

# Move mame_emulation to /opt/picochess/engines/
cd ~/MAME-4-PicoChess/mame_emulation
echo ""
echo "Unzipping mess & copying mame_emulation to /opt/picochess/engines"
sleep 1
sudo unzip mess.zip
wait
rm mess.zip
./mess -cc 
cd ~/MAME-4-PicoChess
sudo cp -r mame_emulation /opt/picochess/engines

# Rename your existing armv7l to armv7lPICO and copy the armv7l-MAME file to /opt/picochess/engines
echo ""
echo "Renaming your existing armv7l to armv7lPICO (unless it exists) and applying the armv7l-MAME folder"
sleep 1
sudo cp -r armv7l-MAME /opt/picochess/engines
cd /opt/picochess/engines
sudo mv -vn armv7l armv7lPICO
sudo cp -r armv7l-MAME armv7l

echo ""
echo "You can revert to your existing engines by deleting armv7l & copying armv7lPICO to armv7l"
echo "This will still keep a copy of your original engine folder plus the armv7l-MAME engine folder"
echo "Now reboot and enjoy the 6 MAME engines"
echo  ""

