
# Sourcing this so that we can output this data.  This will help downstream
# items such as the azure-workload-identity helm chart to get the tenant ID.
data "azurerm_client_config" "current" {
}

module "aks_cluster" {
  source  = "Azure/aks/azurerm"
  version = "6.5.0"

  prefix                              = var.dns_prefix
  resource_group_name                 = var.resource_group_name
  kubernetes_version                  = var.kubernetes_version
  admin_username                      = null
  local_account_disabled              = var.local_account_disabled
  azure_policy_enabled                = true
  private_cluster_public_fqdn_enabled = var.private_cluster_public_fqdn_enabled
  api_server_authorized_ip_ranges     = var.api_server_authorized_ip_ranges
  oidc_issuer_enabled                 = var.oidc_issuer_enabled
  cluster_name                        = var.cluster_name
  log_analytics_workspace_enabled     = false

  enable_auto_scaling    = var.enable_auto_scaling
  enable_host_encryption = var.enable_host_encryption
  enable_node_public_ip  = var.enable_node_public_ip

  ingress_application_gateway_enabled = var.ingress_application_gateway_enabled
  #ingress_application_gateway_id          = var.ingress_application_gateway_id
  ingress_application_gateway_name        = var.ingress_application_gateway_name            #module.azurerm_application_gateway.name  #var.ingress_application_gateway_name
  ingress_application_gateway_subnet_cidr = var.ingress_application_gateway_aks_subnet_cidr #module.azurerm_application_gateway.
  #ingress_application_gateway_subnet_id   = var.ingress_application_gateway_aks_subnet_id

  vnet_subnet_id = var.default_node_pool_vnet_subnet_id

  agents_availability_zones = var.default_node_pool_zones
  agents_count              = var.default_node_pool_node_count
  agents_max_count          = var.default_node_pool_max_count
  agents_min_count          = var.default_node_pool_min_count
  agents_pool_name          = var.default_node_pool_name
  agents_size               = var.default_node_pool_instance_size
  agents_tags               = var.agents_tags
  agents_labels             = var.default_node_pool_node_labels
  network_plugin            = var.network_profile_network_plugin


  net_profile_outbound_type = var.network_profile_outbound_type

  storage_profile_enabled             = var.storage_profile_enabled
  storage_profile_blob_driver_enabled = var.storage_profile_blob_driver_enabled


  maintenance_window = var.maintenance_window

  private_cluster_enabled           = var.private_cluster_enabled
  rbac_aad_managed                  = false
  role_based_access_control_enabled = var.role_based_access_control_enabled
  workload_identity_enabled         = var.workload_identity_enabled

  tags = var.tags

}


########################################
## If using a custom default_node_pool_vnet_subnet_id id the AKS service principal
## will need access to interact with the subnet.  This means adding permissions for
## the AKS service principal with contributor access to the subnets.
##
## When creating an internal load balancer it needs to be able to read then create the load balancer in these subnets:
##  Warning  SyncLoadBalancerFailed  3s (x6 over 2m39s)  service-controller  Error syncing load balancer: failed to ensure load balancer: Retriable: false, RetryAfter: 0s, HTTPStatusCode: 403, RawError: {"error":{"code":"AuthorizationFailed","message":"The client '33e40745-8982-4a7c-a955-13d954023ced' with object id '33e40745-8982-4a7c-a955-13d954023ced' does not have authorization to perform action 'Microsoft.Network/virtualNetworks/subnets/read' over scope '/subscriptions/7b3b906c-8d7c-4ad2-9c2f-b22c195f610e/resourceGroups/RS-DEV-EASTUS2-AKS-01/providers/Microsoft.Network/virtualNetworks/VNET-DEV-EASTUS2-AKS-01/subnets/SNET-AKS-Private-1' or the scope is invalid. If access was recently granted, please refresh your credentials."}}
##
## Scope - the resource group
## Service principal - The AKS' service principal
########################################
data "azurerm_resource_group" "grant" {
  name = var.resource_group_name
}

data "azurerm_client_config" "this" {
}

