data "http" "workstation-external-ip" {
  url= "http://ipv4.icanhazip.com"
}

locals {
  workstation-external-cidr = "${chomp(data.http.workstation-external-ip.body)}/32"
}

resource "aws_security_group" "first-sg" {
  name = "terraform-eks-demo-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id =  aws_vpc.test-vpc.id
  
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

resource "aws_security_group" "node-sg" {
  name = "terraform-eks-node-sg"
  description = "Security group for all node in cluster"
  vpc_id =  aws_vpc.test-vpc.id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${
    tomap({
      "Name" = "Terraform-node",
      "kubernetes.io/clusted/${var.eks-name}" = "owned",
    })
  }"
}

resource "aws_security_group_rule" "node-sg-ingress" {
  description = "Allow node to communicate with each other"
  from_port = 0
  protocol = "-1"
  security_group_id = "${aws_security_group.node-sg.id}"
  source_security_group_id = "${aws_security_group.node-sg.id}"
  to_port = 65535
  type = "ingress"
}

resource "aws_security_group_rule" "node-sg-ingress-https" {
  description = "Allow worker kubelets & Pods to receive communication"
  from_port = 443
  protocol = "tcp"
  security_group_id = "${aws_security_group.node-sg.id}"
  source_security_group_id = "${aws_security_group.first-sg.id}"
  to_port = 433
  type = "ingress"
}

resource "aws_security_group_rule" "node-sg-ingress-others" {
  description = "Allow Worker Kubeletes & Pods to receive communication"
  from_port = 1025
  protocol = "tcp"
  security_group_id = "${aws_security_group.node-sg.id}"
  source_security_group_id = "${aws_security_group.first-sg.id}"
  to_port = 65535
  type = "ingress"
}

resource "aws_security_group_rule" "node-sg-ingress-clu" {
  description = "Allow node to communicate with each other"
  from_port = 0
  protocol = "-1"
  security_group_id = "${aws_security_group.first-sg.id}"
  source_security_group_id = "${aws_security_group.node-sg.id}"
  to_port = 65535
  type = "ingress"
}
