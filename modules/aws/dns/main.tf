resource "aws_route53_zone" "domain" {
  name  = "${var.domain}."
}

resource "aws_route53_record" "subdomain" {
  zone_id = aws_route53_zone.domain.zone_id
  name    = "${var.subdomain}.${aws_route53_zone.domain.name}"
  type    = "CNAME"
  ttl     = var.ttl
  records = var.cname_records
}
