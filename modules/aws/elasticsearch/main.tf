terraform {
  required_version = ">= 1.0.9"
}

data "aws_iam_policy_document" "es_vpc_access" {
  statement {
    actions = [
      "es:*",
    ]

    resources = [
      aws_elasticsearch_domain.es.arn,
      "${aws_elasticsearch_domain.es.arn}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_security_group" "elasticsearch" {
  name   = "elasticsearch-${var.subdomain}"
  description = "Allow access to elasticsearch from vpc"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.elastic_sg
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["source_port_range"]
      to_port     = ingress.value["destination_port_range"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = [ingress.value["source_address"]]
    }
  }
}

resource "aws_elasticsearch_domain" "es" {
  domain_name           = "${var.subdomain}-elasticsearch"
  elasticsearch_version = "6.3"

  cluster_config {
    instance_type            = "r4.xlarge.elasticsearch"
    instance_count           = var.instance_count
    dedicated_master_enabled = var.instance_count >= 9 ? true : false
    dedicated_master_count   = var.instance_count >= 9 ? 3 : 0
    dedicated_master_type    = var.instance_count >= 9 ? "t2.small.elasticsearch" : ""
    # zone_awareness_enabled   = true
  }

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  vpc_options {
    security_group_ids = [aws_security_group.elasticsearch.id]
    subnet_ids         = var.subnet_ids
  }

  ebs_options {
    ebs_enabled = true
    volume_size = var.storage_size_gb
    volume_type = "gp2"
  }

  snapshot_options {
    automated_snapshot_start_hour = 2
  }

  tags = var.tags
}

resource "aws_elasticsearch_domain_policy" "es_vpc_access" {
  domain_name     = aws_elasticsearch_domain.es.domain_name
  access_policies = data.aws_iam_policy_document.es_vpc_access.json
}