# MAME-4-PicoChess
 
# Emulating Retro Chess Computers on PicoChess
 
This will only work on pre-existing PicoChess systems running on Raspbian Buster on a RPi 3, RPi 3b+ or RPi 4b.
 
Please be patient and bare in mind that:
* This is still work on progress
* Certain functions like 'Alternate Move' & 'Take Back' do not work
* Loading some Engines, resetting the pieces to 'New Game' and closing or rebooting PicoChess can take a while
* You will need to match any time shown in the level settings by setting the same or similar times within the Time settings 
* Not all levels are included for each Engine, read the associated Computer Chess Manual or study the lua file for more Info 
* Copyright prevents me from telling you where to find the complete ROM set, so please don't ask
  
We extend our gratitude to Franz Huber for all his hard work and allowing us to use his lua files 
  
100% emulation speed for all Engines is guaranteed on the RPi 4b however only a few emulations run slower on earlier RPi's
  
To monitor the speed in your environment, navigate to /opt/picochess/engines/armv7l and type:
 
sudo ./engname  (i.e. sudo ./mm5)  
uci  
quit  
a speed %age will then be shown, e.g:  
 
Al@PicoChess:/opt/picochess/engines/armv7l $ sudo ./mm5  
Error opening translation file English  
Warning: -video none doesn't make much sense without -seconds_to_run  
uci  
id name Mephisto MM V (set 1) (mess 0.219)  
option name Speed type spin default 100 min 0 max 10000  
option name Level type string default le 1  
uciok  
quit  
Average speed: 100.00% (8 seconds)  
 
# Install Instructions:

* Update your Buster system:  
sudo apt update && sudo apt upgrade
 
* Install the following Packages:  
sudo apt install git build-essential libsdl2-dev libsdl2-ttf-dev libfontconfig-dev qt5-default zip unzip

* Install My MAME GitHub repository:  
cd ~/  
sudo git clone https://github.com/ScallyBag/MAME-4-PicoChess

* Change folders to the newly installed repository:  
cd ~/MAME-4-PicoChess

* Run my fully commented Bash file to install everything else:  
sudo ./AddMAME.sh  
 
* Reboot and enjoy
  
  
  
Al.
  
ScallyCoops@gmail.com
  
