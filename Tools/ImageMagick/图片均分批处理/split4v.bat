@ECHO OFF
SETLOCAL ENABLEEXTENSIONS

REM ============================================================
REM  split4v.bat - Split an image into four vertical strips.
REM
REM  Each output keeps the full image height and 1/4 of the width
REM  (the image is cut vertically into four equal parts, from
REM  left to right).
REM
REM  Usage:
REM      split4v.bat <image_file>
REM
REM  Requires ImageMagick 7 (magick.exe) on PATH.
REM ============================================================

IF "%~1"=="" (
    ECHO Usage: %~nx0 ^<image_file^>
    EXIT /B 1
)

SET "IMG=%~1"

IF NOT EXIST "%IMG%" (
    ECHO Error: file not found: "%IMG%"
    EXIT /B 1
)

REM Output prefix = input path without extension; extension kept.
SET "OUT=%~dpn1"

REM Crop 25%% width x 100%% height -> 4 vertical strips (left to right).
magick "%IMG%" -crop 25%%x100%% +repage "%OUT%_part-%%d%~x1"

IF ERRORLEVEL 1 (
    ECHO Error: ImageMagick failed to process "%IMG%".
    EXIT /B 1
)

ECHO Done. Created:
ECHO   "%OUT%_part-0%~x1"
ECHO   "%OUT%_part-1%~x1"
ECHO   "%OUT%_part-2%~x1"
ECHO   "%OUT%_part-3%~x1"

ENDLOCAL