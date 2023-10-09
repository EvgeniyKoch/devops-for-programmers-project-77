resource "aws_route53_zone" "my_zone" {
  name = "evgkoch.site"
}

resource "aws_acm_certificate" "cert" {
  domain_name       = "evgkoch.site"
  validation_method = "DNS"
}

resource "aws_route53_record" "cert_validation" {
  zone_id = aws_route53_zone.my_zone.zone_id
  name    = element(tolist(aws_acm_certificate.cert.domain_validation_options), 0).resource_record_name
  type    = element(tolist(aws_acm_certificate.cert.domain_validation_options), 0).resource_record_type
  records = [element(tolist(aws_acm_certificate.cert.domain_validation_options), 0).resource_record_value]
  ttl     = 60
}

resource "aws_route53_record" "my_server" {
  zone_id = aws_route53_zone.my_zone.zone_id
  name    = "evgkoch.site"
  type    = "A"

  alias {
    name                   = aws_lb.my_lb.dns_name
    zone_id                = aws_lb.my_lb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}
