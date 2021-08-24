output "aws_account_id" {
  value       = data.aws_caller_identity.current.account_id
  description = "Full ARN of the repository."
}

output "ecr_repository_arn" {
  value       = aws_ecr_repository.this.arn
  description = "Full ARN of the repository."
}

output "ecr_repository_name" {
  value       = aws_ecr_repository.this.name
  description = "The name of the repository."
}

output "ecr_repository_registry_id" {
  value       = aws_ecr_repository.this.registry_id
  description = "The registry ID where the repository was created."
}

output "ecr_repository_url" {
  value       = aws_ecr_repository.this.repository_url
  description = "The URL of the repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName)"
}

output "s3_bucket_id" {
  description = "The name of the bucket."
  value       = element(concat(aws_s3_bucket_policy.this.*.id, aws_s3_bucket.this.*.id, [""]), 0)
}

output "s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = element(concat(aws_s3_bucket.this.*.arn, [""]), 0)
}

output "s3_bucket_bucket_domain_name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
  value       = element(concat(aws_s3_bucket.this.*.bucket_domain_name, [""]), 0)
}

output "default_region" {
    description = "Default AWS provider region"
    value       = data.aws_region.current.name
}