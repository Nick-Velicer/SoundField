@echo off

cd local

setlocal enabledelayedexpansion
set "watch_folder=%pwd%"
set "file_name=output.csv"

:loop
if exist "%file_name%" (
  echo "File found! Do some action here."
  rem TODO: Perform action
  del "%file_name%"
  goto :loop
) else (
  timeout /t 5 /nobreak >nul
  goto :loop
)