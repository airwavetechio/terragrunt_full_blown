resource "aws_eip" "nat" {
  count = var.aws_eip_count

  vpc = true

  tags = var.tags
}

