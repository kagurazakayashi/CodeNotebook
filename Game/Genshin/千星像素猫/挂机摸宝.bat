@ECHO OFF
adb devices
SET ADBS=-s ZY22FKCVFP
SET /A COUNT=1
:LOOP
ECHO === LOOP %COUNT% ===
SET /A COUNT=%COUNT% + 1

ECHO %DATE% %TIME% Menu button
CALL adb_random_tap.bat 1560 540 60 30
TIMEOUT 5

ECHO %DATE% %TIME% Select item
CALL adb_random_tap.bat 1230 500 100 300
TIMEOUT 5

ECHO %DATE% %TIME% Confirm selection
CALL adb_random_tap.bat 1460 1000 100 30
TIMEOUT 15

ECHO %DATE% %TIME% Jump
CALL adb_random_tap.bat 2150 700 50 50
TIMEOUT 15

GOTO LOOP
