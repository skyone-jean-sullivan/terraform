#!/bin/bash
sudo yum update -y
sudo yum install docker.x86_64 -y
sudo chkconfig on docker
sudo service docker start 
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo docker pull jenkins:latest
usermod -aG docker ec2-user

## Configurar EBS
sudo fdisk /dev/xvdb << EE0F
n
p
1


t
8e
w
EE0F
sudo mkdir /home/ec2-user/jenkins
sudo pvcreate -v /dev/xvdb1
sudo vgcreate jenkins /dev/xvdb1
sudo lvcreate -L 17G -n jenkinslv jenkins
sudo mkfs -t ext4 /dev/jenkins/jenkinslv
sudo mount -t ext4 /dev/jenkins/jenkinslv /home/ec2-user/jenkins
sudo chmod 777 /etc/fstab
sudo echo "/dev/jenkins/jenkinslv /home/ec2-user/jenkins ext4 defaults 0 0" >> /etc/fstab
sudo chmod 644 /etc/fstab
sudo chown -R 1000:1000 /home/ec2-user/jenkins
sudo /usr/local/bin/docker-compose -f /home/ec2-user/jenkins.yml up -d
