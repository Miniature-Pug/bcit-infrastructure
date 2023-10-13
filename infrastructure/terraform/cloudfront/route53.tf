data "aws_route53_zone" "default" {
  name         = var.hosted_zone_name
  private_zone = false
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.cloudfront.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id         = data.aws_route53_zone.default.zone_id
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  depends_on      = [aws_acm_certificate.cloudfront]
}

resource "aws_route53_record" "cloudfront" {
  zone_id = data.aws_route53_zone.default.zone_id
  name    = "${var.subdomain_name}.${var.hosted_zone_name}"
  type    = "A"
  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.static.domain_name
    zone_id                = aws_cloudfront_distribution.static.hosted_zone_id
  }
}
