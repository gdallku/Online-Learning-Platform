resource "aws_s3_bucket" "example" {
  bucket = "oln-cicd-build"
}



data "aws_iam_policy_document" "assume_role_oln" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }



    actions = ["sts:AssumeRole"]
  }

}

resource "aws_iam_role" "example" {
  name               = "GezimPoly"
  assume_role_policy = data.aws_iam_policy_document.assume_role_oln.json
}

data "aws_iam_policy_document" "example" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs",
    ]

    resources = ["*"]
  }


  statement {
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.example.arn,
      "${aws_s3_bucket.example.arn}/*",
      "arn:aws:s3:::oln-cicd-build",
      "arn:aws:s3:::codepipeline-bucket/*",
      "arn:aws:s3:::oln-cicd-pipeline/oln-pipeline/*",
    ]
  }
}

resource "aws_iam_role_policy" "example" {
  role   = aws_iam_role.example.name
  policy = data.aws_iam_policy_document.example.json
}

resource "aws_codebuild_project" "example" {

  name          = "Online-Learning-Platform"
  description   = "test_codebuild_project"
  build_timeout = 5
  service_role  = aws_iam_role.example.arn



  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type     = "S3"
    location = aws_s3_bucket.example.bucket
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"


  }
 
  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.example.id}/build-log"
    }
  }

  source {
    type = "GITHUB"
    # location = "https://github.com/GezimPoly/Online-Learning-Platform/"
    location = "https://github.com/GezimPoly/Online-Learning-Platform/"

    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }
  }

  source_version = "main"


}

# resource "aws_codebuild_project" "project-with-cache" {
#   name           = "test-project-cache"
#   description    = "test_codebuild_project_cache"
#   build_timeout  = 5
#   queued_timeout = 5

#   service_role = aws_iam_role.example.arn

#   artifacts {
#     type = "NO_ARTIFACTS"
#   }

#   cache {
#     type  = "LOCAL"
#     modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
#   }

#   environment {
#     compute_type                = "BUILD_GENERAL1_SMALL"
#     image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
#     type                        = "LINUX_CONTAINER"
#     image_pull_credentials_type = "CODEBUILD"

#     environment_variable {
#       name  = "SOME_KEY1"
#       value = "SOME_VALUE1"
#     }
#   }

#   source {
#     type = "GITHUB"
#     # location = "https://github.com/GezimPoly/Online-Learning-Platform/"

#     location = "https://github.com/GezimPoly/Online-Learning-Platform/tree/main/iac"
#     git_clone_depth = 1
#   }

#   tags = {
#     Environment = "Test"
#   }
# }


# resource "aws_codebuild_project" "example" {
#   name         = "oln-codebuild"
#   service_role = aws_iam_role.example.arn
#   environment {
#     compute_type = "BUILD_GENERAL1_SMALL"
#     image        = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
#     type         = "LINUX_CONTAINER"
#   }
#   source {
#     type            = "CODECOMMIT"
#     location        = "https://github.com/GezimPoly/Online-Learning-Platform"
#     git_clone_depth = 1

#   }
#   artifacts {
#     type = "NO_ARTIFACTS"
#   }
#   source_version = "main"
# }
