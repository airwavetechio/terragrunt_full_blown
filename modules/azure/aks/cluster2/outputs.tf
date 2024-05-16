output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "oidc_issuer_url" {
  value = module.aks_cluster.oidc_issuer_url
}

output "aks_cluster_all" {
  sensitive = true
  value     = module.aks_cluster
}

output "aks_cluster_cluster_fqdn" {
  sensitive   = true
  value       = module.aks_cluster.cluster_fqdn
  description = "The public/private FQDN"
}

output "aks_id" {
  value = module.aks_cluster.aks_id
}

output "aks_name" {
  value = module.aks_cluster.aks_name
}

output "location" {
  value = module.aks_cluster.location
}

output "client_certificate" {
  description = "The `client_certificate` in the `azurerm_kubernetes_cluster`'s `kube_config` block. Base64 encoded public certificate used by clients to authenticate to the Kubernetes cluster."
  sensitive   = true
  value       = module.aks_cluster.client_certificate
}

output "client_key" {
  description = "The `client_key` in the `azurerm_kubernetes_cluster`'s `kube_config` block. Base64 encoded private key used by clients to authenticate to the Kubernetes cluster."
  sensitive   = true
  value       = module.aks_cluster.client_key
}

output "cluster_ca_certificate" {
  description = "The `cluster_ca_certificate` in the `azurerm_kubernetes_cluster`'s `kube_config` block. Base64 encoded public CA certificate used as the root of trust for the Kubernetes cluster."
  sensitive   = true
  value       = module.aks_cluster.cluster_ca_certificate
}

output "host" {
  description = "The `host` in the `azurerm_kubernetes_cluster`'s `kube_config` block. The Kubernetes cluster server host."
  sensitive   = true
  value       = module.aks_cluster.host
}

output "ingress_application_gateway" {
  value = module.aks_cluster.ingress_application_gateway

}