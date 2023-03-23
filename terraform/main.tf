terraform {
  backend "s3" {
    bucket         = "gb-crc-terraform-state"
    key            = "front-end/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}
