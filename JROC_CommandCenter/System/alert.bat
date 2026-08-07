@echo off
powershell -command "Add-Type -AssemblyName PresentationFramework;[System.Windows.MessageBox]::Show(\"%1\",\"Sovereign Alert\")"
echo Alert Sent.
