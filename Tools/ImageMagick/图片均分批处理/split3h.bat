@ECHO OFF
SETLOCAL ENABLEEXTENSIONS

REM ============================================================
REM  split3h.bat - Split an image into three horizontal strips.
REM
REM  Each output keeps the full image width and 1/3 of the height
REM  (the image is cut horizontally into three equal parts, from
REM  top to bottom).
REM
REM  Usage:
REM      split3h.bat <image_file>
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

REM Crop into a 1x3 grid (1 column, 3 rows) -> 3 horizontal strips.
magick "%IMG%" -crop 1x3@ +repage "%OUT%_part-%%d%~x1"

IF ERRORLEVEL 1 (
    ECHO Error: ImageMagick failed to process "%IMG%".
    EXIT /B 1
)

ECHO Done. Created:
ECHO   "%OUT%_part-0%~x1"
ECHO   "%OUT%_part-1%~x1"
ECHO   "%OUT%_part-2%~x1"

ENDLOCAL