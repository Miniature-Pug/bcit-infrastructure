terraform {
  backend "s3" {
    bucket  = "bcit-local"
    key     = "laod-balancer/miniaturepug/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
