# output "aws_subnets_public" {
#   value = tolist(data.aws_subnet.public.ids)[*]
# }

# output "aws_subnets_private" {
#   value = tolist(data.aws_subnet.private.ids)[*]
# }

output "endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.this.certificate_authority[0].data

}


output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "ecr_repository_url" {
  value = aws_ecr_repository.demo-ecr-repository.repository_url
}

output "iam_username" {
  value = aws_iam_user.read_only_user.name
}

# Output: Login URL
output "console_login_url" {
  value = "https://console.aws.amazon.com/"
}

output "iam_user_password" {
  value     = aws_iam_user_login_profile.read_only_user_profile.password
  sensitive = false
}

