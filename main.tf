resource "aws_iam_user" "terraform_init" {
  name = "terraform-init"
  tags = {
    desc = "used to bootstrap terraform managed accounts"
    // TODO Tagging Mechanism to enable own tags
  }
}

resource "aws_iam_user_policy_attachment" "terraform_init" {
  #checkov:skip=CKV_AWS_40:This is a temporary user policy
  user       = aws_iam_user.terraform_init.name
  policy_arn = aws_iam_policy.terraform_init_user.arn
}

resource "aws_iam_access_key" "terraform_init_user" {
  user = aws_iam_user.terraform_init.name
}
