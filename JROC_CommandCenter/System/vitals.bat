@echo off
echo === J-Roc System Vitals ===
wmic cpu get loadpercentage
wmic OS get FreePhysicalMemory,TotalVisibleMemorySize
wmic logicaldisk get size,freespace,caption
ipconfig /all
echo Vitals Complete.
