# Check active ports using any of the commands
sudo lsof -i -P -n | grep LISTEN
sudo netstat -tulpn | grep LISTEN
sudo ss -tulpn | grep LISTEN

# update repository
sudo yum update -y
# install Docker
sudo yum install -y docker
# install Docker in Amazon linux 
sudo yum install docker
# get current user
whoami
# Give docker root access to current user. This avaoids writing sudo everytime. 
# see which user can run docker
grep docker /etc/group
# Add users to use jenkins without root or sudo
sudo groupadd docker # create group
sudo usermod -aG docker ${USER} # add currrent user
sudo usermod -aG docker jenkins # add user: jenkins
sudo usermod -a -G docker ec2-user # add a particular user manually
# start Docker
sudo service docker start
# Check Docker status
sudo service docker status
# Get all Images
sudo docker images
# Get all containers
sudo docker ps -a
# Remove all Docker containers locally
sudo docker rm -vf $(docker ps -a -q)
# Remove all Docker Images locally
sudo docker rmi -f $(docker images -a -q)
# Run a container and SSH into it.
sudo docker run -it ubuntu:20.04 /bin/bash
# install pip3 package manager
sudo yum install python3-pip
# Build Image
sudo docker build -t flask-tutorial:v1 .
# Clones a public github repo and builds Dockerfile from the root of 
sudo docker build github.com/anandshivam44/flask-hello-world
# run custom made image and map ports
sudo docker run -p 80:80 flask-hello-world
sudo docker run -it -p 80:80 -p 8080:8080 -p 443:443 flask-tutorial:v1
sudo docker run  -p 80:5000 -p 8080:8080 -p 443:443 crud-flask:v1
# Run container in detach mode -d
docker run -it -d ubuntu
# Execute and SSH into Bash of a running container
docker exec -it [ID] bash

sudo docker logs mysql_docker
#To check the location of the volumes, use the command:
sudo docker inspect [container_name]


# sample run command
sudo docker run -d -p 80:80 anandshivam44/flask-hello-world:v1
# Login before push-ing to dockerhub
docker login

sudo docker commit 68339d202950 anandshivam44/flask-hello-world:v1


# push to dockerhub
docker push anandshivam44/flask-hello-world:v1
# Pull from dockerhub
sudo docker pull anandshivam44/flask-hello-world:v1



#    ----------INSTALL JENKINS----------
# Install Jenkins in Amazon Linux https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/
sudo yum update ???y
#Add the Jenkins repo using the following command:
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
#Import a key file from Jenkins-CI to enable installation from the package:
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
# upgrade system
sudo yum upgrade
# install openjdk JAVA 8 and Jenkins
sudo yum install jenkins java-1.8.0-openjdk-devel -y
# reload daemon
sudo systemctl daemon-reload
# start jenkins
sudo systemctl start jenkins
# check ststus of Jenkins
sudo systemctl status jenkins
# While Configuring Jenkins default password is asked
sudo cat /var/lib/jenkins/secrets/initialAdminPassword






sudo docker run --name=shivam_my_sql -d mysql/mysql-server:latest
sudo docker run --name=[container_name] -d [image_tag_name]

sudo docker exec -it [container_name] bash

mysql -uroot -p

Finally, change the server root password to protect your information:

mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY '[newpassword]';


docker run \
--detach \
--name=[container_name] \
--env="MYSQL_ROOT_PASSWORD=[my_password]" \
--publish 6603:3306 \
--volume=/root/docker/[container_name]/conf.d:/etc/mysql/conf.d \
mysql



sudo snap install mysql-workbench-community

aws eks update-kubeconfig --name learn-shivam --region ap-south-1


aws eks update-kubeconfig --name eks-cluster-name --region aws-region --role-arn arn:aws:iam::XXXXXXXXXXXX:role/testrole


# check cluster status in command line after creating cluster
aws eks --region ap-south-1 describe-cluster --name  learn-shivam --query cluster.status

aws eks --region ap-south-1 update-kubeconfig --name  learn-shivam

aws eks update-kubeconfig --name learn-shivam --region ap-south-1 --role-arn arn:aws:iam::507799322916:role/aws-service-role/eks.amazonaws.com/AWSServiceRoleForAmazonEKS





