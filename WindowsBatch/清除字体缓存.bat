net stop FontCache
net stop FontCache3.0.0.0
net stop iphlpsvc
net stop Winmgmt
del C:\Windows\ServiceProfiles\LocalService\AppData\Local\*.dat
net start FontCache
net start FontCache3.0.0.0
net start iphlpsvc
net start Winmgmt
