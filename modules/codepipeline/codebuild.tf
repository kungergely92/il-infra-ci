data "template_file" "buildspec" {
  template = "${file("../../buildspec.yml")}"
}

resource "aws_codebuild_project" "build_docker" {
  name           = "build_docker"
  service_role   = aws_iam_role.build_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
    type                        = "LINUX_CONTAINER"
  
    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = module.aws_ecr_s3_postgres_pj.ecr_repository_name
    }

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = module.aws_ecr_s3_postgres_pj.aws_account_id
    }

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = module.aws_ecr_s3_postgres_pj.default_region
    }

    environment_variable {
      name  = "IMAGE_TAG"
      value = "latest"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.codepipeline_bucket.id}/build-log"
    }
  }

  source {
    buildspec           = data.template_file.buildspec.rendered
    type                = "CODEPIPELINE"
  }
}