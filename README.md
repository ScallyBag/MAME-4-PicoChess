# MAME-4-PicoChess
 
# Emulating Retro Chess Computers on PicoChess
 
This will only work on pre-existing PicoChess systems running on Raspbian Buster on a RPi 3, RPi 3b+ or RPi 4b.
 
Please be patient and bare in mind that:
* This is still a work in progress
* Certain functions like 'Alternate Move' & 'Take Back' do not work
* Loading some Engines, resetting the pieces to 'New Game' and closing or rebooting PicoChess can take a while
* You will need to match any time shown in the level settings by setting the same or similar times within the Time menu 
* Select 'No Book' in the Book menu, each Engine will then use it's own built in books file
* Not all Levels are included for each Engine, read the associated Chess Computer Manual or study the lua file for more information 
* Copyright prevents us from telling you where to find the complete ROM set, so please don't ask. However should you find the ROMs you can legally use those of any Chess Computer you own, but please don't post the address
  
We extend our thanks to the Author for all his hard work and for allowing us to use his lua files 
  
100% emulation speed for all Engines is guaranteed on the RPi 4b however only a few emulations run slower on earlier RPi's
  
To monitor the speed in your environment, navigate to /opt/picochess/engines/armv7l and type:
 
sudo ./engname  (i.e. sudo ./mm5)  
uci  
quit  
an average speed percentage will then be shown, e.g. :  
 
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
sudo apt install git build-essential libsdl2-dev libsdl2-ttf-dev libfontconfig1-dev qt5-default zip unzip

* Install My MAME GitHub repository:  
cd ~/		         <<<<<<< Important it has to be this folder
sudo git clone https://github.com/ScallyBag/MAME-4-PicoChess
 
* Change folders to the newly installed repository:  
cd ~/MAME-4-PicoChess
 
* Run my fully commented Bash file to install everything else:  
./AddMAME.sh  
 
* Reboot and enjoy
  
  
  
Al.
  
ScallyCoops@gmail.com
  
