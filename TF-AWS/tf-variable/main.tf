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
    owner = "devops"
    name = "Myserver"
  }
    
    resource "aws_instance" "myserver" {
   ami = "ami-0f1dcc636b69a6438"
   instance_type = var.aws_instance_type

   root_block_device {
     delete_on_termination = true
     volume_size           = var.ec2_config.v_size
     volume_type           = var.ec2_config.v_type
   }
   tags = merge(var.additional_tag, {
    name = local.name
   })
     
   }