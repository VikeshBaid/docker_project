# start from an official image
FROM python:3.6

# working directory
RUN mkdir -p /opt/services/djangoapp/src
WORKDIR /opt/services/djangoapp/src

# install our two dependencies
# we use --system flag so no new virtual environment is created
COPY Pipfile Pipfile.lock /opt/services/djangoapp/src/
RUN pip install pipenv && pipenv install --system

# copy our project
COPY . /opt/services/djangoapp/src

# expose the port 8000
EXPOSE 8080

# define the default command to run when starting the container
CMD ["gunicorn", "--chdir", "mb", "--bind", ":8000", "mb_project.wsgi:application"]
