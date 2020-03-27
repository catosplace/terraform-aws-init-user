variable "name" {
  description = "The init user name"
  type        = string
  default     = "terraform-init"
}

variable "common_tags" {
  description = "A map of tags to be added to all resources"
  type        = map(string)
  default     = {}
}

variable "user_tags" {
  description = "Additional tags for the iam user"
  type        = map(string)
  default     = {}
}

variable "default_region" {
  description = "Configure the default AWS region for the AWS provider"
  type        = string
  default     = "ap-southeast-2"
}
