terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.95.0"
    }
     random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }

}
  

provider "aws" {
  region = "ap-south-1"
  access_key = "AKIA4SYAMEUIDXWMSEWX"
  secret_key = "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"
  }
     
  
  resource "random_id" "rand_id" {
    byte_length = 10
    
  }

  resource "aws_s3_bucket" "testing-bucket" {
    bucket = "myawskucket-02"
    
  }

  resource "aws_s3_object" "bucket_data" {
    bucket = aws_s3_bucket.testing-bucket.bucket
    source = "./myfile.txt"
    key = "mydata.txt"

  }

  output "name" {
    value = random_id.rand_id.b64_url
    
  }