terraform {
  cloud {
    organization = "moses81"

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
    region = "us-east-2"
}


resource "aws_instance" "admin_frontend" {
    ami = "ami-05983a09f7dc1c18f"
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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC0B7G271baS7YOd+rt0yiCGuQrLld/POpGD0EOiB7FZhYZ41uMgtJdDwYn/ziL5KCrnUci8PAHZlAhZCTfRJIzSLtq7kwMZi8t9oXw+uzOSJPYozw7FeVaWZOZZe72yMKVYIEjHSVOXrAvan9OZK0l53NcuX3S/qYV8cgzBVM2WrLotVBLwD5FTfTGnE7FFJoZiZ6t3ACVTrwOIxng6iAHWAz4TSjeZT+dHwktUpeQaOWm5/KPzd8FiSpVnerqEYZReO/xoGvE49SWlQRA0iQ0hMzM/R+/l8GgU20QkqQeX2Q6I9fqGkJbiMPQhXBqvGGNgK5QpYW+zkcuZhtfdSAQfDGIe/uKVatyUL3R/Fehrj5ML/qSJX3BHKSIJRogg3UJjViRb6JXAg+1a4RAIncz1vueSbvfzfdqX4hDFahXc0HyCxel6T65xAcup/LjG+u/IEtUrvXKEK7ukzn6Qtj77Rqucb01w/6tiGcNloocopyu92I79kvN0sNVuv3t3G7TMZ8HlMGYZKHMr5zjpxLiPTDl5hBuFbBtYV/b+NeQ6BMQGF6K9WTq8UZ3n7BVGYUVXXBNfnTC2ZzHPt9NVR5hyA3nyJ+gji9CTln7s7oRnKxVkHMBqpC0yE3ygvIOV/254c1/ZcYJKedCDOxjpM2jONfhcVHtFdo1rm78ol/jiw== mchaise@Mosess-MacBook-Air.local"
}

