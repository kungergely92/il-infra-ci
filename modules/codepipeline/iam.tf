resource "aws_iam_role" "pipeline_role" {
  name = "provisioned_pipeline_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "pipeline-policies" {
    statement{
        sid = ""
        actions = ["codestar-connections:UseConnection"]
        resources = ["*"]
        effect = "Allow"
    }
    statement{
        sid = ""
        actions = ["cloudwatch:*", "s3:*", "codebuild:*"]
        resources = ["*"]
        effect = "Allow"
    }
}

resource "aws_iam_policy" "pipeline-policy" {
    name = "pipeline-policy"
    path = "/"
    description = "Pipeline policy"
    policy = data.aws_iam_policy_document.pipeline-policies.json
}

resource "aws_iam_role_policy_attachment" "pipeline-attachment" {
    policy_arn = aws_iam_policy.pipeline-policy.arn
    role = aws_iam_role.pipeline_role.id
}

resource "aws_iam_role" "build_role" {
  name = "build_role_terraform"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "build-policies" {
    statement{
        sid = ""
        actions = ["logs:*", "s3:*", "codebuild:*", "secretsmanager:*","iam:*"]
        resources = ["*"]
        effect = "Allow"
    }
}

resource "aws_iam_policy" "build-policy" {
    name = "build-policy"
    path = "/"
    description = "Codebuild policy"
    policy = data.aws_iam_policy_document.build-policies.json
}

resource "aws_iam_role_policy_attachment" "codebuild-attachment1" {
    policy_arn  = aws_iam_policy.build-policy.arn
    role        = aws_iam_role.build_role.id
}

resource "aws_iam_role_policy_attachment" "codebuild-attachment2" {
    policy_arn  = "arn:aws:iam::aws:policy/PowerUserAccess"
    role        = aws_iam_role.build_role.id
}