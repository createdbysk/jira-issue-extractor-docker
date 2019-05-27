FROM python:3.7.3-stretch

MAINTAINER kumarnotifications@gmail.com

WORKDIR /opt/app

COPY requirements.txt /opt/requirements/requirements.txt
COPY app.py           /opt/app/app.py

RUN pip install -r /opt/requirements/requirements.txt

CMD ["python3","app.py"]
