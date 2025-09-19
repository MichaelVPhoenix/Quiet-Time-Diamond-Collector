@echo off
REM QuietTimeDiamondCollector_launcher_with_app.bat
setlocal

REM directory of this BAT
set "curdir=%~dp0"

REM find preferred HTML: exact name, else first .html in folder
set "htmlfile=%curdir%Quiet Time Diamond Collector.html"


:found_html
if "%htmlfile%"=="" (
  echo No HTML file found in "%curdir%"
  pause
  exit /b 1
)

REM convert Windows path to file:/// URL (replace backslashes with slashes)
set "fileurl=%htmlfile:\=/%"
set "fileurl=file:///%fileurl%"

REM Try common Chromium browsers and open with --app
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" (
  start "" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" --app="%fileurl%"
  goto :done
)
if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" (
  start "" "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" --app="%fileurl%"
  goto :done
)
if exist "%LocalAppData%\Google\Chrome\Application\chrome.exe" (
  start "" "%LocalAppData%\Google\Chrome\Application\chrome.exe" --app="%fileurl%"
  goto :done
)
if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" (
  start "" "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" --app="%fileurl%"
  goto :done
)
if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" (
  start "" "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" --app="%fileurl%"
  goto :done
)
if exist "%ProgramFiles%\BraveSoftware\Brave-Browser\Application\brave.exe" (
  start "" "%ProgramFiles%\BraveSoftware\Brave-Browser\Application\brave.exe" --app="%fileurl%"
  goto :done
)
if exist "%ProgramFiles%\Vivaldi\Application\vivaldi.exe" (
  start "" "%ProgramFiles%\Vivaldi\Application\vivaldi.exe" --app="%fileurl%"
  goto :done
)

REM Try executables on PATH
where chrome >nul 2>nul && (start "" chrome --app="%fileurl%" & goto :done)
where msedge >nul 2>nul && (start "" msedge --app="%fileurl%" & goto :done)
where brave >nul 2>nul && (start "" brave --app="%fileurl%" & goto :done)
where vivaldi >nul 2>nul && (start "" vivaldi --app="%fileurl%" & goto :done)

REM fallback: open with default browser (no --app)
echo Couldn't find a Chromium browser in common locations. Opening with default browser...
start "" "%htmlfile%"

:done
endlocal
exit /b 0
