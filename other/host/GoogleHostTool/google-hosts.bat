powershell -noprofile Set-ExecutionPolicy Unrestricted
set SHEEL_PATH=%~dp0\google-hosts.ps1
PowerShell -file %SHEEL_PATH%
ipconfig/flushdns
start  https://www.google.com.hk
pause
