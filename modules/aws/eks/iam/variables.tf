variable "subdomain" {}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags on the resources"
}

variable "s3_bucket_arns" {
    description = "The ARNs of the s3 buckets "
    type = list(any)
}

variable "elasticsearch_arn" {
  description = "ES ARN"
  type = string
}

variable "s3_backup_arn" {
  description = "S3 Backup bucket ARN"
  type = string
}
