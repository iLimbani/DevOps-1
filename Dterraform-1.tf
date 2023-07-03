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

resource "aws_instance" "myec2" {
   ami = "ami-05842f1afbf311a43"
   instance_type = "t2.micro"
vpc_security_group_ids = [aws_security_group.allow_tls.id]  
key_name = "jenkins"
  tags = {
    Name = "Docker VM"
  }
 
 connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker",
    ]
  }
}

resource "aws_security_group" "allow_tls" {
  name = "terraform-sg"
  ingress {
    description = "allow port 22 - inbound"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    description = "allow port 80 - inbound"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  egress{
    description = "outbound"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

