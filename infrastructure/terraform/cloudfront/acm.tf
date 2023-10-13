resource "aws_acm_certificate" "cloudfront" {
  domain_name               = "${var.subdomain_name}.${var.hosted_zone_name}"
  subject_alternative_names = ["${var.subdomain_name}.${var.hosted_zone_name}"]
  validation_method         = "DNS"
  options {
    certificate_transparency_logging_preference = "ENABLED"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cloudfront" {
  certificate_arn         = aws_acm_certificate.cloudfront.arn
  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
  timeouts {
    create = "10m"
  }
}