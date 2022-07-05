variable "clusteName" {
  default = "eks-terraform"
}

variable "spot-instances" {
  default = ["t3.small","t2.small"]
}

variable "ondemand-instance" {
  default = "t3.medium"
}

variable "spot_max_size" {
  default = "2"
}

variable "spot_desired_size" {
  default = "2"
}

variable "ondemand_desired" {
  default = "1"
}