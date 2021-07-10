FROM ubuntu:20.04

#MAINTANER Your Name "anand.shivam44@yahoo.com"

RUN apt-get update && apt-get install -y python3-pip python-dev
WORKDIR /app

RUN pip3 install Flask

COPY . /app

EXPOSE 8081

ENTRYPOINT [ "python3" ]

CMD [ "hello.py" ]
