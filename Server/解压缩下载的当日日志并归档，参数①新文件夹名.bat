setlocal enabledelayedexpansion
for %%x in (*.gz) do (
    7z x "%%x"
    del "%%x"
)
mkdir %1
for %%x in (*) do (
    move "%%x" "%1\%%x.log"
)
