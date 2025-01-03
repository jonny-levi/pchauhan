resource "aws_ecr_repository" "demo-ecr-repository" {
  name                 = "${var.project}-ecr-repo"
  image_tag_mutability = "MUTABLE"
  force_delete = true
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name = "${var.project}-ecr-repo"
  }
}

