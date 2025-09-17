terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.13.0"
    }
  }

  backend "s3" {
    bucket         = "eks-statefile-bucket-dev"
    key            = "ekscluster.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-state-lock"
    encrypt        = true
  }
}


provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"

  eks_cluster_name     = var.eks_cluster_name
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidr   = var.public_subnet_cidr
}

module "eks" {
  source = "./modules/eks"

  eks_cluster_name    = var.eks_cluster_name
  eks_cluster_version = var.eks_cluster_version
  subnet_ids          = module.vpc.private_subnets
  node_group_name     = var.node_group_name
  worker_nodes        = var.worker_nodes
  
}