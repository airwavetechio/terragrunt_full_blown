output "id" {
  value       = aws_elb.loadbalancer.id
  description = "The Load Balancer ID."
}

output "dns_name" {
  value = aws_elb.loadbalancer.dns_name
}
