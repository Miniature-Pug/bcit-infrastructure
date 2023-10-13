data "aws_subnet" "public-1a" {
  filter {
    name   = "tag:Name"
    values = ["bcit-public-1a"]
  }
}

data "aws_subnet" "public-1b" {
  filter {
    name   = "tag:Name"
    values = ["bcit-public-1b"]
  }
}

data "aws_s3_bucket" "logging" {
  bucket = "bcit-cloudfront-logging"
}

data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["bcit"]
  }
}

data "aws_route53_zone" "default" {
  name         = var.hosted_zone_name
  private_zone = false
}
