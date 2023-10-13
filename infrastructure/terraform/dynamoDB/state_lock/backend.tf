terraform {
  backend "s3" {
    bucket  = "bcit-local"
    key     = "dynamoDB/state-lock/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}