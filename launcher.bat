@echo off
title AvianCmd Launcher
echo Checking...

:check1
echo 1 of 4
if exist %USERPROFILE%/ajcmd/aj.bat (goto check2) else (goto error)

:check2
echo 2 of 4
if exist %USERPROFILE%/ajcmd/cmd.bat (goto check3) else (goto error)

:check3
echo 3 of 4
if exist %USERPROFILE%/ajcmd/startcmd.bat (goto check4) else (goto error)

:check4
echo 4 of 4
if exist %USERPROFILE%/ajcmd/updater.bat (goto ok) else (goto error)

:error
echo Some file are missing.
goto ask

:ask
set /P ans=Do you want to download now?(y/n)
if %ans%==y (goto update)
if %ans%==n (exit)
echo Please type y or n.
goto ask

:update
cd %USERPROFILE%
mkdir ajcmd
cd ajcmd
echo Downloading...
curl https://raw.githubusercontent.com/AvianJay/AvianCmd/main/aj.bat --output aj.bat
curl https://raw.githubusercontent.com/AvianJay/AvianCmd/main/cmd.bat --output cmd.bat
curl https://raw.githubusercontent.com/AvianJay/AvianCmd/main/startcmd.bat --output startcmd.bat
curl https://raw.githubusercontent.com/AvianJay/AvianCmd/main/updater.bat --output updater.bat
echo Updated.
goto ok

:ok
set /p launch=What Do You Want To Do?(l=Launch/u=Update/ul=Update Launcher)
if %launch% == l (cd %USERPROFILE%/ajcmd & start startcmd.bat & exit)
if %launch% == u (goto update)
if %launch% == ul (cd %USERPROFILE%/ajcmd & start updater.bat & exit)
echo Please type l or u or ul.
goto ok
