region               = "us-east-1"
eks_cluster_name     = "dev-eks"
vpc_cidr             = "10.14.0.0/16"
availability_zones   = ["us-east-1a", "us-east-1b"]
public_subnet_cidr   = ["10.14.1.0/24", "10.14.2.0/24"]
private_subnet_cidrs = ["10.14.51.0/24", "10.14.52.0/24"]
node_group_name      = "eks-dev-node-group"
eks_cluster_version  = "1.33"
worker_nodes = {
  instance_types = ["t2.micro"]
  capacity_type  = {
    type = "ON_DEMAND"
  }
  scaling_config = {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
}