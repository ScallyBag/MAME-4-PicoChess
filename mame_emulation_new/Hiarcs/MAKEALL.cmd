@echo off
cls
echo.
setlocal enabledelayedexpansion
if exist Engines rd /S /Q Engines >nul
md Engines
cd..
set messdir=%CD%
cd Hiarcs
for /F "tokens=1,2* delims=;" %%a in (MessChess.lst) do (
  if "%1" == "/name" (
    set BAT=%%c
  ) else (
    set BAT=%%a
  )
  (
    echo @echo off
    echo cd /D "%messdir%"
    echo MessChess.exe %%b
  ) >Engines\!BAT!.bat
)
endlocal
echo Engine files created!
echo.
