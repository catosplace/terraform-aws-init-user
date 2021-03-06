# ------------------------------------------------------------------------------
# TERRAFORM INIT USER
# Outputs the terraform-init user identifier.
# ------------------------------------------------------------------------------

output "user_id" {
  description = "The terraform-init user identifier"
  value       = aws_iam_user.terraform_init.id
}

# ------------------------------------------------------------------------------
# TERRAFORM INIT USER ACCESS KEYS
# Output the access and secret keys generated for the terraform-init user.
# ------------------------------------------------------------------------------

output "user_access_key" {
  description = "Generated terraform-init user AWS Access Key"
  value       = aws_iam_access_key.terraform_init_user.id
}

output "user_secret_access_key" {
  description = "Generated terraform-init user AWS Secret Access Key"
  value       = aws_iam_access_key.terraform_init_user.secret
}
