resource "aws_cloudfront_distribution" "static" {
  origin {
    domain_name = aws_s3_bucket.cloudfront.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.cloudfront.id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.static.cloudfront_access_identity_path
    }

  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Absolute Root"
  default_root_object = "index.html"
  price_class         = "PriceClass_100"
  aliases             = ["${var.subdomain_name}.${var.hosted_zone_name}"]

  logging_config {
    include_cookies = false
    bucket          = data.aws_s3_bucket.logging.bucket_domain_name
    prefix          = "logs"
  }
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.cloudfront.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  viewer_certificate {
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
    acm_certificate_arn      = aws_acm_certificate.cloudfront.arn
  }

  custom_error_response {
    error_code            = 404
    error_caching_min_ttl = 0
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  provisioner "local-exec" {
    command = "aws cloudfront create-invalidation --distribution-id ${self.id} --paths '/*'"
  }
}

resource "aws_cloudfront_origin_access_identity" "static" {
  comment = "Access to s3"
}
