terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_eks_cluster" "production-core" {
  name     = "production-core"
  role_arn = "arn:aws:iam::123456789012:role/eks-cluster"
  version  = "1.28"

  vpc_config {
    subnet_ids = ["subnet-abc", "subnet-def"]
  }
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name  = aws_eks_cluster.production-core.name
  addon_name    = "vpc-cni"
  addon_version = "v1.12.6-eksbuild.2"
}

resource "aws_eks_addon" "coredns" {
  cluster_name  = aws_eks_cluster.production-core.name
  addon_name    = "coredns"
  addon_version = "v1.10.1-eksbuild.4"
}
