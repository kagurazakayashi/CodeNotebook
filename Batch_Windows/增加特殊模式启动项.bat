bcdedit /copy {current} /d "Windows11 No Hyper-V"
bcdedit /set {XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX} hypervisorlaunchtype OFF
bcdedit /copy {current} /d "Windows11 SafeMode"
bcdedit /copy {current} /d "Windows11 SafeMode Network"
msconfig
bcdedit /delete {XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX}