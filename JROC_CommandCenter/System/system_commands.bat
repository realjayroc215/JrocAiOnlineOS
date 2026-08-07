@echo off
echo === J-Roc Sovereign System Commands ===
if "%1"=="open_notepad" (start notepad.exe)
if "%1"=="open_cmd" (start cmd.exe)
if "%1"=="shutdown" (shutdown /s /t 5)
if "%1"=="restart" (shutdown /r /t 5)
if "%1"=="sysinfo" (systeminfo)
echo Command complete.
