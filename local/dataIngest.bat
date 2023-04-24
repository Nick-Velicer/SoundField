@echo off

set "file_name=output.csv"
call .venv\Scripts\activate.bat
cd local
:loop
if exist "%file_name%" (
  set "local_dir=%cd%"
  echo File Found
  cd ..
  copy local\output.csv models\
  cd models
  python prog.3.0.py
  cd ..
  set "Soundfield_dir=%cd%"
  cd processing

  install\processing-4.2\processing-java --output=%cd%\frames --force --sketch=%cd%\genArtProg --run
  python renameFrames.py
  %Soundfield_dir%\processing\install\processing-4.2\tools\MovieMaker\tool\ffmpeg.exe -framerate 24 -i "genArtProg\frames\%05d.png" -c:v libx264 -r 24 -pix_fmt yuv420p output.mp4
  cd ..
  cd local
  del "%file_name%"
  goto :loop
) else (
  echo Waiting For File
  timeout /t 1 /nobreak >nul
  goto :loop
)

