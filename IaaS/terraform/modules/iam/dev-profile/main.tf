# https://github.com/clouddrove/terraform-aws-iam-user/blob/master/main.tf
provider "aws" {
  region = var.region
}

resource "aws_iam_user" "dev_profile" {
  name = var.dev_name
}

# aws_iam_account_password_policy
# aws_iam_user_login_profile (To Mange PWD)
resource "aws_iam_access_key" "dev_profile_access_key" {
  user = aws_iam_user.dev_profile.name
  #pgp_key = var.pgp_key
}

resource "aws_iam_group" "dev_profile_group" {
  name = "Developers"
}

resource "aws_iam_user_group_membership" "dev_profile_group_membership" {
  user   = aws_iam_user.dev_profile.name
  groups = [aws_iam_group.dev_profile_group.name]
}

resource "aws_iam_policy_attachment" "dev_profile_policy_attach" {
  name       = "dev_profile_policy_attach"
  users      = [aws_iam_user.dev_profile.name]
  groups     = [aws_iam_group.dev_profile_group.name]
  policy_arn = aws_iam_policy.dev_profile_policies.arn
}

resource "aws_iam_policy" "dev_profile_policies" {
  name        = "dev_profile_policies"
  description = "Dev Policies"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "ec2:Get*"
        ]
        Effect   = "Allow",
        Resource = "arn:aws:ec2:::id"
      },
      /*
      {
        "Action" : [
          "iam:GenerateCredentialReport",
          "iam:GenerateServiceLastAccessedDetails",
          "iam:Get*",
          "iam:List*",
          "iam:SimulateCustomPolicy",
          "iam:SimulatePrincipalPolicy"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      # Admin Profile Policy
      Action = [
        Effect = "Allow"
        Action = "*"
        Resource = "*"
      ]
      */
    ]
  })
}
