output "eip_ids" {
  value       = aws_eip.nat.*.id
  description = "EIP IDs"
}
