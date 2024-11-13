resource "aws_codepipeline" "codepipeline" {
  name     = "oln-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"

   
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.Online-Learning-Platform.arn
        FullRepositoryId = "GezimPoly/Online-Learning-Platform"
        BranchName       = "main"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = "Online-Learning-Platform"


        # TemplatePath   = "build_output::iac/buildspec.yml"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CloudFormation"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ActionMode     = "REPLACE_ON_FAILURE"
        Capabilities   = "CAPABILITY_AUTO_EXPAND,CAPABILITY_IAM"
        OutputFileName = "CreateStackOutput.json"
        StackName      = "MyStack"
        TemplatePath   = "build_output:: buildspec.yml"
      }
    }
  }
}

resource "aws_codestarconnections_connection" "Online-Learning-Platform" {
  name          = "Online-Learning-Platform"
  provider_type = "GitHub"
}

resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "oln-cicd-pipeline"
}


resource "aws_s3_bucket_public_access_block" "codepipeline_bucket_pab" {

  bucket = aws_s3_bucket.codepipeline_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "codepipeline_role" {
  name               = "oln-iamrole-cp"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "codepipeline_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObjectAcl",
      "s3:PutObject",
    ]

    resources = [
      aws_s3_bucket.codepipeline_bucket.arn,
      "${aws_s3_bucket.codepipeline_bucket.arn}/*"
    ]
  }

  statement {
    effect    = "Allow"
    actions   = ["codestar-connections:UseConnection"]
    resources = [aws_codestarconnections_connection.Online-Learning-Platform.arn]
  }

  statement {
    effect = "Allow"

    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
      "codecommit:GetBranch",
      "codecommit:GetCommit",
      "codecommit:UploadArchive",
      "codecommit:GetUploadArchiveStatus",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "codepipeline_policy"
  role   = aws_iam_role.codepipeline_role.id
  policy = data.aws_iam_policy_document.codepipeline_policy.json
}

# data "aws_kms_alias" "s3kmskey" {
#   name = "alias/myKmsKey"
# }







# resource "aws_codepipeline" "example" {
#   name = "terraform-pipeline"

#   role_arn = aws_iam_role.codepipeline_role.arn

#   artifact_store {
#     location = aws_s3_bucket.codepipeline_bucket.id
#     type     = "S3"
#   }

#   stage {
#     name = "Source"

#     action {
#       name     = "SourceAction"
#       category = "Source"
#       owner    = "AWS"
#       provider = "CodeCommit"
#       version  = "1"
#       configuration = {
#         RepositoryName = "oln-codebuild"
#         BranchName     = "main"
#       }

#       output_artifacts = ["source_artifact"]
#     }
#   }

#   stage {
#     name = "Build"

#     action {
#       name            = "BuildAction"
#       category        = "Build"
#       owner           = "AWS"
#       provider        = "CodeBuild"
#       version         = "1"
#       input_artifacts = ["source_artifact"]
#       configuration = {
#         ProjectName = aws_codebuild_project.example.name
#       }
#     }
#   }
# }
