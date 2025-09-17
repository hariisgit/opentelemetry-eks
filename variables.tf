variable "region" {
  description = "AWS Region"
}

variable "eks_cluster_name" {
  type        = string
  description = "Name of EKS Cluster"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of AZs for EKS Cluster"
}

variable "public_subnet_cidr" {
  type        = list(string)
  description = "CIDRs of Private Subnet for EKS Cluster"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDRs of Private Subnet for EKS Cluster"
}

variable "node_group_name" {
  type        = string
  description = "Name of EKS Node group"
}

variable "worker_nodes" {
  description = "EKS Worker Nodes configuration"
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
variable "eks_cluster_version" {
  description = "EKS Cluster Kubernetes version"
  type        = string
}

variable "subnet_ids" {

}





