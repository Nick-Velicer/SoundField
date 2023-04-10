@echo off

set "file_name=output.csv"
call venvSetup.bat
call .venv\Scripts\activate.bat
cd local
:loop
if exist "%file_name%" (
  echo File Found
  cd ..
  cd Sprints\Sprint12\CNN_SAE_DNN
  python prog.2.1.py
  cd ..
  cd ..
  cd ..
  cd local
  del "%file_name%"
  goto :loop
) else (
  echo Waiting For File
  timeout /t 1 /nobreak >nul
  goto :loop
)

