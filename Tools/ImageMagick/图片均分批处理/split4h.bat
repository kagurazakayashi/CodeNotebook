@ECHO OFF
SETLOCAL ENABLEEXTENSIONS

REM ============================================================
REM  split4h.bat - Split an image into four horizontal strips.
REM
REM  Each output keeps the full image width and 1/4 of the height
REM  (the image is cut horizontally into four equal parts, from
REM  top to bottom).
REM
REM  Usage:
REM      split4h.bat <image_file>
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

REM Crop 100%% width x 25%% height -> 4 horizontal strips (top to bottom).
magick "%IMG%" -crop 100%%x25%% +repage "%OUT%_part-%%d%~x1"

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