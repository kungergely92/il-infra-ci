variable "repository_branch" {
  default     = "refs/heads/feature/html-index-page"
  type        = string
  description = "Branch to run build stage on."
}

variable "repository_owner" {
  default     = "kungergely92"
  type        = string
  description = "Owner of the source code repo."
}

variable "repository_name" {
  default     = "il-infra-ci"
  type        = string
  description = "Name of source code repo."
}

variable "codestar_connector_credentials" {
  type        = string
  description = "Codestar connection arn"
}
