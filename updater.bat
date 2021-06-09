@echo off
title AvianCmd Updater

:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
echo Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
echo args = "ELEV " >> "%vbsGetPrivileges%"
echo For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
echo args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
echo Next >> "%vbsGetPrivileges%"
echo UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & pushd .
cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
:-------------------------------------- 
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
