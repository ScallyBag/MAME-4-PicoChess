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
cd ~/MAME-4-PicoChess/mame_emulation_new
echo ""
echo "Unzipping mess & copying mame_emulation to /opt/picochess/engines"
sleep 1
unzip mess.zip
wait
rm mess.zip
./mess -cc 
cd ~/MAME-4-PicoChess
cp -r mame_emulation_new /opt/picochess/engines

# Rename your existing armv7l to armv7lPICO and copy the armv7l-MAME-new file to /opt/picochess/engines
echo ""
echo "Moving your existing armv7l to armv7lPICO (unless it exists) & replacing with the new armv7l-MAME folder"
sleep 1
cp -r armv7l-MAME-new /opt/picochess/engines
cd /opt/picochess/engines
mv -vn armv7l armv7lPICO
mv armv7l-MAME-new armv7l

echo ""
echo "Moving any existing mame_emulation to mame_emulation_old & replacing with the new mame_emulation folder"
sleep 1
mv mame_emulation mame_emulation_old
mv mame_emulation_new mame_emulation


echo ""
echo "You can revert to your existing engines by deleting armv7l & copying armv7lPICO to armv7l"
echo "This will still keep a copy of your original engine folder plus the armv7l-MAME engine folder"
echo "Now reboot and enjoy the 6 MAME engines"
echo  ""

