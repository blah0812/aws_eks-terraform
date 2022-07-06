locals {
  kubeconfig = <<KUBECONFIG

apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.demo.endpoint}
    certificate-authority-data: ${aws_eks_cluster.demo.certificate_authority.0.data}
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
    security_group_ids =["${aws_security_group.demo-cluster.id}"]
    subnet-ids = aws_subnet.demo.*.id
  }
  depends_on = [
    aws_iam_role_policy_attachment.first-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.first-cluster-AmazonEKSServicePolicy,
  ]
}