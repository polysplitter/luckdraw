FROM ubuntu:18.04

# https://askubuntu.com/questions/496549/error-you-must-put-some-source-uris-in-your-sources-list fixes the issue with psycopg2
ENV DEBIAN_FRONTEND=noninteractive

RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get install -y python-pip python-dev && \
    apt-get build-dep -y python-psycopg2

COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip install -r requirements.txt

COPY . /app

ENTRYPOINT [ "python" ]
CMD [ "app.py" ]