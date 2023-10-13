terraform {
  backend "s3" {
    bucket  = "bcit-local"
    key     = "hosted-zones/miniaturepug/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
