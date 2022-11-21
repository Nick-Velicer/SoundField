This is a collection of commands and things to do
for testing and developing SoundField, please add
here and update as you see fit.

To test the rest app (starting from .../Soundfield):
    1. If not already created locally, make an environment
       to run django commands in. Do not commit or add it
       to git, it will not work and this is for running
       locally anyways (starting from .../Soundfield):
       python -m venv env
       source env/bin/activate
       pip install django
       pip install djangorestframework
       pip install pygments
      
       *this should only need to happen once unless
       something gets broken, in which case delete
       /env and run these again

    2. Load the environment with django dependencies:
       source env/Scripts/activate 

    3. Navigate to the rest folder and start the local server:
       cd rest
       python manage.py 8000
    
    4. Open localhost:8000 in browser and navigate to
       the url's specified in rest/restApp/urls.py for
       access to the corresponding api endpoints

To test the front end (starting from .../Soundfield):
    1. Compile and start the docker containers:
       docker-compose up
    
    2. Open localhost:8080 in browser, currently only
       displaying NGINX confirmation
    
    3. To stop the containers, either go through
       Docker Desktop or run docker-compose down
