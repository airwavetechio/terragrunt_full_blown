variable "resource_group_name" {
  type        = string
  default     = "rg"
  description = "Resource Group name"
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "virtual_network_name" {
  type        = string
  description = "Virtual network name"
  default     = "aksVirtualNetwork"
}

variable "virtual_network_address_prefix" {
  type        = string
  description = "VNET address prefix"
  default     = "192.168.0.0/16"
}

variable "application_gateway_subnet_name" {
  type        = string
  description = "Subnet Name."
  default     = "appgwsubnet"
}

variable "aks_subnet_name" {
  type        = string
  description = "Subnet Name."
  default     = "akssubnet"
}

variable "aks_subnet_address_prefix" {
  type        = string
  description = "Subnet address prefix."
  default     = "192.168.0.0/24"
}

variable "app_gateway_subnet_address_prefix" {
  type        = string
  description = "Subnet server IP address."
  default     = "192.168.1.0/24"
}

variable "app_gateway_name" {
  type        = string
  description = "Name of the Application Gateway"
  default     = "appgw"
}

variable "app_gateway_sku" {
  type        = string
  description = "Name of the Application Gateway SKU"
  default     = "Standard_v2"
}


variable "tags" {
  type        = map(string)
  description = "Tags"
  default = {
    source = "terraform"
  }
}