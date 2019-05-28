# This Dockerfile implements multi-stage builds
# Stage for just requirements because it relies on ssh keys.
FROM python:3.7.3-stretch as requirements

MAINTAINER kumarnotifications@gmail.com

# add credentials on build
ARG SSH_PRIVATE_KEY
RUN mkdir /root/.ssh/
RUN echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# make sure gitlab domain is accepted
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan gitlab.com >> /root/.ssh/known_hosts

# requirements.txt access a repository over ssh in gitlab.com.
COPY requirements.txt /
WORKDIR /requirements
# pip download just downloads all the dependencies into the current directory.
RUN pip download -r /requirements.txt

# Actual production stage.
FROM python:3.7.3-slim-stretch

WORKDIR /opt/app 

COPY --from=requirements /requirements /requirements
COPY app.py              /opt/app/app.py

# Install packages
RUN pip install --no-index --find-links=/requirements/ /requirements/*

CMD ["python3","app.py"]
