terraform {
  backend "s3" {
    bucket  = "bcit-local"
    key     = "ecs/miniaturepug/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
