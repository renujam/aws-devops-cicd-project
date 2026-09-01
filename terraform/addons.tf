resource "aws_eks_addon" "pod_identity_agent" {
  cluster_name  = aws_eks_cluster.main.name
  addon_name    = "eks-pod-identity-agent"
  addon_version = "v1.4.0-eksbuild.1"

  tags = {
    Name = "renuja-devops-pod-identity-agent"
  }
}

resource "aws_eks_addon" "secrets_store_csi" {
  cluster_name  = aws_eks_cluster.main.name
  addon_name    = "aws-secrets-store-csi-driver-provider"
  addon_version = "v3.1.3-eksbuild.1"

  depends_on = [
    aws_eks_addon.pod_identity_agent
  ]

  tags = {
    Name = "renuja-devops-secrets-store-csi"
  }
}
