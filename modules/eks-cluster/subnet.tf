resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet_cidr)
  vpc_id = aws_vpc.test-vpc.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = var.zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "test-${var.environment}-public-subnet-${var.zones[count.index]}"
  }
}

resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnet_cidr)
  vpc_id = aws_vpc.test-vpc.id
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone = var.zones[count.index]
  # map_public_ip_on_launch = true
  tags = {
    Name = "test-${var.environment}-private-subnet-${var.zones[count.index]}"
  }  
}
