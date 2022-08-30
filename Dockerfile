 # pull official base image
FROM python:3.8.3-alpine

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies
RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev 

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# copy project
COPY . .

# --------------------------------------------------------------------------Old------------
# FROM ubuntu 
 
#  #  Install
#  RUN apt-get update
#  RUN apt-get -y install python3
# #  RUN apt-get -y install python3-dev
#  RUN apt-get -y install python3-pip 

# #  #  -y uninterepted installation
# #  RUN apt-get -y install uwsgi
# #  RUN apt-get -y install uwsgi-plugin-python3


#  # if you are planning to use postgresql you required " libpq-dev postgresql-client" these packages
#  #---------------------------postgresql-client--------------------  
#  #  RUN apt-get -y install libpq-dev
#  #  RUN apt-get update
#  #  RUN apt-get -y install postgresql-client
#  #---------------------------------------------------------------- 

#  #  create a group "mygroup" with id "1024"
#  RUN addgroup --gid 1024 mygroup
#  # create user "myuser" and assign the group "1024" 
#  RUN adduser --disabled-password --gecos "" --force-badname --ingroup mygroup -u 1002 myuser 
#  RUN mkdir /code
#  WORKDIR /code
#  ADD . /code/

#  RUN pip3 install -r requirements.txt
# #  RUN chown -R myuser:mygroup /code
# #  USER myuser 

