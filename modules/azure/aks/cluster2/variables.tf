# variable "location" {
#   default = "eastus2"
# }

variable "resource_group_name" {
  default = "kubernetes-ops-aks"
}

variable "location" {
  default = ""
}

variable "tags" {
  type = map(string)

  default = {
    Name        = "dev"
    Environment = "env"
    Account     = "dev"
    Group       = "devops"
    Location    = "East US 2"
    managed_by  = "Terraform"
  }
}

variable "cluster_name" {
  default = "dev"
}

variable "dns_prefix" {
  default = "dev"
}
variable "private_cluster_enabled" {
  description = "Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created"
  default     = true
}

variable "private_cluster_public_fqdn_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to false."
}

variable "kubernetes_version" {
  default = "1.24.3"
}

variable "api_server_authorized_ip_ranges" {
  type    = list(string)
  default = ["1.1.1.1/32"]
}

variable "enable_pod_security_policy" {
  default = false
}

variable "role_based_access_control_enabled" {
  default = false
}

variable "default_node_pool_name" {
  default = "default"
}

variable "default_node_pool_node_count" {
  default = 1
}

variable "default_node_pool_instance_size" {
  default = "Standard_B2s"
}

variable "default_node_pool_enable_auto_scaling" {
  default = true
}

variable "default_node_pool_max_count" {
  default = 1
}

variable "default_node_pool_min_count" {
  default = 1
}

variable "default_node_pool_os_disk_size_gb" {
  default = "30"
}

variable "default_node_pool_node_labels" {
  type    = map(string)
  default = {}
}

variable "default_node_pool_node_taints" {
  type    = list(string)
  default = []
}


variable "network_profile_network_plugin" {
  default = "kubenet"
}

variable "network_profile_network_policy" {
  default = "calico"
}

variable "network_profile_pod_cidr" {
  default = "10.244.0.0/16"
}

variable "kube_dashboard_enabled" {
  default = false
}

variable "default_node_pool_enable_host_encryption" {
  default = true
}

variable "auto_scaler_balance_similar_node_groups" {
  default = false
}

variable "auto_scaler_expander" {
  default = "least-waste"
}

variable "local_account_disabled" {
  type        = bool
  default     = true
  description = "(Optional) - If true local accounts will be disabled. Defaults to true.  This forces the usage of Azure AD auth (which shold be what you want)."
}

variable "azure_active_directory_role_based_access_control_managed" {
  type        = bool
  default     = true
  description = "Optional) Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration."
}

variable "azure_active_directory_role_based_access_control_tenant_id" {
  type        = string
  default     = null
  description = "(Optional) The Tenant ID used for Azure Active Directory Application. If this isn't specified the Tenant ID of the current Subscription is used."
}

variable "azure_active_directory_role_based_access_control_admin_group_object_ids" {
  type        = list(any)
  default     = []
  description = "When managed is set to true the following properties can be specified.  (Optional) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster."
}

variable "azure_active_directory_role_based_access_control_azure_rbac_enabled" {
  type        = bool
  default     = true
  description = "When managed is set to true the following properties can be specified.  (Optional) Is Role Based Access Control based on Azure AD enabled?"
}

variable "oidc_issuer_enabled" {
  type        = bool
  default     = true
  description = "(Required) Enable or Disable"
}

variable "default_node_pool_vnet_subnet_id" {
  type        = string
  default     = null
  description = "The vnet subnet ID to put the default node pool into"
}

variable "agents_count" {
  type        = number
  default     = null
  description = "The number of Agents that should exist in the Agent Pool. Please set agents_count null while enable_auto_scaling is true to avoid possible agents_count changes."
}

variable "enable_auto_scaling" {
  type        = bool
  default     = true
  description = "Enable node pool autoscaling	"
}

variable "enable_host_encryption" {
  type        = bool
  default     = false
  description = "Enable Host Encryption for default node pool. Encryption at host feature must be enabled on the subscription: https://docs.microsoft.com/azure/virtual-machines/linux/disks-enable-host-based-encryption-cli		"
}

variable "agents_tags" {
  type        = any
  default     = {}
  description = "Additional tags on the default node pool"
}

variable "maintenance_window" {
  type = any
  default = {
    allowed = [
      {
        day   = "Sunday",
        hours = [22, 23]
      },
    ]
    not_allowed = []
  }
  description = "(Optional) A maintenance_window block as defined below."
}


variable "default_node_pool_zones" {
  type        = list(string)
  description = "(Optional) A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created."
  default     = null
}

variable "enable_node_public_ip" {
  type        = bool
  description = "(Optional) Should nodes in this Node Pool have a Public IP Address? Defaults to false."
  default     = false
}

variable "network_profile_outbound_type" {
  default     = "loadBalancer"
  description = "The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer, userDefinedRouting, managedNATGateway and userAssignedNATGateway. Defaults to loadBalancer. Changing this forces a new resource to be created."
}

variable "ingress_application_gateway_enabled" {
  type        = bool
  description = "Whether to deploy the Application Gateway ingress controller to this Kubernetes Cluster?"
  default     = false
}

variable "ingress_application_gateway_name" {
  type        = string
  description = "Application Gateway ingress controller name"
  default     = ""
}


variable "ingress_application_gateway_id" {
  type        = string
  description = "Application Gateway ingress controller ID"
  default     = ""
}

variable "ingress_application_gateway_aks_subnet_cidr" {
  type        = string
  description = "Application Gateway ingress controller name"
  default     = ""
}

variable "ingress_application_gateway_aks_subnet_name" {
  type        = string
  description = "Application Gateway ingress controller name"
  default     = ""
}

variable "ingress_application_gateway_aks_subnet_id" {
  type        = string
  description = "Application Gateway ingress controller id"
  default     = ""
}

variable "resource_group_id" {
  type        = string
  description = "Resource Group id"
  default     = ""
}


variable "workload_identity_enabled" {
  type        = bool
  description = "Desc"
  default     = true
}

variable "storage_profile_enabled" {
  description = "Enable storage profile"
  type        = bool
  default     = true
}

variable "storage_profile_blob_driver_enabled" {
  type        = bool
  description = "Is the Blob CSI driver enabled?"
  default     = true
}
