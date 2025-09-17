variable "eks_cluster_name" {
  type        = string
  description = "Name of EKS Cluster"
}

variable "eks_cluster_version" {
  type        = string
  description = "Version of EKS Cluster"
}

variable "subnet_ids" {
  type = list(string)
}

variable "node_group_name" {
  type        = string
  description = "Name of EKS Cluster Node group "
}

variable "worker_nodes" {
  description = "EKS worker node group config"
  type = map(object({
    instance_types = list(string)
    capacity_type  = string
    scaling_config = object({
      max_size     = number
      desired_size = number
      min_size     = number
    })
  }))
}