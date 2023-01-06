set csv=B:\gitlist.csv
echo timestamp,repositorie,commit hash,tree hash,parent hashes,mail,"date ISO 8601 +08",commit >%csv%
for /d %%i in (*) do (
    cd %%i
    git log --pretty=format:%%at,%%i,%%H,%%T,%%P,%%ae,%%ai,%%s >>%csv%
    cd ..
    echo. >>%csv%
)