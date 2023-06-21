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
   ami = "ami-083eed19fc801d7a4"
   instance_type = "t2.micro"
 #  security_groups = [ ]
   key_name = "Ansible"
  tags = {
    Name = "HelloWorld -AKASH"
  }
}
