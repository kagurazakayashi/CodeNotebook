@REM NWlink IPX/SPX/NetBIOS Compatible Transport Protocol

# Windows XP x86
MKDIR XPIPX32
COPY %WINDIR%\inf\netnwlnk.pnf XPIPX32\
COPY %WINDIR%\inf\netnwlnk.inf XPIPX32\
COPY %WINDIR%\System32\rtipxmib.dll XPIPX32\
COPY %WINDIR%\System32\nwprovau.dll XPIPX32\
COPY %WINDIR%\System32\wshisn.dll XPIPX32\
COPY %WINDIR%\System32\drivers\nwlnkflt.sys XPIPX32\
COPY %WINDIR%\System32\drivers\nwlnkfwd.sys XPIPX32\
COPY %WINDIR%\System32\drivers\nwlnkipx.sys XPIPX32\
COPY %WINDIR%\System32\drivers\nwlnknb.sys XPIPX32\
COPY %WINDIR%\System32\drivers\nwlnkspx.sys XPIPX32\

# Windows XP x64
MKDIR XPIPX64
COPY %WINDIR%\nwlnkipx.sys XPIPX64\
COPY %WINDIR%\nwlnknb.sys XPIPX64\
COPY %WINDIR%\nwlnkspx.sys XPIPX64\
COPY %WINDIR%\inf\netnwlnk.inf XPIPX64\
COPY %WINDIR%\inf\netnwlnk.PNF XPIPX64\
COPY %WINDIR%\system32\nwprovau.dll XPIPX64\
COPY %WINDIR%\system32\wshisn.dll XPIPX64\
COPY %WINDIR%\system32\drivers\nwlnkipx.sys XPIPX64\
COPY %WINDIR%\system32\drivers\nwlnknb.sys XPIPX64\
COPY %WINDIR%\system32\drivers\nwlnkspx.sys XPIPX64\
