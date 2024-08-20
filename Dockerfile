# syntax=docker/dockerfile:1
FROM python:3.10-slim-buster
# setup environment variable  
ENV DockerHOME=/home/ing/wprojects/composetest/compose
RUN mkdir -p $DockerHOME  
WORKDIR $DockerHOME  
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1  
COPY . $DockerHOME 
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
RUN pip install --upgrade pip

COPY . .
# start server  
CMD python manage.py runserver 0.0.0.0:8080




