resource "aws_subnet" "public_1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "bcit-public-1a"
  }
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "private_1a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "bcit-private-1a"
  }
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "public_1b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "bcit-public-1b"
  }
  availability_zone = "us-east-1b"
}

resource "aws_subnet" "private_1b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  tags = {
    Name = "bcit-private-1b"
  }
  availability_zone = "us-east-1b"
}
