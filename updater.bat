@echo off
title AvianCmd Updater

set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
exit /B

echo Checking...
IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
if exist "C:\Program Files (x86)\AvianCmd\launcher.bat" (
set l="C:\Program Files (x86)\AvianCmd\"
)
) ELSE (
if exist "%SystemDrive%\Program Files\AvianCmd\launcher.bat" (
set l="%SystemDrive%\Program Files\AvianCmd\"
)
)
%SystemDrive%
if %l%=="" (
echo Can't find launcher folder.
set /p l=Please Type launcher folder.EX:"C:\Program Files (x86)\AvianCmd"
)
%SystemDrive%
cd %l%
echo Updateing Launcher...
echo Downloading...
curl https://raw.githubusercontent.com/AvianJay/AvianCmd/main/launcher.bat --output launcher.bat
echo Updated.
pause
exit
