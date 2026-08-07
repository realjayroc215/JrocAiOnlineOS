@echo off
echo === J-Roc Sovereign Threat Monitor ===
netstat -ano
netsh advfirewall firewall show rule name=all
tasklist
echo Threat Monitor Complete.
