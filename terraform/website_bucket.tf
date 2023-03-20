# Create an S3 bucket
resource "aws_s3_bucket" "my_website_bucket" {
  bucket = var.bucket_name

  tags = {
    Name = "CloudResumeChallengeWebsiteBucket"
  }
}

#Define the S3 Access Control List setting
resource "aws_s3_bucket_acl" "website_bucket_acl" {
  bucket = var.bucket_name
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

  index_document {
    suffix = "index.html"
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

data "aws_iam_policy_document" "allow_access_from_cloud_front" {
  version = "2012-10-17"

  statement {
    sid = "PolicyForCloudFrontPrivateContent"
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "${aws_s3_bucket.web_bucket.arn}/*",
    ]
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.web_distribution.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_cloud_front" {
  bucket = aws_s3_bucket.web_bucket.bucket
  policy = data.aws_iam_policy_document.allow_access_from_cloud_front.json
}
