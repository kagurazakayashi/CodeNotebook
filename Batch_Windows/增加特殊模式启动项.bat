bcdedit /copy {current} /d "Windows10 No Hyper-V"
bcdedit /set {XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX} hypervisorlaunchtype OFF
bcdedit /copy {current} /d "Windows10 SafeMode"
bcdedit /copy {current} /d "Windows10 SafeMode Network"
bcdedit /delete {XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX}