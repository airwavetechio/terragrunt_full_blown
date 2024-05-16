variable "location" {
  default = "eastus2"
}

variable "resource_group_name" {
  type        = string
  default     = "dev"
  description = "The name of the resource group that will be added to all Azure entities"
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

variable "private_cluster_public_fqdn_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to false."
}

variable "kubernetes_version" {
  default = "1.24.3"
}

variable "private_cluster_enabled" {
  default = false
}

variable "api_server_authorized_ip_ranges" {
  type    = list(string)
  default = ["0.0.0.0/32"]
}

variable "enable_pod_security_policy" {
  default = false
}

variable "role_based_access_control_enabled" {
  default = true
}

variable "default_node_pool_name" {
  default = "default"
}

variable "default_node_pool_node_count" {
  default = 3
}

variable "default_node_pool_instance_size" {
  default = "Standard_B2s"
}

variable "default_node_pool_enable_auto_scaling" {
  default = true
}

variable "default_node_pool_max_count" {
  default = 10
}

variable "default_node_pool_min_count" {
  default = 2
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

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is allowed for this Kubernetes Cluster. Defaults to true. Changing this forces a new resource to be created."
  default     = false
}

variable "enable_node_public_ip" {
  type        = bool
  description = "Should nodes in this Node Pool have a Public IP Address? Changing this forces a new resource to be created."
  default     = false
}

variable "network_profile_outbound_type" {
  default     = "loadBalancer"
  description = "The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer, userDefinedRouting, managedNATGateway and userAssignedNATGateway. Defaults to loadBalancer. Changing this forces a new resource to be created."
}


variable "vnet" {
  type = object({
    cird            = string
    sn_cluster_cird = string
  })
  default = {
    cird            = "10.240.0.0/16"
    sn_cluster_cird = "10.240.0.0/22"
  }
  description = "The VNET and subnet configuration."
}

# Autoscaling is off, don't need this. 
variable "default_node_pool_type" {
  default = "VirtualMachineScaleSets"
}


variable "zones" {
  type        = list(string)
  description = "Specifies a list of Availability Zones in which this Public IP Prefix should be located. Changing this forces a new Public IP Prefix to be created."
  default     = ["1"]
}

# variable "pv_storage_size_rwm" {
#   type = string
#   description = "The size of the K8s persistent volume for ReadWriteMany"
#   default = "10Gi"
# }

# variable "managed_disk_size_gb_rwm" {
#   type = string
#   description = "The size of the Azure managed disk to tie to the PV to"
#   default = "10"
# }

variable "storage_class_name" {
  type        = string
  description = "the name of the PV storage class for Pienso"
  default     = "airwave"
}


# variable "storage_class_name_rwm" {
#   type        = string
#   description = "the name of the PV storage class for ReadWriteMany"
#   default     = "manual-rwm"
# }

# variable "pv_storage_size_rwo" {
#   type = string
#   description = "The size of the K8s persistent volume for ReadWriteOnce"
#   default = "10Gi"
# }

# variable "managed_disk_size_gb_rwo" {
#   type        = string
#   description = "The size of the Azure managed disk to tie to the PV to for ReadWriteOnce"
#   default     = "10"
# }

# variable "storage_class_name_rwo" {
#   type = string
#   description = "the name of the PV storage class for ReadWriteOnce"
#   default = "manual-rwo"
# }
