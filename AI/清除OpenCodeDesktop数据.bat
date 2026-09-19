@ECHO OFF
CHCP 65001 >NUL
TITLE Clear OpenCode / OpenCodeDesktop Data

SETLOCAL ENABLEDELAYEDEXPANSION

ECHO ============================================
ECHO    Delete OpenCode / OpenCodeDesktop Data
ECHO ============================================
ECHO.

ECHO Choose product to clear:
ECHO   [1] OpenCode (CLI)
ECHO   [2] OpenCodeDesktop (Desktop App)
ECHO   [3] Both
ECHO   [Q] Quit
ECHO.

SET /P PRODUCT="Enter choice (1/2/3/Q): "

IF /I "%PRODUCT%"=="Q" GOTO :QUIT
IF "%PRODUCT%"=="1" GOTO :MENU_OC
IF "%PRODUCT%"=="2" GOTO :MENU_DT
IF "%PRODUCT%"=="3" GOTO :MENU_BOTH

ECHO Invalid choice, exiting.
GOTO :QUIT

:MENU_OC
ECHO.
ECHO OpenCode (CLI) data scope:
ECHO   [A] Full reset - All data + config (^= reinstall state)
ECHO   [D] Data only  - Account/auth/db/logs/cache (keep config)
ECHO   [B] Back       - Go back
ECHO.
SET /P SCOPE="Enter choice (A/D/B): "
IF /I "%SCOPE%"=="B" GOTO :START
IF /I "%SCOPE%"=="A" GOTO :CONFIRM_OC_FULL
IF /I "%SCOPE%"=="D" GOTO :CONFIRM_OC_DATA
ECHO Invalid choice, exiting.
GOTO :QUIT

:MENU_DT
ECHO.
ECHO OpenCodeDesktop (Desktop App) data scope:
ECHO   [A] Full reset - All data + updater
ECHO   [C] Cache only - Cache/code-cache/GPU-cache only
ECHO   [B] Back       - Go back
ECHO.
SET /P SCOPE="Enter choice (A/C/B): "
IF /I "%SCOPE%"=="B" GOTO :START
IF /I "%SCOPE%"=="A" GOTO :CONFIRM_DT_FULL
IF /I "%SCOPE%"=="C" GOTO :CONFIRM_DT_CACHE
ECHO Invalid choice, exiting.
GOTO :QUIT

:MENU_BOTH
ECHO.
ECHO Clear BOTH OpenCode + OpenCodeDesktop:
ECHO   [A] Full reset for both
ECHO   [D] Data only (keep configs)
ECHO   [B] Back
ECHO.
SET /P SCOPE="Enter choice (A/D/B): "
IF /I "%SCOPE%"=="B" GOTO :START
IF /I "%SCOPE%"=="A" GOTO :CONFIRM_BOTH_FULL
IF /I "%SCOPE%"=="D" GOTO :CONFIRM_BOTH_DATA
ECHO Invalid choice, exiting.
GOTO :QUIT

REM ============================================================
REM  Confirmations
REM ============================================================

:CONFIRM_OC_FULL
ECHO.
ECHO This will delete ALL OpenCode (CLI) data including config files:
ECHO   - %USERPROFILE%\.local\share\opencode
ECHO   - %USERPROFILE%\.local\state\opencode
ECHO   - %USERPROFILE%\.opencode
ECHO   - %USERPROFILE%\.config\opencode
ECHO.
SET /P CFM="Confirm? (Y/N): "
IF /I NOT "%CFM%"=="Y" GOTO :QUIT
CALL :CLEAR_OC_SHARE
CALL :CLEAR_OC_STATE
CALL :CLEAR_OC_PROJECT
CALL :CLEAR_OC_CONFIG
GOTO :DONE

:CONFIRM_OC_DATA
ECHO.
ECHO This will delete OpenCode (CLI) runtime data:
ECHO   - %USERPROFILE%\.local\share\opencode
ECHO   - %USERPROFILE%\.local\state\opencode
ECHO.
SET /P CFM="Confirm? (Y/N): "
IF /I NOT "%CFM%"=="Y" GOTO :QUIT
CALL :CLEAR_OC_SHARE
CALL :CLEAR_OC_STATE
GOTO :DONE

:CONFIRM_DT_FULL
ECHO.
ECHO This will delete ALL OpenCodeDesktop data:
ECHO   - %APPDATA%\ai.opencode.desktop
ECHO   - %LOCALAPPDATA%\@opencode-aidesktop-updater
ECHO   - %TEMP%\opencode
ECHO.
SET /P CFM="Confirm? (Y/N): "
IF /I NOT "%CFM%"=="Y" GOTO :QUIT
CALL :CLEAR_DT_APPDATA
CALL :CLEAR_DT_UPDATER
CALL :CLEAR_DT_TEMP
GOTO :DONE

:CONFIRM_DT_CACHE
ECHO.
ECHO This will delete OpenCodeDesktop cache only:
ECHO   - Browser Cache / Code Cache / GPUCache / DawnCache
ECHO   - %TEMP%\opencode
ECHO.
SET /P CFM="Confirm? (Y/N): "
IF /I NOT "%CFM%"=="Y" GOTO :QUIT
CALL :CLEAR_DT_CACHE
CALL :CLEAR_DT_TEMP
GOTO :DONE

:CONFIRM_BOTH_FULL
ECHO.
ECHO This will delete ALL data for BOTH OpenCode and OpenCodeDesktop.
ECHO.
SET /P CFM="Confirm? (Y/N): "
IF /I NOT "%CFM%"=="Y" GOTO :QUIT
CALL :CLEAR_OC_SHARE
CALL :CLEAR_OC_STATE
CALL :CLEAR_OC_PROJECT
CALL :CLEAR_OC_CONFIG
CALL :CLEAR_DT_APPDATA
CALL :CLEAR_DT_UPDATER
CALL :CLEAR_DT_TEMP
GOTO :DONE

:CONFIRM_BOTH_DATA
ECHO.
ECHO This will delete runtime data for both, keeping configs.
ECHO.
SET /P CFM="Confirm? (Y/N): "
IF /I NOT "%CFM%"=="Y" GOTO :QUIT
CALL :CLEAR_OC_SHARE
CALL :CLEAR_OC_STATE
CALL :CLEAR_DT_APPDATA
CALL :CLEAR_DT_TEMP
GOTO :DONE

REM ============================================================
REM  OpenCode (CLI) helpers
REM ============================================================

:CLEAR_OC_SHARE
SET "D=%USERPROFILE%\.local\share\opencode"
CALL :RMDIR "%D%" "OC share"
EXIT /B

:CLEAR_OC_STATE
SET "D=%USERPROFILE%\.local\state\opencode"
CALL :RMDIR "%D%" "OC state"
EXIT /B

:CLEAR_OC_PROJECT
SET "D=%USERPROFILE%\.opencode"
CALL :RMDIR "%D%" "OC project"
EXIT /B

:CLEAR_OC_CONFIG
SET "D=%USERPROFILE%\.config\opencode"
CALL :RMDIR "%D%" "OC config"
EXIT /B

REM ============================================================
REM  OpenCodeDesktop helpers
REM ============================================================

:CLEAR_DT_APPDATA
SET "D=%APPDATA%\ai.opencode.desktop"
CALL :RMDIR "%D%" "Desktop app data"
EXIT /B

:CLEAR_DT_UPDATER
SET "D=%LOCALAPPDATA%\@opencode-aidesktop-updater"
CALL :RMDIR "%D%" "Desktop updater"
EXIT /B

:CLEAR_DT_TEMP
SET "D=%TEMP%\opencode"
CALL :RMDIR "%D%" "Desktop temp"
EXIT /B

:CLEAR_DT_CACHE
SET "BASE=%APPDATA%\ai.opencode.desktop"
IF NOT EXIST "%BASE%" (
    ECHO    [SKIP] Desktop app data not found
    EXIT /B
)
FOR %%D IN ("Cache" "Code Cache" "GPUCache" "DawnGraphiteCache" "DawnWebGPUCache" "blob_storage" "Network" "SharedStorage" "SharedStorage-wal" "DIPS" "DIPS-wal") DO (
    SET "DP=%BASE%\%%~D"
    IF EXIST "!DP!" (
        ECHO    Deleting: !DP!
        RMDIR /S /Q "!DP!" 2>NUL
        IF EXIST "!DP!" (
            ECHO    [WARN] Could not fully delete !DP!
        ) ELSE (
            ECHO    [OK] Deleted
        )
    ) ELSE (
        ECHO    [SKIP] !DP! not found
    )
)
EXIT /B

REM ============================================================
REM  Generic directory removal helper
REM ============================================================

:RMDIR
IF EXIST "%~1" (
    ECHO    Deleting: %~1
    RMDIR /S /Q "%~1" 2>NUL
    IF EXIST "%~1" (
        ECHO    [WARN] Could not fully delete %~1 (files may be in use)
    ) ELSE (
        ECHO    [OK] Deleted
    )
) ELSE (
    ECHO    [SKIP] %~1 does not exist
)
EXIT /B

REM ============================================================

:DONE
ECHO.
ECHO Done. Please restart OpenCode / OpenCodeDesktop for changes to take effect.
GOTO :END

:QUIT
ECHO.
ECHO Exited without any deletion.

:END
ECHO.
PAUSE
