# differences between engines.ini and armv7l

I started with:
84 engines in engines.ini
78 engines in armv7l
------
for differences run job: ExtSortDiff.sh

9 engines in engines.ini not in armv7l (commented out in engines.ini later*):
------
amsterd
npresto
regence
savant
supercon
scorpio68
sdtor
stratos
super9ccg
------
therefore 3 engines in armv7l not in engines.ini:
------
feasbu - added to engines.ini
sc1 - rom doesn't exist ?
vcc - added to engines.ini
------
roma rom doesn't exist, changed code to roma32
dallas rom doesn't exist, changed code to dallas16
lond030 rom doesn't exist, changed code to lond32
*sc1 rom doesn't exist, not sure what it's supposed to be *slc1 already exists ?

I started every engine natively:
All engines running at 100% except:
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
------
How many levels in each engine:
run: fgrep -o [ engname.uci | wc -l

engines:
I corrected those that called the wrong rom name
roma to roma32
dallas to dallas16
lond030 to lond32
*sc1 eng + uci still in still armv7l, I don't know what rom it should link to?
vcc spoke in German like vccg which should speak German. I added '-bios en' to the end of the vcc engine code, it now works
sexperta failed with rom failure, so I changed sexperta to sexpertb, in engine names and engine.ini, it now works 
 
engines.ini:
I corrected all levels
I added grades for all Engines
I added ponder/brain for those missing this
I renamed the small/medium/large names to fit 6/8/11 characters
I sorted engines.ini in alphabetical order and commented out the 9 without engines files (*see above)

engines.uci:
I altered those levels that had more than 11 characters and put them into order

Al.
