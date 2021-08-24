module "aws_ecr_s3_postgres_pj" {
  source         = "../../"
  ecr_name       = "my-devops-assignment-terraform"
  rds_identifier = "my-postgres-terraform"
  s3_bucket_name = "www.my-devops-assignment-terraform.com"
}
