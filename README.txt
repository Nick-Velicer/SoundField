This is a collection of commands and things to do
for testing and developing SoundField, please add
here and update as you see fit.

To build and run the full app:
    1. Build new Docker containers with updates:
       docker-compose build
       docker-compose up
    
    2. In a new terminal window in frontend/soundfield_app:
       npm run electron-dev
    
    3. To stop the containers, run ctrl+c in the terminal window
       that Docker is running in

    4. If you ever need to clean the docker build, use:
       docker system prune 