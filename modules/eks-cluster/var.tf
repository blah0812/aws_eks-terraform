variable "eks-name" {
  default = "eks-first-cluster"
}
variable "vpc_cidr" {
  type = string
  default = "10.20.0.0/16"
}

variable "public_subnet_cidr" {
  default = [
    "10.20.0.0/19",
    "10.20.32.0/19"
  ]
  type = list
}

variable "private_subnet_cidr" {
  default = [
    "10.20.64.0/19",
    "10.20.96.0/19"
  ]
  type = list
}

variable "zones" {
  default = [
    "ap-south-1a",
    # "ap-south-1b",
    "ap-south-1c"
    # "ap-south-1d",
    # "ap-south-1e",
    # "ap-south-1f"
  ]
  type = list
}

variable "vpc_name" {
  default = "Terrafrom-VPC"
}

variable "region" {
  default = "ap-south-1"
}

variable "environment" {
description = "The environment which to fetch the configuration for."
type = string
}
