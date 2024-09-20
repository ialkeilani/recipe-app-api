# FROM python:3.12.5-alpine3.20
FROM python:3
LABEL maintainer="ialkeilani.duckdns.org"

ENV PYTHONUNBUFFERED=1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false

# using the '&&' helps avoid having multiple layers on the image and thus keeps it more light-weight, since technically all the commands chained by '&&' are treated as a single command
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = 'true' ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        ialkeilani-jr

ENV PATH="/py/bin:$PATH"

# This is default command that will be run when a container based on this image is started using the 'docker run' command (see example in comments below).  It will be however over-ridden if the container is started with the 'docker compose' that utilizes a 'command' instruction under a service in the 'docker-compose.yml' file
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

#USER ialkeilani-jr

# build image using this command (after cd'ing into the project's root dir):
#   docker build . -t some_image_tag
# the '-t' flag is used to set a custom image tag which later on can be referenced when running a container based on this image.  otherwise, you'd have to make a note of the random image id number that docker creates and use that to run the container

# to run a container based on this image without using the 'docker compose' command nor utilizing the the container configs in 'docker-compose.yml', i.e to use the defaults in this Dockerfile (make sure you have a 'CMD' instruction):
#   docker run -p 8000:8000 some_image_tag
# other useful options:
#   -d: Run the container in detached mode (in the background)
#   --name mycontainer: Give the container a specific name


