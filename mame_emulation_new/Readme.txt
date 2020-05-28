 MessChess for UCI/WB (MESSUI 0.220) 
=====================================
1) Special MESSUI version 0.220 for using chess modules as UCI/WB engines.
2) Changes to the original MESSUI 0.220 sources:
   a) removed all non-chess devices from MESSUI
   b) deleted all warnings and error messages.
3) Changes to the default MESSUI configuration:
   a) 'Window Mode > On' and 'Start Out Maximized > Off' (for module windows)
   b) 'Video Mode > opengl' (change it to 'd3d' or 'gdi' in case of graphic problems!).
4) I've also included 2 chess GUIs (WinBoard 4.9 and Arena 3.51), both are pre-configured
   for all existing chess modules and can be used without any further installation.
   (for Arena 1.1 you have to run 'INSTALL.bat' before the very first start!)

Usage as UCI or WB engines:
---------------------------
In principle this package should work in any GUI which supports UCI or WB engines.
To use any chess module of this package, create a new UCI or WB engine in your GUI,
use "<path>\MessChess.exe" as command (or program name) and "<module>" as command option,
some GUIs also allow to enter this in one single string "<path>\MessChess.exe <module>".

Example:
To use the 'Mephisto Montreux' in your GUI, enter "C:\CB-Emu\MessChess\MessChess.exe" as
command and "montreux" as option, or just "C:\CB-Emu\MessChess\MessChess.exe montreux".

IMPORTANT:
----------
a) For all chess modules you can now set the level in the GUIs engine options.
b) There is still one problem: the chess plugins for some engines don't correctly
   support special moves like under-promotion and/or enpassant, in these situations
   you have to use the necessary function keys of the engine to enter such moves.

New chess engines not implemented in CB-Emu:
--------------------------------------------
ACI Boris (rev. 00)
ACI Boris (rev. 01)
ACI Boris Diplomat
ACI Destiny Prodigy (with board support)
ACI GGM Boris-Sargon 2.5
ACI GGM Sandy Edition
ACI GGM Steinitz Edition-4
AVE ARB Sargon 2.5
AVE ARB Sargon 4.0 Grand Master Series
AVE ARB V2 Sargon 4.0
BREA Intellect-02 (3 levels, clone of Fidelity CC3)
BREA Intellect-02 (4 levels)
Commodore Chessmate (clone of Novag Chess Champion MK-II)
Conic Computer Chess (model 7012)
Conic Master I (similar to DCS CompuChess)
Consumenta Conchess (standard)
Consumenta Conchess Plymate (Amsterdam, T8)
Consumenta Conchess Plymate Victoria
CXG Portachess (1985 version)
CXG Sensor Computachess
CXG Sphinx 40 (50)
CXG Sphinx Dominator v2.05
DCS CompuChess (clone of Novag Chess Champion MK-I)
Energopribor Debut-M
FDR La Regence (TSB 4)
Fidelity Chess Challenger 3
Fidelity Elite Avantgarde V5 (dual CPU)
Mattel Computer Chess
Mephisto Berlin 68000 v0.02
Mephisto Berlin 68000 v0.02 (24 MHz)
Mephisto Berlin 68000 v0.03
Mephisto Berlin 68000 v0.03 (24 MHz)
Mephisto Berlin 68000 London Upgrade
Mephisto Berlin 68000 London Upgrade (24 MHz)
Mephisto I
Mephisto I X
Mephisto II (set 1)
Mephisto II (set 2)
Mephisto II ESB (incl. chessboard)
Mephisto III (ver. A, incl. chessboard)
Mephisto III (ver. B, incl. chessboard)
Mephisto Mirage
Mephisto MM I (ver. A)
Mephisto MM I (ver. B)
Mephisto Mondial
Mephisto Mondial 68000XL
Mephisto TM (Tournament Machines), 8 versions: Berlin, London, Lyon, Portorose, Vancouver
Mephisto TM London 68040 (experimental)
Novag Chess Champion Chess Partner 2000
Novag Chess Champion Delta-1
Novag Chess Champion Delta-1 (modified)
Novag Chess Champion Super System III
Novag Constellation
Novag Constellation 3.6 (set 1)
Novag Constellation 3.6 (set 2)
Novag Constellation Quattro
Novag Savant
Novag Savant II
Novag Super Sensor IV
Saitek Chess Champion Mark V
Saitek Chess Champion Mark VI Philidor
Saitek Corona (ver. C)
Saitek Corona II (ver. D+)
Saitek Galileo
Saitek Leonardo (set 1)
Saitek Leonardo (set 2)
Saitek Mini Chess
Saitek President Chess
Saitek Renaissance (set 1)
Saitek Renaissance (set 2)
Saitek Sensor Chess
Saitek Stratos (set 1)
Saitek Stratos (set 2)
Saitek Superstar 28K
Saitek Turbostar 432
Saitek Turbo King (ver. B, set 1)
Saitek Turbo King (ver. B, set 2)
Saitek Turbo King II (ver. D+)
Tasc ChessSystem R30 (Gideon 2.1, The King 2.20/2.23/2.50)
Tasc ChessSystem R40 (Gideon 2.1, The King 2.20/2.23/2.50)
