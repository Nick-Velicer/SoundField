@echo off

set "file_name=output.csv"
call venvSetup.bat
call .venv\Scripts\activate.bat
cd local
:loop
if exist "%file_name%" (
  echo File Found
  cd ..
  cd frontend/soundfield_app
  type nul rendering.txt
  cd ..
  cd ..
  cd Sprints\Sprint12\CNN_SAE_DNN
  python prog.2.1.py
  cd ..
  cd ..
  cd ..
  cd frontend/soundfield_app
  del rendering.txt
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

