resource "aws_iam_user" "terraform_init" {
  name = "terraform-init"

  tags = merge(
    map(
      "Name", format("%s", var.name),
      "Description", "Temporary Bootstrap IAM User"
    ),
    var.common_tags,
    var.user_tags,
  )
}

resource "aws_iam_user_policy_attachment" "terraform_init" {
  #checkov:skip=CKV_AWS_40:This is a temporary user policy
  user       = aws_iam_user.terraform_init.name
  policy_arn = aws_iam_policy.terraform_init_user.arn
}

resource "aws_iam_access_key" "terraform_init_user" {
  user = aws_iam_user.terraform_init.name
}
