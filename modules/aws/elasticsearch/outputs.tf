output "elasticsearch_instance" {
  value = aws_elasticsearch_domain.es
}

output "elasticsearch_public_ip_address" {
  value = aws_elasticsearch_domain.es.endpoint
}

output "es_arn" {
  value = aws_elasticsearch_domain.es.arn
}