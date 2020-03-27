# ------------------------------------------------------------------------------
# PIN TERRAFORM VERSION TO >= 0.12
# ------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.12"
}

# ------------------------------------------------------------------------------
# CREATE AN AWS IAM USER
# Create the terraform-init user. 
# This user is a temporary bootstrap IAM user.
# ------------------------------------------------------------------------------

resource "aws_iam_user" "terraform_init" {
  name = var.name

  tags = merge(
    map(
      "Name", format("%s", var.name),
      "Description", "Temporary Bootstrap IAM User"
    ),
    var.common_tags,
    var.user_tags,
  )
}

# ------------------------------------------------------------------------------
# ATTACH A USER POLICY DOCUMENT TO AN AWS IAM USER
# Attach the terraform-init user policy document to the terraform-init AWS IAM
# user.
# This is a temporary bootstrap user policy. 
# ------------------------------------------------------------------------------

resource "aws_iam_user_policy_attachment" "terraform_init" {
  #checkov:skip=CKV_AWS_40:This is a temporary user policy
  user       = aws_iam_user.terraform_init.name
  policy_arn = aws_iam_policy.terraform_init_user.arn
}

# ------------------------------------------------------------------------------
# CREATE AWS ACCESS KEYS FOR AN IAM USER
# Create the AWS Access Keys for the terraform-init user.
# These will be output from the module to enable use of the bootstrap user.
# ------------------------------------------------------------------------------

resource "aws_iam_access_key" "terraform_init_user" {
  user = aws_iam_user.terraform_init.name
}
