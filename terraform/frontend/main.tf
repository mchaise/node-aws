terraform {
  cloud {
    organization = "gcretro"

    workspaces {
      name = "terraform-useast1-workspace"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
       version = ">= 5.26.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}


resource "aws_instance" "admin_frontend" {
    ami = "ami-016485166ec7fa705"
    instance_type = "t4g.small"
    vpc_security_group_ids = [aws_security_group.main.id]
    key_name = "aws_key"

    tags = {
            Name = "nextjs-docker"
    }

    depends_on = [
      aws_key_pair.devkey
    ]
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 3000
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 3000
  },
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
   }
  ]
}

resource "aws_key_pair" "devkey" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCl+y4xUjCFTdfz1Mss59twMnX9E0MVNekaaIkUN78+y06qfL3bd91T8KkzStN4uzSfdYWaGzPqVraVeryfnQdWqr6fzDC7j+V8fqeVQdx4q0spX1TuP9ieNtYTSNObk/V3OdA6/NB3T4zdrBMyECvVO0rswCTx+J7SIFngp2oT7CwEpr8DJN8PLPRrfmT3NarUMg0gvhKYeVJvYqC2ovHX9NCAl0hyndKH66zurCIMRuUHuiXA02GycNDGaPAPcotT9DI1oq3LxnyoVyoaKHXK8QxWCFlcd5fAnavPk5nBu2MlpI/ZtYoJ6njPY9R4oEXjYjo6ftqcng/6EiqQ4Qp7 sjagga@Mercys-MacBook-Air.local"
}

