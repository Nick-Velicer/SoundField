FROM python:3.9

# set the working directory
WORKDIR /app

# add and install requirements
ADD requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

# add the rest of the code
ADD . /app/

# expose the port 8000
EXPOSE 8000

# run the command to start the server
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]