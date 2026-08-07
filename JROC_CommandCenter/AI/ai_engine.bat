@echo off
echo === J-Roc Sovereign AI Engine ===
set command=%1
if "%command%"=="status" (echo System Status: ONLINE)
if "%command%"=="time" (time /t)
if "%command%"=="date" (date /t)
if "%command%"=="launch_notepad" (call C:\JROC_CommandCenter\System\system_commands.bat open_notepad)
if "%command%"=="sysinfo" (call C:\JROC_CommandCenter\System\system_commands.bat sysinfo)
if "%command%"=="vitals" (call C:\JROC_CommandCenter\System\vitals.bat)
if "%command%"=="scan_network" (call C:\JROC_CommandCenter\Network\network_scan.bat)
echo AI Engine Complete.
