terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.95.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
  access_key = "AKIA4SYAMEUIDXWMSEWX"
  secret_key = "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"
  }


locals {
  project = "project-01"
}
  resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        name = "${local.project}-vpc"
    }

    
  }

  resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.${count.index + 10}.0/24"
  count      = 2
  tags = {
    Name = "${local.project}-subnet-${count.index}"
  }
}

# create EC2 instance
   resource "aws_instance" "main" {
   for_each = var.ec2_map 
   # we will get each.key and each.value
    ami           = each.value.ami
    instance_type = each.value.instance_type
    subnet_id = element(aws_subnet.main[*].id, index(keys(var.ec2_map),each.key) % length(aws_subnet.main))
    
    tags = {
      name = "${local.project}-instance-${each.key}"
    }
   }

  output "aws_subnet_id" {
    value = aws_subnet.main[0].id
    
    
  }