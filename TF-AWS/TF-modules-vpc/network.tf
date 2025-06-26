provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA4SYAMEUIDXWMSEWX"
  secret_key = "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"
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "my-vpc-testing" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"
  
  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = data.aws_availability_zones.available.names
  private_subnets = ["10.0.0.0/24"]
  public_subnets  = ["10.0.1.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "test-vpc-module"
  }
}