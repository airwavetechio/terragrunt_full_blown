output "dns_a_zone_id" {
  value       = aws_route53_zone.domain.id
  description = "zone id"
}

output "dns_a_record_id" {
  value = aws_route53_record.subdomain.id
}

output "dns_a_record_fqdn" {
  value = aws_route53_record.subdomain.fqdn
}
