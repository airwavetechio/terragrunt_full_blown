variable "subdomain" {
  type        = string
  default     = "dev"
  description = "The name postfix that will be added to all resources"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "The regional location of your Azure environemnt"
}

variable "zone" {
  type        = string
  default     = ""
  description = "The zone Nodes should be deployed to"
}

variable "gpu_zone" {
  type        = string
  default     = ""
  description = "The zone GPU Nodes should be deployed to"
}

variable "resource_group_name" {
  type        = string
  default     = "dev"
  description = "The regional location of your Azure environemnt"
}

variable "subnet_id" {
  type        = string
  description = "The subnet ID of your Azure environment"
}

variable "airwave_size" {
  type        = string
  description = "The internal common name of your Azure Compute Virtual Machine"
}

variable "is_suspended" {
  type        = bool
  description = "Are the VMs slated for deletion"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags on the resources"
}

variable "allocation_method" {
  type        = string
  default     = "Static"
  description = "Defines the allocation method for this IP address. Possible values are Static or Dynamic."
}

variable "sku" {
  type        = string
  default     = "Standard"
  description = "The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic."
}

variable "ip_version" {
  type        = string
  default     = "IPv4"
  description = "The IP Version to use, IPv6 or IPv4."
}

variable "private_ip_address_allocation" {
  type        = string
  default     = "Dynamic"
  description = "The allocation method used for the Private IP Address. Possible values are Dynamic and Static."
}

variable "docker_swarm_master_disk_size_gb" {
  type        = number
  default     = 100
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."
}

variable "docker_swarm_worker_disk_size_gb" {
  type        = number
  default     = 250
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."
}

variable "docker_gpu_worker_disk_size_gb" {
  type        = number
  default     = 500
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."
}

variable "swarm_manager_flavor" {
  default = {
    "moderate_solo" = "Standard_D2_v4"
    "fast_solo"     = "Standard_D2_v4"
    "slow_few"      = "Standard_D2_v4"
    "moderate_few"  = "Standard_D2_v4"
    "slow_solo"     = "Standard_D2_v4"
  }
}

variable "swarm_worker_flavor" {
  default = {
    "moderate_solo" = "Standard_D32d_v4"
    "fast_solo"     = "Standard_D32d_v4"
    "slow_few"      = "Standard_D32d_v4"
    "moderate_few"  = "Standard_D32d_v4"
    "slow_solo"     = "Standard_D16d_v4" # if you want a smaller size VM, "Standard_D2_v4"
  }
}

variable "swarm_gpu_worker_flavor" {
  default = {
    "moderate_solo" = "Standard_NC4as_T4_v3"
    "fast_solo"     = "Standard_NC4as_T4_v3"
    "slow_few"      = "Standard_NC4as_T4_v3"
    "moderate_few"  = "Standard_NC4as_T4_v3"
    "slow_solo"     = "Standard_NC4as_T4_v3"
  }
}

variable "swarm_manager_count" {
  default = {
    "fast_solo"     = 3
    "slow_few"      = 3
    "moderate_few"  = 3
    "moderate_solo" = 3
    "slow_solo"     = 3
  }
}

variable "swarm_worker_count" {
  default = {
    "fast_solo"     = 1
    "moderate_solo" = 1
    "slow_few"      = 3
    "moderate_few"  = 3
    "slow_solo"     = 1
  }
}

variable "docker_swarm_master_disk_caching" {
  type        = string
  default     = "ReadWrite"
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite."
}

variable "docker_swarm_master_storage_account_type" {
  type        = string
  default     = "Standard_LRS"
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS and Premium_LRS. Changing this forces a new resource to be created."
}

variable "docker_swarm_worker_disk_caching" {
  type        = string
  default     = "ReadWrite"
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite."
}

variable "docker_swarm_worker_storage_account_type" {
  type        = string
  default     = "Standard_LRS"
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS and Premium_LRS. Changing this forces a new resource to be created."
}

variable "docker_gpu_worker_disk_caching" {
  type        = string
  default     = "ReadWrite"
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite."
}

variable "docker_gpu_worker_storage_account_type" {
  type        = string
  default     = "Standard_LRS"
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS and Premium_LRS. Changing this forces a new resource to be created."
}

variable "docker_swarm_master_admin_username" {
  default = {
    "centos" = "centos"
    "ubuntu" = "ubuntu"
  }
  description = "The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
}

variable "docker_swarm_worker_admin_username" {
  default = {
    "centos" = "centos"
    "ubuntu" = "ubuntu"
  }
  description = "The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
}

variable "docker_gpu_worker_admin_username" {
  default = {
    "centos" = "centos"
    "ubuntu" = "ubuntu"
  }
  description = "The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
}

variable "image_publisher" {
  default = {
    "centos" = "OpenLogic"
    "ubuntu" = "Canonical"
  }
  description = "Specifies the publisher of the image used to create the virtual machines."
}

variable "image_offer" {
  default = {
    "centos" = "CentOS"
    "ubuntu" = "UbuntuServer"
  }
  description = "Specifies the offer of the image used to create the virtual machines."
}

variable "image_sku" {
  default = {
    "centos" = "7.5"
    "ubuntu" = "18.04-LTS"
  }
  description = "Specifies the SKU of the image used to create the virtual machines."
}

variable "image_version" {
  default = {
    "centos" = "latest"
    "ubuntu" = "latest"
  }
  description = "Specifies the version of the image used to create the virtual machines."
}

variable "operatingsystem" {
  default = {
    "ubuntu" = "ubuntu"
    "centos" = "centos"
  }
  description = "The Operating System of the virtual machines."
}

variable "docker_swarm_public_key" {
  description = "An ssh public key for the admin user"
}

variable "gpu_shape" {
  default = "demo"
}

variable "gpu_shapes" {
  default = {
    full = {
      pool_training_units : 6,
      pool_training_replicas : 6,
      pool_production_units : 10,
      pool_production_replicas : 1
    }

    constrained = {
      pool_training_units : 1,
      pool_training_replicas : 1,
      pool_production_units : 7,
      pool_production_replicas : 1
    }
    demo = {
      pool_training_units : 1,
      pool_training_replicas : 1,
      pool_production_units : 3,
      pool_production_replicas : 1
    }
    slow_solo = {
      pool_training_units : 1,
      pool_training_replicas : 1,
      pool_production_units : 1,
      pool_production_replicas : 1
    }
  }
}

variable "docker_swarm_master_azurerm_network_security_group_id" {
  type        = string
  description = "The ID of the Network Security Group which should be attached to the Network Interface. Changing this forces a new resource to be created."
}

variable "docker_swarm_worker_azurerm_network_security_group_id" {
  type        = string
  description = "The ID of the Network Security Group which should be attached to the Network Interface. Changing this forces a new resource to be created."
}

variable "docker_gpu_worker_azurerm_network_security_group_id" {
  type        = string
  description = "The ID of the Network Security Group which should be attached to the Network Interface. Changing this forces a new resource to be created."
}

variable "enable_accelerated_networking" {
  type        = bool
  description = "hould Accelerated Networking be enabled? Defaults to false."
  default     = false
}
