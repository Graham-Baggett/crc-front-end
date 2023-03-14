# Define AWS provider block
provider "aws" {
  region = "us-east-1"
}

# Define bucket name
locals {
  bucket_name = "gb-cloud-resume"
}

# Create an S3 bucket with public access block configuration
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

  public_access_block_configuration {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
}

# Create an ACM certificate
resource "aws_acm_certificate" "my_certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Name = "CloudResumeChallengeCertificate"
  }
}
