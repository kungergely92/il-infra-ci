resource "aws_codepipeline" "my-provisioned-deployment-pipeline" {
  name     = "my-provisioned-deployment-pipeline"
  role_arn = aws_iam_role.pipeline_role.arn
  tags     = {}

  artifact_store {
    location = module.aws_ecr_s3_postgres_pj.s3_bucket_id
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      output_artifacts = ["SourceArtifact"]
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      configuration = {
        BranchName       = var.repository_branch
        FullRepositoryId = "${var.repository_owner}/${var.repository_name}"
        ConnectionArn    = var.codestar_connector_credentials
      }
    }
  }
  stage {
    name = "Build"

    action {
      category = "Build"
      configuration = {
        "ProjectName" = "build_docker"
      }
      input_artifacts = [
        "SourceArtifact",
      ]
      name = "Build"
      output_artifacts = [
        "BuildArtifact",
      ]
      owner     = "AWS"
      provider  = "CodeBuild"
      run_order = 1
      version   = "1"
    }
  }
  stage {
    name = "Deploy"

    action {
      category = "Deploy"
      configuration = {
        "BucketName" = module.aws_ecr_s3_postgres_pj.s3_bucket_id
        "Extract"    = "true"
      }
      input_artifacts = [
        "BuildArtifact",
      ]
      name             = "Deploy"
      output_artifacts = []
      owner            = "AWS"
      provider         = "S3"
      version          = "1"
    }
  }
}
