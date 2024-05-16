output "storage_container_info" {
  value = tomap({
    for k, v in aws_s3_bucket.bucket : k => {
      id = v.id
      name = v.bucket
      arn = v.arn
    }
  })
  description = "The ID of the Storage bucket"
}

