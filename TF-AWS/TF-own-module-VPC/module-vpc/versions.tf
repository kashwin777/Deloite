terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=5.95.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
  access_key = "AKIA4SYAMEUIDXWMSEWX"
  secret_key = "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"
  }