#create policies for MFA
resource "aws_iam_user_group_membership" "Developers-Group" {
  count  = length(var.username)
  user   = element(var.username, count.index)
  groups = [aws_iam_group.Developers-Group.name, ]
}

resource "aws_iam_policy" "mfa_policy" {
  name = "mfa-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "iam:CreateVirtualMFADevice",
          "iam:EnableMFADevice",
          "iam:ListMFADevices",
          "iam:ResyncMFADevice",
        ]
        Resource = "*"
      },
    ]
  })
}

#create policy for EC2, Lambda, S3 FULLACCESS
resource "aws_iam_group_policy_attachment" "mfa_policy_attachment" {
  policy_arn = aws_iam_policy.mfa_policy.arn
  group      = aws_iam_group.Developers-Group.name
}

resource "aws_iam_policy" "full_access_policy" {
  name        = "full-access-policy"
  description = "Provides full access to EC2, Lambda, and S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:*",
          "lambda:*",
          "s3:*",
        ]
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "developers_policy_attachment" {
  name       = "developers-policy-attachment"
  policy_arn = aws_iam_policy.full_access_policy.arn
  groups     = [aws_iam_group.Developers-Group.name]
}