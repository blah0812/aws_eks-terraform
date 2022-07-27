resource "aws_vpc" "test-vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  
  tags = {
      Name = "test-${var.environment}-vpc"
      Terraform = "true"
  }

}
