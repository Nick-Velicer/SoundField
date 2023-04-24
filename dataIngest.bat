@echo off
set "file_name=local\output.csv"
call .venv\Scripts\activate.bat
:loop
if exist "%file_name%" (
  echo File Found
  copy local\output.csv models\output.csv
  cd models
  python prog.3.0.py
  cd ..
  processing\install\processing-4.2\processing-java --output=%cd%\processing\autogen --force --sketch=%cd%\processing\genArtProg --run
  cd processing
  python renameFrames.py
  install\processing-4.2\tools\MovieMaker\tool\ffmpeg.exe -y -framerate 24 -i "genArtProg\frames\%%05d.png" -c:v libx264 -r 24 -pix_fmt yuv420p output.mp4
  cd ..
  ::rd /s /q processing\genArtProg\frames\ 
  copy processing\output.mp4 frontend\soundfield_app\src\output.mp4
  del processing\output.mp4
  del local\output.csv
  del models\output.csv
  del processing\genArtProg\output.csv
  goto :loop
) else (
  echo Waiting For File
  timeout /t 1 /nobreak >nul
  goto :loop
)

