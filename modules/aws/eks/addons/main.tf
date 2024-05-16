module "kubernetes_addons" {

  source = "github.com/RobertFischer/terraform-aws-eks-blueprints//modules/kubernetes-addons/?ref=airwave"
  # EKS Data
  eks_cluster_id       = var.eks_cluster_id
  eks_oidc_provider    = var.eks_oidc_provider
  eks_cluster_endpoint = var.eks_cluster_endpoint
  eks_cluster_version  = var.eks_cluster_version

  # EKS Managed Add-ons
  enable_amazon_eks_vpc_cni            = var.enable_amazon_eks_vpc_cni
  enable_amazon_eks_coredns            = var.enable_amazon_eks_coredns
  enable_amazon_eks_kube_proxy         = var.enable_amazon_eks_kube_proxy
  enable_amazon_eks_aws_ebs_csi_driver = var.enable_amazon_eks_aws_ebs_csi_driver

  #K8s Add-ons
  enable_argocd                                = var.enable_argocd
  argocd_manage_add_ons                        = var.argocd_manage_add_ons
  argocd_helm_config                           = var.argocd_helm_config
  enable_argo_rollouts                         = var.enable_argo_rollouts
  enable_aws_load_balancer_controller          = var.enable_aws_load_balancer_controller
  enable_aws_node_termination_handler          = var.enable_aws_node_termination_handler
  enable_external_dns                          = var.enable_external_dns
  enable_ingress_nginx                         = var.enable_ingress_nginx
  enable_secrets_store_csi_driver              = var.enable_secrets_store_csi_driver
  enable_secrets_store_csi_driver_provider_aws = var.enable_secrets_store_csi_driver_provider_aws
  enable_cluster_autoscaler                    = var.enable_cluster_autoscaler
  enable_metrics_server                        = var.enable_metrics_server
  enable_kubecost                              = var.enable_kubecost
  enable_nvidia_device_plugin                  = var.enable_nvidia_device_plugin
  enable_kube_state_metrics                    = var.enable_kube_state_metrics
  tags                                         = var.tags
}
