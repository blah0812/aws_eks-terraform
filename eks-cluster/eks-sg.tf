data "http" "workstation-external-ip" {
  url= "http://ipv4.icanhazip.com"
}

locals {
  workstation-external-cidr = "${chomp(data.http.workstation-external-ip.body)}/32"
}

resource "aws_security_group" "first-sg" {
  name = "terraform-eks-demo-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id =  "${aws_vpc.demo.id}"
  
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-demo"
  }
}

resource "aws_security_group_rule" "demo-ingress-workstation-https" {
  cidr_blocks = [local.workstation-external-cidr]
  from_port = 443
  protocol = "tcp"
  security_group_id = aws_security_group.first-sg.id
  to_port = 443
  type = "ingress"
}