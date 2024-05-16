# Used for provisioning EKS
###########################################################

data "aws_eks_cluster" "eks_cluster" {
  name = module.aws_eks.cluster_id
}

data "aws_eks_cluster_auth" "this" {
  name = module.aws_eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.this.token
}
