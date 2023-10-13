resource "aws_security_group" "rds" {
  name        = "bcit-rds"
  description = "Security group for our RDS"
  vpc_id      = data.aws_vpc.main.id
  ingress {
    description      = "Allow 3306"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bcit"
  }
}