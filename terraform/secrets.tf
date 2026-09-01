resource "aws_secretsmanager_secret" "app_secret" {
  name                    = "renuja-devops/app-secret"
  description             = "Application secret for RENUJA DevOps EKS workload"
  recovery_window_in_days = 0

  tags = {
    Name = "renuja-devops-app-secret"
  }
}

resource "aws_iam_role" "app_pod" {
  name = "renuja-devops-app-pod-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "pods.eks.amazonaws.com"
        }

        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })

  tags = {
    Name = "renuja-devops-app-pod-role"
  }
}

resource "aws_iam_role_policy" "app_secret_access" {
  name = "renuja-devops-secret-access"
  role = aws_iam_role.app_pod.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]

        Resource = aws_secretsmanager_secret.app_secret.arn
      }
    ]
  })
}

resource "aws_eks_pod_identity_association" "app" {
  cluster_name    = aws_eks_cluster.main.name
  namespace       = "renuja-devops"
  service_account = "renuja-devops-app-sa"
  role_arn        = aws_iam_role.app_pod.arn
}
