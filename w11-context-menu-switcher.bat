@echo off
chcp 65001 >nul
title Context Menu Switcher

:menu
cls
echo ⌜                                  ⌝
echo   WINDOWS 11 CONTEXT MENU SWITCHER
echo ⌞                                  ⌟
echo.
echo   1 - Windows 11 context menu
echo   2 - Classic context menu
echo   3 - Exit
echo.
choice /c 123 /n /m "Your choice: "

if errorlevel 3 goto exit
if errorlevel 2 goto apply
if errorlevel 1 goto restore

:apply
cls
echo Checking current state...
timeout /t 1 >nul
reg query "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve >nul 2>&1
if not errorlevel 1 (
    timeout /t 1 >nul
    echo.
    echo Classic menu is ALREADY enabled.
    goto already
)

echo Applying registry changes...
timeout /t 1 >nul
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /t REG_SZ /d "" /f >nul
if errorlevel 1 (
    echo.
    call :err "ERROR: failed to write to registry."
    goto done
)

echo Restarting Explorer...
timeout /t 1 >nul
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
call :ok "SUCCESS: classic menu enabled."
timeout /t 3 >nul
goto exit

:restore
cls
echo Checking current state...
timeout /t 1 >nul
reg query "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" >nul 2>&1
if errorlevel 1 (
    timeout /t 1 >nul
    echo.
    echo Windows 11 menu is ALREADY enabled.
    goto already
)

echo Restoring Windows 11 menu...
timeout /t 1 >nul
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul 2>&1
if errorlevel 1 (
    echo.
    call :err "ERROR: failed to delete registry key."
    goto done
)

echo Restarting Explorer...
timeout /t 1 >nul
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
call :ok "SUCCESS: Windows 11 menu enabled."
timeout /t 3 >nul
goto exit

:already
echo.
timeout /t 2 >nul
goto menu

:done
echo.
timeout /t 4 >nul
goto menu

:ok
powershell -NoProfile -Command "[Console]::OutputEncoding=[Text.Encoding]::UTF8; Write-Host '%~1' -ForegroundColor Green"
exit /b

:err
powershell -NoProfile -Command "[Console]::OutputEncoding=[Text.Encoding]::UTF8; Write-Host '%~1' -ForegroundColor Red"
exit /b

:exit
exit /b