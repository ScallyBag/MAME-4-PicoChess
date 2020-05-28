@echo off
cls
echo.
setlocal enabledelayedexpansion
if exist Engines rd /S /Q Engines >nul
md Engines
cd..
set messdir=%CD%
cd Shredder
for /F "tokens=1,2* delims=;" %%a in (MessChess.lst) do (
  if "%1" == "/name" (
    set ENG=%%c
  ) else (
    set ENG=%%a
  )
  (
    echo [ENGINE]
    echo Name=%%c
    echo Author=MessChess
    echo FileName=%messdir%\MessChess.exe
    echo Parameter=%%b
  ) >Engines\!ENG!.eng
)
endlocal
echo Engine files created!
echo.
