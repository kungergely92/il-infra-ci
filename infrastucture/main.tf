module "ecr" {
  source          = "../"
  name            = "my-devops-assignment-private"
  scan_on_push    = true
  image_tag_mutability = "IMMUTABLE"
  tag_prefix_list = ["latest"]

  only_pull_accounts       = [data.aws_cloudtrail_service_account.main.id]
  push_and_pull_accounts   = [data.aws_cloudtrail_service_account.main.id]
  max_untagged_image_count = 5
  max_tagged_image_count   = 50
}