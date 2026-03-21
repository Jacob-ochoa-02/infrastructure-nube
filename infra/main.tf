provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "site_bucket" {
    bucket      = var.bucket_name

    tags        = {
        Name    = var.bucket_name
        Environment = var.environment
        ManagedBy   = "Terraform"
    }
}