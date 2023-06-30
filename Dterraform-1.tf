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
}
