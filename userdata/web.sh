#! /bin/sh

sudo apt-get update -y
sudo apt-get install -y docker
sudo service docker start 
sudo usermod -a -G docker ec2-user
chkconfig docker on
docker build -t myapp .
docker container run -p 80:80 myapp