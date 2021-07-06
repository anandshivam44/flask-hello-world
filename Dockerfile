FROM ubuntu:20.04

#MAINTANER Your Name "anand.shivam44@yahoo.com"

RUN apt update && apt-get install -y python3-pip python-dev

# We copy just the requirements.txt first to leverage Docker cache
#COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip3 install Flask

COPY . /app

ENTRYPOINT [ "python3" ]

CMD [ "hello.py" ]
