@echo off

set "backend_status="
set "db_status="

for /f "tokens=2" %%i in ('docker ps -f "name=soundfield-db-1" --format "{{.Status}}"') do set "db_status=%%i"
for /f "tokens=2" %%i in ('docker ps -f "name=soundfield-django-1" --format "{{.Status}}"') do set "backend_status=%%i"

if (not %backend_status%=="Up") and (not %container_b_status%=="Up")(
    echo "Containers are not running, starting docker-compose..."
    start cmd.exe /c docker-compose up
)

start cmd.exe /c local\dataIngest.bat
cd frontend/soundfield_app
npm run electron-dev &
cd ..
cd ..


