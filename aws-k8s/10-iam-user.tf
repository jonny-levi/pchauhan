resource "aws_iam_user" "read_only_user" {
  name = var.iam-username
  tags = {
    Name = "${var.project}-ro-iam-user"
  }
}

resource "aws_iam_user_login_profile" "read_only_user_profile" {
  user                    = aws_iam_user.read_only_user.name
  password_reset_required = false
}

# Attach ECR Read-Only Managed Policy
resource "aws_iam_user_policy_attachment" "ecr_read_only" {
  user       = aws_iam_user.read_only_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# Create a Custom Policy for EKS Read-Only Access
resource "aws_iam_policy" "eks_read_only_policy" {
  name        = "EKSReadOnlyPolicy"
  description = "Read-only access to Amazon EKS"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:Describe*",
          "eks:List*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Attach the EKS Read-Only Policy to the User
resource "aws_iam_user_policy_attachment" "eks_read_only" {
  user       = aws_iam_user.read_only_user.name
  policy_arn = aws_iam_policy.eks_read_only_policy.arn
}


# Output: Account ID
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
