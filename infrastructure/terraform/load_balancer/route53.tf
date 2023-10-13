resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.backend.domain_validation_options : dvo.domain_name => {
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
  depends_on      = [aws_acm_certificate.backend]
}

resource "aws_route53_record" "backend" {
  zone_id = data.aws_route53_zone.default.zone_id
  name    = "${var.subdomain_name}.${var.hosted_zone_name}"
  type    = "A"
  alias {
    evaluate_target_health = true
    name                   = aws_lb.bcit.dns_name
    zone_id                = aws_lb.bcit.zone_id
  }
}