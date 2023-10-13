data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["bcit"]
  }
}

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

data "aws_subnet" "private-1a" {
  filter {
    name   = "tag:Name"
    values = ["bcit-private-1a"]
  }
}

data "aws_subnet" "private-1b" {
  filter {
    name   = "tag:Name"
    values = ["bcit-private-1b"]
  }
}
