# Deploy Flask Hello World Application on EKS
## Automate Build using Jenkins

Directory structure
```
.
├── Dockerfile          Docker file for container
├── hello.py            Hello World python file
├── README.md           This README file you are reading right now
└── shell-commands.sh   A list of useful commands
```
### Step 0 > Start and Configure your environment
 - Create Amazon Linux ec2 instance
 - install docker
 - install git
 - install jenkins
 - start docker
 - give current user and jenkins to use docker without root privelages
```
sudo groupadd docker # create group
sudo usermod -aG docker ${USER} # add currrent user
sudo usermod -aG docker jenkins # add jenkins
```
 - logout and login from ec2 user or Better to restart your instance to apply changes
 - Test your Flask Application on host machine (optional)
```
git clone https://github.com/anandshivam44/flask-hello-world.git
cd flask-hello-world
sudo yum install python3-pip
pip3 install Flask
python3 hello.py
```
open ec2 instance ip in a new tab with port 8081 
If it does not open check match all ports and check all security groups
  `
### Step 1 > Create/Analyse Dockerfile
```
# pick ubuntu image from Docker Hub
FROM ubuntu:20.04

# update list of available package && install pip3 package manager, dev essentials
RUN apt-get update && apt-get install -y python3-pip python-dev

# set work directory inside Docker image
WORKDIR /app

# install Flask inside container
RUN pip3 install Flask

# copy project files to WORKDIR
COPY . /app

# App started on port 8081 so expose the same port
EXPOSE 8081

# entrypoint for docker run command
ENTRYPO
CMD [ "hello.py" ]
```
## Step 2.x is optional and for testing only
### Step 2.0 > Build Docker Image from Dockerfile manually
```
docker build -t flask-tutorial:v1 .
```
or directly pull source from this repository and build image
```
docker build github.com/anandshivam44/flask-hello-world
```
### Step 2.1 > Run Image and test it in your local system 

Enter this command and login your hub.docker.com credentials
```
docker run -d -p 8081:8081 flask-hello-world
```
Container runs in https://localhost:8081



### Step 2.2 > Login to DockerHub
Enter this command and login your hub.docker.com credentials

```
docker login
```
### Step 2.3 > Commit your container and push to dockerhub

Copy ID of your Docker Container in clipboard from
```
docker ps
```
Replace 68339d202950 with your container ID and commit your changes
```
docker commit 68339d202950 anandshivam44/flask-hello-world:v1
```
Push to Docker Hub. Replace anandshivam44 with your id, flask-hello-world with your container name and v1 with your tag name. Replce similar reference in this article.
```
docker push anandshivam44/flask-hello-world:v1
```
### Step 3 > Jenkins: Build container on new commit from Github and push to Docker Hub
 - Open Jenkins on ec2 instance. Open public ip on port 8080
 - First install Docker Plugins 
  Goto Manage Jenkins > Plugins >  Available
  Search Docker and install Docker plugin by CloudBees (CloudBees is the maintainer of Jenkins project) 
  Install Docker Plugin
 - Goto HomePage 
 - Create new job
 - Create a new Freestyle Project. Click OK
 - In the configuration page add Github URL https://github.com/anandshivam44/flask-hello-world
 - In Source code management select git add repository git url https://github.com/anandshivam44/flask-hello-world.git
 - Since this repo is public no need to give Credentials
 - In Build Triggers choose Poll SCM. Add cron-job task "* * * * *" without quotes. This will check Github repo every minute for any change. If there is a change it will start a new build 
 - In Build section > Add Build Step > Choose 'Docker Build and Publish'
 - Add Docker Hub repsitory. In my case anandshivam44/flask-hello-world. The format is username/imagename
 - Choose/Add dockehub credentials
 - Save change
 - Click Build now
### Step 4 > Create Cluster in Amazon ECS
Create cluster in Amazon ECS
 - Goto AWS ECS > Cluster and click on Create Cluster
 - Select cluster template as Networking only. Click NEXT.
 - Type a cluster name. Do not create VPC for demo easy deplyment. Leave all to default and click NEXT.
### Step 5 > Create and Define Task
 - Goto Task Definition. Choose AWS Fargare. Click Next.
 - Type a Task Definition name of your choice
 - Select Task role to None. We don't need a role for now
 - Set Task memory to 1 GB and CPY to 0.25 vCPU
 - Click Add container definition
 - Type a container name that points to dockerhub anandshivam44/flask-hello-world
 - Set container image to. It will download from Docker Hub
  ```
anandshivam44/flask-hello-world
  ```
 - Set Soft limit to 300 MB
 - Set Port Mapping to 8081
 - Leave everyting to default and click Add
 - Click create to create Task Definition

### Step 6 > Create Load Balancer
 - In a new Tab GoTo  ec2 > Load Balancer > Create Load Balancer
 - Select HTTP/HTTPS Application Load Balancer
 - Name you Load Blancer your choice
 - Scheme - internet facing
 - IP address type ipv4
 - Listnet HTTP on port 80
 - Select default vpc (mumbai) and choose subnet 1a and 1b. Do not choose 1c. 1c does not support t2 micro free instance
 - Leave all defaults and click Next
 - In Security Settings leave everything as it is click next
 - Create a new security group. Name it. Open TCP on port 80. Click Next. Protocol HTTP. Port 80.
 - Create a Terget group. Target type IP. Leave all default. Click Next
 - Leave Register Target Type as empty
 - Review and create LB
 - Wait for ABS to create before you proceed. It will take some minutes.
### Step 7 > Create Service
 - Go back to ECS > Clusters > Choose your cluster > Services
 - Clck create cluster
 - Choose launch type AWS Fargate
 - Choose task definition that we created
 - Give service a name
 - Number of tasks as 2 (You can even choose 1 or n)
 - Leave all default and click Next
 - Choose the VPC as default as we selected before. Subnet mumbai 1a and 1b
 - Choose a security group for Service
 - Auto assign IP Enabled. Leave al default. Click Next
 - Choose Application Load Balancer and select the one we created
 - Click 'Add to load balancer' IMPORTANT
 - port 80 HTTP
 - Choose the Traget Group we created
 - Leave all default. Click Next
 - Leave Auto Scaling to derfault. Click Next
 - Click Create service
### Step 8 > Verify Security Groups
 - Till now one Security Group (SG) was assigned to ous ECS Cluster and one to our ECS ec2 instance. Goto SG and allow LB to talk to Cluster ec2. In inbound rules allow all TCP from LB Security Group to ECS ec2 so that health check suceeds.
### Step 9 > Hurray! Test you connection
 - Goto LB. Copy its dns url. and test your connection. You should see a hello world on your screen
### Step 10 > Cleaning up
 - Delete ec2 instance
 - Goto Dockerhub and delete your repository
 - Goto AWS ECS and Delete Cluster and Task
 - Goto AWS ALB and delete LB

