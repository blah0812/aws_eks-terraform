locals {
  kubeconfig = <<KUBECONFIG

apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.first-cluster.endpoint}
    certificate-authority-data: ${aws_eks_cluster.first-cluster.certificate_authority.0.data}
  name: kubernetes
contexts: 
- context:
    cluster:kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users: 
- name: aws
  users:
  - name: aws
    user:
      exec:
        apiVersion: client.authentication.k*s.io/v1alpha1
        command: aws-iam-authenticator
        args:
          - "token"
          - "-i"
          - "${var.eks-name}"
KUBECONFIG
}

output "kubeconfig" {
    value = "${local.kubeconfig}"
}

resource "aws_eks_cluster" "first-cluster" {
  name = var.eks-name
  role_arn = aws_iam_role.first-cluster.arn
  vpc_config {
    security_group_ids =["${aws_security_group.first-sg.id}"]
    subnet_ids = [aws_subnet.private_subnet[0].id, aws_subnet.public_subnet[0].id]
  }
  depends_on = [
    aws_iam_role_policy_attachment.first-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.first-cluster-AmazonEKSServicePolicy,
  ]
}