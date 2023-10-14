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

resource "aws_lb_listener" "ec2-alb-https-listener" {
  load_balancer_arn = aws_lb.bcit.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-0-2021-06"
  certificate_arn   = aws_acm_certificate.backend.arn

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "OK"
    }
  }
}