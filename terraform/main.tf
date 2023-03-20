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
  
  tags = {
    Name = "CloudResumeChallengeWebsiteBucket"
  }
}

#Define the S3 Access Control List setting
resource "aws_s3_bucket_acl" "example" {
  bucket = local.bucket_name
  acl    = "private"
}

#Define an S3 Versioning setting
resource "aws_s3_bucket_versioning" "my_website_versioning_setting" {
  bucket = local.bucket_name
  
  versioning_configuration {
    status = "Enabled"
  }
}

#Define an S3 Website configuration
resource "aws_s3_bucket_website_configuration" "my_website_configuration" {
  bucket = local.bucket_name
  
  website {
    index_document = "index.html"
  }
}

# Define a public access block configuration
resource "aws_s3_bucket_public_access_block" "public_access_block_configuration" {
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
