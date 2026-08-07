@echo off
if "%1"=="kill_process" (taskkill /IM %2 /F)
if "%1"=="scan_ports" (netstat -ano)
if "%1"=="wipe_temp" (del /q C:\Windows\Temp\*)
echo Dark Ops Complete.
