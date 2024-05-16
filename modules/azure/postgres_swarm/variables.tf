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

variable "resource_group_name" {
  type        = string
  default     = "dev"
  description = "The regional location of your Azure environemnt"
}

variable "subnet_id" {
  type        = string
  description = "The subnet ID of your Azure environment"
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

variable "size" {
  type        = string
  default     = "Standard_D8_v3"
  description = "The SKU which should be used for this Virtual Machine, such as Standard_F2."
}

variable "admin_username" {
  default = {
    "centos" = "centos"
    "ubuntu" = "ubuntu"
  }
  description = "The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
}

variable "public_key" {
  type        = string
  description = "The Public Key which should be used for authentication, which needs to be at least 2048-bit and in ssh-rsa format. Changing this forces a new resource to be created."
}

variable "disk_size_gb" {
  type        = number
  default     = 100
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."
}

variable "disk_caching" {
  type        = string
  default     = "ReadWrite"
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite."
}

variable "storage_account_type" {
  type        = string
  default     = "Standard_LRS"
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS and Premium_LRS. Changing this forces a new resource to be created."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags on the resources"
}

variable "allowed_ips_list" {
  description = "List of IPs for the inbound firewall rule(s)."
  type        = list(any)
  default     = []
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
    "centos" = "latest"
    "ubuntu" = "latest"
  }
  description = "The Operating System of the virtual machines."
}

variable "enable_accelerated_networking" {
  type = bool
  description = "hould Accelerated Networking be enabled? Defaults to false."
  default = false
}