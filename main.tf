locals {
  environment = terraform.workspace
}


module "vpc" {
  source              = "./modules/networking"
  region              = var.region
  environment         = local.environment
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnets_cidr
  private_subnet_cidr = var.private_subnets_cidr
  #   availability_zones   = "${local.production_availability_zones}"
}

module "eks" {
  source              = "./modules/eks-cluster"
  region              = var.region
  # environment         = local.environment
  # vpc            = var.vpc_cidr
  # public_subnet_cidr  = var.public_subnet_cidr
  # private_subnet_cidr = var.private_subnet_cidr
}