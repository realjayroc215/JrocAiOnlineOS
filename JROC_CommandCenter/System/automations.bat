@echo off
echo === J-Roc Automation Engine ===
if "%1"=="daily_cleanup" (del /q C:\Temp\*)
if "%1"=="open_suite" (start notepad.exe & start calc.exe & start mspaint.exe)
if "%1"=="diagnostics" (systeminfo & ipconfig /all)
echo Automation Complete.
