# Check active ports
sudo lsof -i -P -n | grep LISTEN
sudo netstat -tulpn | grep LISTEN
sudo ss -tulpn | grep LISTEN
# see which user can run docker
grep docker /etc/group
# Add users to use jenkins without root or sudo
sudo groupadd docker # create group
sudo usermod -aG docker ${USER}
sudo usermod -aG docker jenkins

# update repository
sudo yum update -y
# install Docker
sudo yum install -y docker
# install Docker in Amazon linux 
sudo yum install docker
# get current user
whoami
# Give docker root access to current user. This avaoids writing sudo everytime. 
sudo usermod -a -G docker ec2-user
# start Docker
sudo service docker start
# Get all Images
sudo docker images
# Get all containers
sudo docker ps -a
# Remove all Docker containers
sudo docker rm -vf $(docker ps -a -q)
# Remove all Docker Images
sudo docker rmi -f $(docker images -a -q)
# Run a container and SSH into it.
sudo docker run -it ubuntu:20.04 /bin/bash
# install pip3 package manager
sudo yum install python3-pip
# Check Docker status
sudo service docker status
# Build Image
sudo docker build -t flask-tutorial:v1 .
# Clones a public github repo and builds Dockerfile from the root of 
sudo docker build github.com/anandshivam44/flask-hello-world
# run custom made image and map ports
sudo docker run -p 80:80 flask-hello-world
sudo docker run -it -p 80:80 -p 8080:8080 -p 443:443 flask-tutorial:v1
# Run container in detach mode -d
docker run -it -d ubuntu
# Execute Bash of a running container
docker exec -it [ID] bash
# sample run command
sudo docker run -d -p 80:80 anandshivam44/flask-hello-world:v1

# Login before push-ing to dockerhub
docker login
# push to dockerhub
docker push anandshivam44/flask-hello-world:v1
# Pull from dockerhub
sudo docker pull anandshivam44/flask-hello-world:v1


# Install Jenkins in Amazon Linux https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/

sudo yum update –y

Add the Jenkins repo using the following command:

[ec2-user ~]$ sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo

Import a key file from Jenkins-CI to enable installation from the package:
[ec2-user ~]$ sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

sudo yum upgrade
sudo yum install jenkins java-1.8.0-openjdk-devel -y

sudo systemctl daemon-reload

sudo systemctl start jenkins

sudo systemctl status jenkins


##Configure Jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword



