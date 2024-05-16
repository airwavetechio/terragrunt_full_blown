terraform {
  required_version = ">= 1.0.9"
}

resource "aws_s3_bucket" "bucket" {
  for_each      = var.buckets
  bucket_prefix = "${var.subdomain}-airwave-${each.key}"
  force_destroy = true
  acl           = "private"
}

### https://github.com/hashicorp/terraform-provider-aws/issues/28353

# resource "aws_s3_bucket_acl" "bucket_acl" {
#   for_each = aws_s3_bucket.bucket
#   bucket = each.value.id
#   acl    = "private"
# }
