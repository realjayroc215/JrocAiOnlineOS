@echo off
echo === J-Roc Automation Engine ===

set task=%1

if "%task%"=="daily_cleanup" (
    echo Running Daily Cleanup...
    del /q C:\Temp\*
)

if "%task%"=="open_suite" (
    echo Opening Commander Suite...
    start notepad.exe
    start calc.exe
    start mspaint.exe
)

if "%task%"=="diagnostics" (
    echo Running Diagnostics...
    systeminfo
    ipconfig /all
)

echo Automation Complete.

