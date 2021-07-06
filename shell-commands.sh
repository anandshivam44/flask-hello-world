# Get all Images
sodo docker images
# Get all containers
sodo docker ps -a
# Remove all Docker containers
docker rm -vf $(docker ps -a -q)
# Remove all Docker Images
docker rmi -f $(docker images -a -q)
# Run a container and SSH into it.
sudo docker run -it ubuntu:20.04 /bin/bash
# install pip3 package manager
sudo yum install python3-pip
# Check Docker status
sudo service docker status
# Build Image
sudo docker build -t flask-tutorial:v1 .
# run custom made image
sudo docker run -it -p 80:80 -p 8080:8080 -p 443:443 flask-tutorial:v1