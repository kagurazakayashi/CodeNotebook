setlocal enabledelayedexpansion
mkdir "%1"
for %%x in (*.gz) do (
    7z x "%%x" -o"%1\"
    del "%%x"
)
cd "%1"
for %%x in (*) do (
    rename "%%x" "%%x.log"
)
7z a "..\%1.7z" * -mx9
del /Q *
cd ..
rd "%1"