output "eks_cluster_name" {
  value = aws_eks_cluster.eks_ckuster.name
}

output "eks_ckuster_endpoint" {
  value = aws_eks_cluster.eks_ckuster.endpoint
}