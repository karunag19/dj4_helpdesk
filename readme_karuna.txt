Run the application:
    docker-compose up --build
    Note:
        cosmos related information is stored in .env file.  (it wount uploed to git)
            Create .env file with -> ACCOUNT_URI, ACCOUNT_KEY

reate a folder with the following files:
    docker-compose.yml
    Dockerfile
    requirement.txt

Now you can build the container
To build: container with container image name django_1 folder run the following command
    docker build -t dj4_async .
    Note: some time u will get an permission error while building, delete the log files inside uwsgi & nginx, it was 
            written by root user.  when the build copy the code folder, it would get an error.
Once build completed you need to create django project
    docker-compose run web django-admin startproject <project name> .
    e.g
    docker-compose run web django-admin startproject async_dydb .

Once build completed, you have to run makemigrations in django, For fresh install we directly run the migration command
    docker-compose run web python3 manage.py makemigrations

One that is done you have to run migration command.
    docker-compose run web python3 manage.py migrate

Create super user:
    docker-compose run web python3 manage.py createsuperuser
    user: karuna
    pw: Karuna@123

Change the docker-compose.yml file to include project name path : <project name>/manage.py

Change the root folder(project folder) owner to karuna:karuna for development purpose
    sudo chown -R karuna:karuna async_dydb
    sudo chown -R karuna:karuna db.sqlite3

Change the setting.py file to allow localhost - this is for development
        rmate async_dydb/setting.py


    edit the setting.py file and include the following lines at the end of the file....
    
    ALLOWED_HOSTS = [
        '10.10.42.26',
    ]
   
Once completed, run the following command to run the project
    docker-compose up --build

To create application inside Django:
    docker-compose run web django-admin startapp <app name>
    e.g.
    docker-compose run web django-admin startapp movies
    docker-compose run web django-admin startapp stories

Login to Docker:
        docker-compose exec web sh
        Note: To run the above command, the container should be up and running.
            Run the container: docker-compose up

It will run the application in the following url:
    http://10.10.42.26:8000/
    you can view the django default page.
    To Test the app:
        http://10.10.42.26:8000/sync
        Return: sync - view
        Note: In the terminal, you can see the total time to complete. it would take 7 sec to complete.
            web_1  | prepare to get the movies...
            web_1  | got all the movies!
            web_1  | prepare to get the stories...
            web_1  | got all the stories!
            web_1  | total:  7.0074303150177

        http://10.10.42.26:8000/async
        Return: async
        Note: In the terminal, you can see the total time to complete. it would take 5 sec to complete.
            web_1  | prepare to get the movies...
            web_1  | prepare to get the stories...
            web_1  | got all the movies!
            web_1  | got all the stories!
            web_1  | total:  5.002063512802124

