terraform {
  backend "s3" {
    bucket  = "bcit-local"
    key     = "s3/cloudfront-logging/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
