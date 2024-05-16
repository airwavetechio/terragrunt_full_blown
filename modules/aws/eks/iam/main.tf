resource "aws_iam_user_policy" "s3_policy" {
  name = "${var.subdomain}_s3_policy"
  user = aws_iam_user.user.name
  policy = data.aws_iam_policy_document.s3_policy.json
}

# user for s3
resource "aws_iam_user" "user" {
  name = "${var.subdomain}_user"
  tags = var.tags
}

resource "aws_iam_access_key" "user" {
  user    = aws_iam_user.user.name
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions = [
      "s3:ListAllMyBuckets"
    ]
    effect   = "Allow"
    resources = [
      "*"
    ]
  }

  dynamic "statement" {
    for_each = var.s3_bucket_arns
    content {
      actions = [
        "s3:ListBucket"
      ]
      effect   = "Allow"
      resources = [
        statement.value
      ]
    }
  }

  dynamic "statement" {
    for_each = var.s3_bucket_arns
    content {
      actions = [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject",
      ]
      effect   = "Allow"
      resources = [
        "${statement.value}/*"
      ]
    }
  }
}

resource "aws_iam_role_policy" "opensearch_backup_policy" {
  name = "${var.subdomain}_opensearch_backup_policy"
  role = aws_iam_role.opensearch_backup_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListBucket",
        ]
        Effect   = "Allow"
        Resource = var.s3_backup_arn
      },{
        Action = [
         "s3:GetObject",
         "s3:PutObject",
         "s3:DeleteObject",
        ]
        Effect   = "Allow"
        Resource = "${var.s3_backup_arn}/*"
      },
    ]
  })
}

resource "aws_iam_role" "opensearch_backup_role" {
  name = "${var.subdomain}_opensearch_backup"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "opensearchservice.amazonaws.com"
        }
      },
    ]
  })
}

# Policy to be able to pass role to elastic
resource "aws_iam_policy" "backup_iam_pasrole_policy" {
  name        = "${var.subdomain}_backup_iam_pasrole_policy"
  description = "Allows to pass role to elasticsearch for user"
  policy      =  jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iam:PassRole",
        ]
        Effect   = "Allow"
        Resource = aws_iam_role.opensearch_backup_role.arn
      },{
        Action = [
         "es:ESHttpPut",
        ]
        Effect   = "Allow"
        Resource = "${var.elasticsearch_arn}/*"
      },
    ]
  })
}

# Policy to be able to backup/restore RDS
resource "aws_iam_policy" "backup_restore_rds_policy" {
  name        = "${var.subdomain}_backup_restore_rds_policy"
  description = "Allows backup/restore RDS"
  policy      =  jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "rds:CreateDBParameterGroup",
          "rds:CreateDBSnapshot",
          "rds:DeleteDBSnapshot",
          "rds:Describe*",
          "rds:DownloadDBLogFilePortion",
          "rds:List*",
          "rds:ModifyDBInstance",
          "rds:ModifyDBParameterGroup",
          "rds:ModifyOptionGroup",
          "rds:RebootDBInstance",
          "rds:RestoreDBInstanceFromDBSnapshot",
          "rds:RestoreDBInstanceToPointInTime",
          "rds:DeleteDBInstance",
          "rds:AddTagsToResource"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "opensearch_backup_policy_attachment" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.backup_iam_pasrole_policy.arn
}

resource "aws_iam_user_policy_attachment" "rds_backup_restore_policy_attachment" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.backup_restore_rds_policy.arn
}
