setlocal enabledelayedexpansion
for %%x in (*) do (
    rename "%%x" "%%x.log"
)
