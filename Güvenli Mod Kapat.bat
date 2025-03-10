@echo off
bcdedit /deletevalue {current} safeboot
shutdown /r /t 5
exit