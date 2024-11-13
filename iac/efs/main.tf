
//designed to provide scalable, elastic, concurrent with some restrictions,
// and encrypted file storage for use 
//with both AWS cloud services and on-premises resources
//- EFS (for shared resources among students)

resource "aws_efs_access_point" "test" {
  file_system_id = aws_efs_file_system.fs.id
}


resource "aws_efs_file_system" "fs" {
  creation_token = "oln-product"

  tags = {
    Name = "MyProduct"
  }
}


resource "aws_efs_backup_policy" "policy" {
  file_system_id = aws_efs_file_system.fs.id

  backup_policy {
    status = "ENABLED"
  }
}

data "aws_iam_policy_document" "policy" {
  statement {
    sid    = "ExampleStatement01"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientWrite",
    ]

    resources = [aws_efs_file_system.fs.arn]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["true"]
    }
  }
}

resource "aws_efs_file_system_policy" "policy" {
  file_system_id = aws_efs_file_system.fs.id
  policy         = data.aws_iam_policy_document.policy.json
}
