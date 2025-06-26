terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.95.0"
    }
  }
}

provider "aws" {
  alias   = "ap_south_1"
  region  = "ap-south-1"
}

provider "aws" {
  alias   = "us_east_1"
  region  = "us-east-1"
}

provider "aws" {
  alias   = "eu_central_1"
  region  = "eu-central-1"
}

# --------------------------
# Create EC2 instances
# --------------------------

resource "aws_instance" "linux_ap" {
  provider          = aws.ap_south_1
  ami               = "ami-0e670eb768a5fc3d4" # Amazon Linux 2 in ap-south-1
  instance_type     = "t2.micro"
  count             = 10
  tags = {
    Name = "Linux-AP-${count.index}"
    Type = "Linux"
  }
}

resource "aws_instance" "unix_us" {
  provider          = aws.us_east_1
  ami               = "ami-0c2b8ca1dad447f8a" # Amazon Linux (Unix base) in us-east-1
  instance_type     = "t1.micro"
  count             = 10
  tags = {
    Name = "Unix-US-${count.index}"
    Type = "Unix"
  }
}

resource "aws_instance" "windows_eu" {
  provider          = aws.eu_central_1
  ami               = "ami-03c7d01cf4dedc891" # Windows Server 2019 Base
  instance_type     = "t3.micro"
  count             = 10
  tags = {
    Name = "Windows-EU-${count.index}"
    Type = "Windows"
  }
}

# Multiply each region 3x to get 30 in each
resource "aws_instance" "linux_ap_extra" {
  provider          = aws.ap_south_1
  ami               = "ami-0e670eb768a5fc3d4"
  instance_type     = "t3.micro"
  count             = 20
  tags = {
    Name = "Linux-AP-Extra-${count.index}"
    Type = "Linux"
  }
}

resource "aws_instance" "unix_us_extra" {
  provider          = aws.us_east_1
  ami               = "ami-0c2b8ca1dad447f8a"
  instance_type     = "t2.micro"
  count             = 20
  tags = {
    Name = "Unix-US-Extra-${count.index}"
    Type = "Unix"
  }
}

resource "aws_instance" "windows_eu_extra" {
  provider          = aws.eu_central_1
  ami               = "ami-03c7d01cf4dedc891"
  instance_type     = "t1.micro"
  count             = 20
  tags = {
    Name = "Windows-EU-Extra-${count.index}"
    Type = "Windows"
  }
}

# --------------------------
# Create S3 Buckets in 3 Regions
# --------------------------

resource "aws_s3_bucket" "bucket_ap" {
  provider = aws.ap_south_1
  bucket   = "my-app-data-ap-${random_id.suffix.hex}"
  force_destroy = true
}

resource "aws_s3_bucket" "bucket_us" {
  provider = aws.us_east_1
  bucket   = "my-app-data-us-${random_id.suffix.hex}"
  force_destroy = true
}

resource "aws_s3_bucket" "bucket_eu" {
  provider = aws.eu_central_1
  bucket   = "my-app-data-eu-${random_id.suffix.hex}"
  force_destroy = true
}

resource "random_id" "suffix" {
  byte_length = 4
}

# --------------------------
# IAM Policy for S3 Full Access
# --------------------------

resource "aws_iam_policy" "s3_full_access" {
  name        = "S3FullAccessCustom"
  description = "Read, Write, Edit Access to S3"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:ListBucket"
      ]
      Resource = [
        "${aws_s3_bucket.bucket_ap.arn}",
        "${aws_s3_bucket.bucket_ap.arn}/*",
        "${aws_s3_bucket.bucket_us.arn}",
        "${aws_s3_bucket.bucket_us.arn}/*",
        "${aws_s3_bucket.bucket_eu.arn}",
        "${aws_s3_bucket.bucket_eu.arn}/*"
      ]
    }]
  })
}
