# ------------------------------------------------------------------------------
# TERRAFORM INIT USER
# Outputs the terraform-init user identifier.
# ------------------------------------------------------------------------------

output "user_id" {
  description = "The terraform-init user identifier"
  value       = module.terraform_init.user_id
}

# ------------------------------------------------------------------------------
# TERRAFORM INIT USER ACCESS KEYS
# Output the access and secret keys generated for the terraform-init user.
# ------------------------------------------------------------------------------

output "user_access_key" {
  description = "Generated terraform-init user AWS Access Key"
  value       = module.terraform_init.user_access_key
}

output "user_secret_access_key" {
  description = "Generated terraform-init user AWS Secret Access Key"
  value       = module.terraform_init.user_secret_access_key
}
