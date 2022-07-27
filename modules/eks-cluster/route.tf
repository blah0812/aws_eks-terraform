resource "aws_route_table" "route" {
    vpc_id = "${aws_vpc.test-vpc.id}"
route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }
tags = {
        Name = "test-${var.environment}-route-1"
    }
}

resource "aws_route_table" "route-nat-1" {
    vpc_id = "${aws_vpc.test-vpc.id}"
route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.nat-1.id}"
    }
tags = {
        Name = "test-${var.environment}-route-2"
    }
}


# Associating Route Table
resource "aws_route_table_association" "rt1" {
    count = length(var.public_subnet_cidr)
    subnet_id = "${element(aws_subnet.public_subnet.*.id , count.index)}"
    route_table_id = "${aws_route_table.route.id}"
}

# Associating Route Table
resource "aws_route_table_association" "rt2" {
    count = length(var.private_subnet_cidr)
    subnet_id = "${element(aws_subnet.private_subnet.*.id , count.index)}"
    route_table_id = "${aws_route_table.route-nat-1.id}"
}

