# MAME-4-PicoChess
 
# Emulating Retro Chess Computers on PicoChess
 
This will only work on pre-existing PicoChess systems running on Raspbian Buster on a RPi 3, RPi 3b+ or RPi 4b.
 
Please be patient and bare in mind that:
* This is still work in progress
* Certain functions like 'Alternate Move' & 'Take Back' do not work
* Loading some Engines, resetting the pieces to 'New Game' and closing or rebooting PicoChess can take a while
* You will need to match any time shown in the level settings by setting the same or similar times within the Time settings 
 
100% emulation speed for all Engines is only guarenteed on the RPi 4b however only 12 emulations run slower than this on my RPi 3b+, these are:
 
arbv2 running at 70%
feag running at 60%
feagv10 running at 85%
feagv11 no %age given
feasbu running at 86%
fepriv running at 72%
fscc12 running at 60%
gen32 running at 72%
lond32t8 running at 49%
lyon32t8 running at 47%
tascr30_gideon running at 45%
tascr30_king running at 47%
  
To monitor the speed percentage in your environment, navigate to /opt/picochess/engines/armv7l and type:
 
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
option name Level type string default level 1
uciok
quit
Average speed: 100.00% (8 seconds)
 
I will list what updates are required and which prerequisite programs to install.
 
I will also create a Bash file with comments and text to download the relevant code, copy it to the required folders and to explain the process.
 
 
* More to come
 
 
Al.
  
ScallyCoops@gmail.com
 
