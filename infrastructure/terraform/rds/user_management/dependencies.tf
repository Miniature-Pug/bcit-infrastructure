data "aws_db_instance" "mysql" {
  db_instance_identifier = "bcit-rds"
}

data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["bcit"]
  }
}

data "aws_subnet" "private-1a" {
  filter {
    name   = "tag:Name"
    values = ["bcit-private-1a"]
  }
}

data "aws_security_group" "alb" {
  name = "alb"
}
