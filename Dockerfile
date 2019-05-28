# This Dockerfile implements multi-stage builds to create a slim image.
FROM python:3.7.3-alpine3.9 as requirements

MAINTAINER kumarnotifications@gmail.com

WORKDIR /requirements

# pip download just downloads all the dependencies into the current directory.
RUN apk add --no-cache git \
                       gcc \
                       linux-headers \
                       musl-dev \
                       libffi-dev \
                       openssl-dev

COPY requirements.txt /
RUN pip install -t /requirements -r /requirements.txt

# Actual production stage.
FROM python:3.7.3-alpine3.9

WORKDIR /opt/app 

COPY --from=requirements /requirements /opt/app
COPY app.py              /opt/app/app.py

CMD ["python3","app.py"]
