terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.52.0"
    }
  }
}

terraform {
  required_version = ">=0.13"
}

provider "aws" {
  region     = "us-east-2"
}

resource "aws_security_group_rule" "example1" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "sg-DockerVMSSH"
}

resource "aws_security_group_rule" "example2" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "sg-DockerVMHTTP"
}

resource "aws_security_group_rule" "example3" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "sg-DockerVMout"
}


resource "aws_instance" "myec2" {
   ami = "ami-05842f1afbf311a43"
   instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.allow_secid.id]
//   security_groups = [aws_security_group_rule.example1.id]
//   security_groups = [aws_security_group_rule.example2.id]
  // security_groups = [aws_security_group_rule.example3.id]
   key_name = "jenkins"
  tags = {
    Name = "Docker VM"
  }
provisioner "local-exec" {
command="echo $(aws_instance.myec2.public_ip] >> /etc/ansible/hosts"
}
}
