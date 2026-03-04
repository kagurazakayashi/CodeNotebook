@ECHO OFF
setlocal enabledelayedexpansion
SET "SEVENZIP_PATH=C:\Program Files\7-Zip\7z.exe"
SET "MAX_THREADS=32"
DATE /T
TIME /T
FOR /L %%T IN (1,1,%MAX_THREADS%) do (
    ECHO ---------- %%T Threads ----------
    "%SEVENZIP_PATH%" b -mmt=%%T
)
