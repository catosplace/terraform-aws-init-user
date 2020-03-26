variable "name" {
  description = "The name for this module"
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
