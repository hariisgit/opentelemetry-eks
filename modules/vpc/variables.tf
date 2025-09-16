variable "eks_cluster_name" {
  description = "EKS Cluster Name"
  type = string
}

variable "vpc_cidr" {
  description = "CIDR Range for EKS VPC"
  type = string
}

variable "private_subnet_cidrs" {
  description = "CIDR Range for private subnet for EKS VPC"
  type = list(string)
}

variable "availability_zones" {
  description = "AZs "
  type = list(string)
}

variable "public_subnet_cidr" {
  description = "CIDR Range for private subnet for EKS VPC"
  type = list(string)
}