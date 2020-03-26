output "terraform_init_user_access_key" {
  description = "Generated terraform-init user AWS Access Key"
  value       = aws_iam_access_key.terraform_init_user.id
}

output "terraform_init_user_secret_access_key" {
  description = "Generated terraform-init user AWS Secret Access Key"
  value       = aws_iam_access_key.terraform_init_user.secret
}
