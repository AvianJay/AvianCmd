@echo off
title AvianCmd Updater

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", " ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
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
