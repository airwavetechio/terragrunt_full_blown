output "access_key" {
    description = "Access key ID"
    value       = aws_iam_access_key.user.id
}


output "secret_key" {
    description = "Access Key Secret"
    value       = aws_iam_access_key.user.secret
    sensitive =  true
}

output "elastic_role_arn" {
    description = "The ARN of the elastic role"
    value = aws_iam_role.opensearch_backup_role.arn
}
