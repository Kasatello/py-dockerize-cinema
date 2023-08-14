FROM python:3.11-slim-buster
LABEL maintainer="reallynecessarytodo@gmail.com"

ENV PYTHONUNBUFFERED 1

WORKDIR cinema_service/

COPY requirements.txt requirements.txt

RUN apt-get update \
    && apt-get -y install libpq-dev gcc

RUN pip install -r requirements.txt

COPY . .

RUN mkdir -p /vol/web/media

RUN adduser \
        --disabled-password \
        --no-create-home \
        django-user

RUN chown -R django-user:django-user /vol/
RUN chown -R 755 /vol/web/

USER django-user
