variable "ecr_name" {
  type        = string
  description = "Name of the ECR repository."
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket."
}

variable "push_and_pull_accounts" {
  default     = []
  type        = list(string)
  description = "AWS accounts which push and pull."
}

variable "max_untagged_image_count" {
  default     = 1
  type        = number
  description = "The maximum number of untagged images that you want to retain in repository."
}

variable "max_tagged_image_count" {
  default     = 30
  type        = number
  description = "The maximum number of tagged images that you want to retain in repository."
}

variable "scan_on_push" {
  default     = false
  type        = bool
  description = "Whether images should automatically be scanned on push or not."
}

variable "image_tag_mutability" {
  default     = "MUTABLE"
  type        = string
  description = "Whether images are allowed to overwrite existing tags."
}

variable "initial_db" {
  type        = string
  default     = "postgres"
  description = "Initial database."
}

variable "rds_identifier" {
  type        = string
  description = "RDS identifier."
}

variable "username" {
  type        = string
  default     = "kungergely"
  description = "RDS master username."
}

variable "engine_version" {
  type        = string
  default     = "12.6"
  description = "RDS engine version."
}

variable "instance_class" {
  type        = string
  default     = "db.t2.micro"
  description = "RDS instance class."
}

variable "allocated_storage" {
  type        = number
  default     = 20
  description = "RDS storage."
}

variable "storage_type" {
  type        = string
  default     = "gp2"
  description = "RDS storage type."
}

variable "availability_zone" {
  type        = string
  default     = "us-west-1b"
  description = "RDS az."
}

variable "skip_final_snapshot" {
  type        = bool
  default     = false
  description = "RDS skip final snapshot."
}

variable "apply_immediately" {
  type        = bool
  default     = false
  description = "Apply changes immediately."
}

variable "publicly_accessible" {
  type        = bool
  default     = false
  description = "RDS publicly accessible."
}

variable "enabled_ssm_parameter_store" {
  type        = bool
  default     = true
  description = "Save RDS credentials to SSM Parameter Store."
}

variable "max_allocated_storage" {
  type        = number
  default     = 100
  description = "RDS max allocated storage autoscailing."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Resource tags."
}