@ECHO OFF
adb devices
SET ADBS=-s ZY22FKCVFP
SET /A COUNT=1
:LOOP
ECHO === LOOP %COUNT% ===
SET /A COUNT=%COUNT% + 1

ECHO %DATE% %TIME% Open the store
CALL adb_random_tap.bat 1560 540 60 30
TIMEOUT 1

ECHO %DATE% %TIME% Select item 1
CALL adb_random_tap.bat 860 470 100 200
TIMEOUT 1

@REM ECHO %DATE% %TIME% Select item 2
@REM CALL adb_random_tap.bat 1230 470 100 200
@REM TIMEOUT 1

@REM ECHO %DATE% %TIME% Select item 3
@REM CALL adb_random_tap.bat 1600 470 100 200
@REM TIMEOUT 1

ECHO %DATE% %TIME% Confirm selection
CALL adb_random_tap.bat 1460 1000 100 30
TIMEOUT 1

GOTO LOOP
