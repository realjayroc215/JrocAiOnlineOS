@echo off
echo === J-Roc Voice Command Module ===
set command=%1
if "%command%"=="hello" (echo Welcome Commander J-Roc.)
if "%command%"=="status" (call C:\JROC_CommandCenter\AI\ai_engine.bat status)
if "%command%"=="launch_notepad" (call C:\JROC_CommandCenter\System\system_commands.bat open_notepad)
if "%command%"=="vitals" (call C:\JROC_CommandCenter\System\vitals.bat)
echo Voice Module Complete.
