# Define AWS provider block
provider "aws" {
  region = "us-east-1"
}

# Define variables
locals {
  bucket_name = "gb-cloud-resume"
  domain_name = "grahambaggett.com"
}

# Create an S3 bucket
resource "aws_s3_bucket" "my_website_bucket" {
  bucket = local.bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  website {
    index_document = "index.html"
  }

  tags = {
    Name = "CloudResumeChallengeWebsiteBucket"
  }
}

# Define a public access block configuration
resource "aws_s3_account_public_access_block" "public_access_block_configuration" {
  bucket = local.bucket_name
  
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Create an ACM certificate
resource "aws_acm_certificate" "my_certificate" {
  domain_name       = local.domain_name
  validation_method = "DNS"

  tags = {
    Name = "CloudResumeChallengeCertificate"
  }
}
