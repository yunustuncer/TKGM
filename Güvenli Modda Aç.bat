@echo off
bcdedit /set {current} safeboot minimal
shutdown /r /t 5
exit