@ECHO OFF
@REM pixeldiff.exe=https://github.com/kagurazakayashi/PixelDiff
adb devices
SET ADBS=-s ZY22FKCVFP
SET TEMPDIR=B:\ysmeow
SET ADBC="D:\AndroidSDK\platform-tools\adb.exe"
SET PIXELC="C:\bat\pixeldiff.exe"

MKDIR %TEMPDIR%
SET PIXELD=%TEMPDIR%\pixeldiff.exe
SET ADBD=%TEMPDIR%\adb.exe
SET TEMPFILE=%TEMPDIR%\ysmeow.png
IF NOT EXIST %ADBD% COPY %ADBC% %ADBD%
IF NOT EXIST %PIXELD% COPY %PIXELC% %PIXELD%

SET /A COUNT=1

:LOOP
ECHO %DATE% %TIME% === LOOP %COUNT% ===
SET /A COUNT=%COUNT% + 1

SET SELECTED=0

ECHO %DATE% %TIME% Open the store
CALL :RANDOM_TAP 1560 540 60 30 
TIMEOUT 1

ECHO %DATE% %TIME% Refreshing screenshot...
%ADBD% %ADBS% exec-out screencap -p > %TEMPFILE% 

ECHO %DATE% %TIME% Checking Item 1...
FOR /F "tokens=*" %%A IN ('%PIXELD% -i %TEMPFILE% -x 995 -y 760 -r 168 -g 104 -b 37') DO SET DIFF=%%A 
ECHO %DATE% %TIME% Item 1 Result ^(Diff: %DIFF%^) 

IF "%DIFF:~0,3%"=="0.0" (
    ECHO %DATE% %TIME% Item 1 match, selecting...
    CALL :RANDOM_TAP 860 470 100 200
    SET SELECTED=1
    TIMEOUT 1
) ELSE IF "%DIFF%"=="0" (
    ECHO %DATE% %TIME% Item 1 exact match, selecting...
    CALL :RANDOM_TAP 860 470 100 200
    SET SELECTED=1
    TIMEOUT 1
) ELSE (
    ECHO %DATE% %TIME% Item 1 does not match.
)

ECHO %DATE% %TIME% Checking Item 2...
FOR /F "tokens=*" %%A IN ('%PIXELD% -i %TEMPFILE% -x 1360 -y 760 -r 168 -g 104 -b 37') DO SET DIFF=%%A 
ECHO %DATE% %TIME% Item 2 Result ^(Diff: %DIFF%^) 

IF "%DIFF:~0,3%"=="0.0" (
    ECHO %DATE% %TIME% Item 2 match, selecting...
    CALL :RANDOM_TAP 1230 470 100 200
    SET SELECTED=1
    TIMEOUT 1
) ELSE IF "%DIFF%"=="0" (
    ECHO %DATE% %TIME% Item 2 exact match, selecting...
    CALL :RANDOM_TAP 1230 470 100 200
    SET SELECTED=1
    TIMEOUT 1
) ELSE (
    ECHO %DATE% %TIME% Item 2 does not match.
)

ECHO %DATE% %TIME% Checking Item 3...
FOR /F "tokens=*" %%A IN ('%PIXELD% -i %TEMPFILE% -x 1720 -y 760 -r 168 -g 104 -b 37') DO SET DIFF=%%A 
ECHO %DATE% %TIME% Item 3 Result ^(Diff: %DIFF%^) 

IF "%DIFF:~0,3%"=="0.0" (
    ECHO %DATE% %TIME% Item 3 match, selecting...
    CALL :RANDOM_TAP 1600 470 100 200
    SET SELECTED=1
    TIMEOUT 1
) ELSE IF "%DIFF%"=="0" (
    ECHO %DATE% %TIME% Item 3 exact match, selecting...
    CALL :RANDOM_TAP 1600 470 100 200
    SET SELECTED=1
    TIMEOUT 1
) ELSE (
    ECHO %DATE% %TIME% Item 3 does not match.
)

IF "%SELECTED%"=="0" (
    ECHO %DATE% %TIME% No items matched. Selecting Item 2 as fallback...
    CALL :RANDOM_TAP 1230 470 100 200
    TIMEOUT 1
)

ECHO %DATE% %TIME% Confirm selection
CALL :RANDOM_TAP 1460 1000 100 30
TIMEOUT 1

GOTO LOOP

:RANDOM_TAP
SET _BASE_X=%1
SET _BASE_Y=%2
SET _OFF_X=%3
SET _OFF_Y=%4
CALL :GET_RANDOM %_BASE_X% %_OFF_X% FINAL_X
CALL :GET_RANDOM %_BASE_Y% %_OFF_Y% FINAL_Y
ECHO %DATE% %TIME% tap %FINAL_X% %FINAL_Y%
%ADBD% %ADBS% shell input tap %FINAL_X% %FINAL_Y%
GOTO :EOF

:GET_RANDOM
SET /A _BASE=%1
SET /A _OFFSET=%2
SET /A _SPAN=(_OFFSET * 2) + 1
SET /A _MIN=_BASE - _OFFSET
SET /A %3=%RANDOM% %% _SPAN + _MIN
GOTO :EOF
