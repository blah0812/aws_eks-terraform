resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.test-vpc.id
  tags = {
    Name = "test-${var.environment}-igw"
    Terraform ="true"
  }
}

resource "aws_eip" "eip-1" {
  vpc = true
  depends_on = [
    aws_internet_gateway.igw
  ]
}

resource "aws_nat_gateway" "nat-1" {
  # count = "${length(var.private_subnet_cidr)}"
  allocation_id = aws_eip.eip-1.id
  subnet_id = aws_subnet.public_subnet[0].id
  depends_on = [
    aws_internet_gateway.igw
  ]
  tags = {
    Name = "test-${var.environment}-nat"
  }
}

