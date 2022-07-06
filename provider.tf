provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

provider "aws" {
  region = "ap-south-1"
  profile = "sudhanshu"
}
# terraform {
#   required_version = "1.1.9"

#   backend "s3" {}

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "4.11.0"
#     }
#     kubernetes = {
#       source  = "hashicorp/kubernetes"
#       version = "2.11.0"
#     }
#     helm = {
#       source  = "hashicorp/helm"
#       version = "2.5.1"
#     }
#     time = {
#       source  = "hashicorp/time"
#       version = "0.7.2"
#     }
#   }
# }
