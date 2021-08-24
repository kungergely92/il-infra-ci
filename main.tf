resource "aws_ecr_repository" "this" {
  name = var.ecr_name

  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}

resource "aws_ecr_repository_policy" "this" {
  repository = aws_ecr_repository.this.name
  policy     = data.aws_iam_policy_document.push_and_pull.json
}

data "aws_iam_policy_document" "push_and_pull" {

  statement {
    sid    = "ElasticContainerRegistryPushAndPull"
    effect = "Allow"

    principals {
      identifiers = concat([local.current_account], local.push_and_pull_accounts)
      type        = "AWS"
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
    ]
  }
}

locals {
  push_and_pull_accounts = formatlist("arn:aws:iam::%s:root", var.push_and_pull_accounts)
  current_account        = format("arn:aws:iam::%s:root", data.aws_caller_identity.current.account_id)
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
