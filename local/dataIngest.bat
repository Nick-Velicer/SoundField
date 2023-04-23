@echo off

set "file_name=output.csv"
call venvSetup.bat
call .venv\Scripts\activate.bat
cd local
:loop
if exist "%file_name%" (
  set "local_dir=%cd%"
  echo File Found
  cd ..
  set "processing_dir='%cd%\processing'"
  cd Sprints\Sprint13\MLMODEL
  copy "%local_dir%\output.csv" .
  python prog.3.0.py
  
  cd ..
  copy "MRNN\output.csv" %processing_dir%
  cd ..
  cd ..
  cd processing
  rmdir frames
  mkdir frames
  install\processing-4.2\processing-java --output=frames\ --force --sketch=genArtProg --run
  cd ..
  cd local
  del "%file_name%"
  goto :loop
) else (
  echo Waiting For File
  timeout /t 1 /nobreak >nul
  goto :loop
)

