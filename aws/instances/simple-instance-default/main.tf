resource "aws_instance" "cloudify-pedrops" {
  ami           = "ami-b70554c8"
  instance_type = "m4.large"
  subnet_id = "subnet-02bc1266"
  key_name = "devops-skyone-solutions"
  security_groups = [
    "sg-1bbf0350"
  ] 
  tags {
    Name = "cloudi-fy-pedro.silva.SkyONe"
  }  

  ebs_block_device {
    delete_on_termination = false
    device_name = "/dev/xvdb"
    volume_size = "18"
    volume_type = "standard"
  }
}