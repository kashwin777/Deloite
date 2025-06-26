terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.95.0"
    }
  }
}

provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA4SYAMEUIDXWMSEWX"
  secret_key = "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"
}

# Fetch the latest Amazon Linux AMI
data "aws_ami" "latest" {
  most_recent = true
  owners      = ["amazon"]
}

output "aws_ami" {
  value = data.aws_ami.latest.id
}

# Get Security Group by tags
data "aws_security_group" "name" {
  tags = {
    env  = "prod"
    Name = "MySG"
  }
}

output "security_group" {
  value = data.aws_security_group.name.id
}

# Get VPC by tags
data "aws_vpc" "name" {
  filter {
    name   = "tag:env"
    values = ["prod"]
  }

  filter {
    name   = "tag:Name"
    values = ["my-vpc-testing"]
  }
}
output "vpc_id" {
  value = data.aws_vpc.name.id
}

# Get Subnet by VPC ID and tags
data "aws_subnet" "name" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.name.id]
  }

  tags = {
    name = "private subnet"
    env  = "prod"
  }
}

# AZ
data "aws_availability_zones" "available" {
  state = "available"
}

output "az_names" {
  value = data.aws_availability_zones.available.names
}

# Create EC2 instance
resource "aws_instance" "myserver" {
  ami             = "ami-0f1dcc636b69a6438"
  subnet_id       = data.aws_subnet.name.id
  security_groups = [data.aws_security_group.name.id]
  instance_type   = "t2.micro"

  tags = {
    Name = "testing server"
  }
}

