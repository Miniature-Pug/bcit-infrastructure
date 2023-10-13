terraform {
  backend "s3" {
    bucket  = "bcit-root"
    key     = "s3/bcit-local/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
