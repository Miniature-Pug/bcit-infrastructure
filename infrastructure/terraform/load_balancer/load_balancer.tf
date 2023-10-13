resource "aws_lb" "bcit" {
  name               = "bcit"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [data.aws_subnet.public-1a.id, data.aws_subnet.public-1b.id]

  enable_deletion_protection = false

  access_logs {
    bucket  = data.aws_s3_bucket.logging.id
    prefix  = "alb"
    enabled = true
  }

  tags = {
    Name = "bcit-alb"
  }
}