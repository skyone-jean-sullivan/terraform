 
provider "aws" {
  access_key = "colocar aqui access key"
  secret_key = "colocar aqui a secret key"
  region     = "us-east-1"
}

resource "aws_instance" "All-ways-project" {
  ami           = "ami-xxxx"
  instance_type = "t2.micro"
  subnet_id = "subnet-xxxx"
  key_name = "pedrops"
  security_groups = [
    "sg-idxx"
  ] 
  tags {
    Name = "jenkins-dev"
  }  
  ebs_block_device {
    delete_on_termination = false
    device_name = "/dev/xvdb"
    volume_size = "18"
    volume_type = "gp2"
  }

  provisioner "file" {
    source      = "install-docker.sh"
    destination = "/home/ec2-user/install-docker.sh"
    
    connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = "${file("/Users/my-user/Desktop/pfeliciano/Ansible/ansible/files/pedrops.pem)}"
    agent = true
  }
  }
  provisioner "file" {
    source      = "jenkins.yml"
    destination = "/home/ec2-user/jenkins.yml"
    
    connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = "${file("/Users/my-user/Desktop/pfeliciano/Ansible/ansible/files/pedrops.pem")}"
    agent = true
  }
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /home/ec2-user/install-docker.sh",
      "/home/ec2-user/install-docker.sh",
    ]
    
    connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = "${file("/Users/my-user/Desktop/pfeliciano/Ansible/ansible/files/pedrops.pem")}"
    agent = true
  }
  }
}
