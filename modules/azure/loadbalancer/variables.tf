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

variable "public_ip_sku" {
  type        = string
  default     = "Standard"
  description = "The SKU of the Public IP. Accepted values are Basic and Standard."
}

variable "allocation_method" {
  type        = string
  default     = "Static"
  description = "Defines the allocation method for this IP address. Possible values are Static or Dynamic."
}

variable "sku" {
  type        = string
  default     = "Standard"
  description = "The SKU of the Azure Load Balancer. Accepted values are Basic, Standard and Gateway"
}

variable "sku_tier" {
  type        = string
  default     = "Regional"
  description = "The Sku Tier of this Load Balancer. Possible values are Global and Regional. Changing this forces a new resource to be created."
}

variable "private_ip_address_allocation" {
  type        = string
  default     = "Dynamic"
  description = "The allocation method for the Private IP Address used by this Load Balancer. Possible values as Dynamic and Static."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags on the resources"
}

# Nat rules
variable "rule01_protocol" {
  type        = string
  default     = "Tcp"
  description = " The transport protocol for the external endpoint. Possible values are Udp, Tcp or All."
}

variable "rule01_frontend_port" {
  type        = string
  default     = "443"
  description = "The port for the external endpoint. Port numbers for each Rule must be unique within the Load Balancer. Possible values range between 1 and 65534, inclusive."
}

variable "rule01_backend_port" {
  type        = string
  default     = "443"
  description = "The port used for internal connections on the endpoint. Possible values range between 1 and 65535, inclusive."
}

variable "rule02_protocol" {
  type        = string
  default     = "Tcp"
  description = " The transport protocol for the external endpoint. Possible values are Udp, Tcp or All."
}

variable "rule02_frontend_port" {
  type        = string
  default     = "80"
  description = "The port for the external endpoint. Port numbers for each Rule must be unique within the Load Balancer. Possible values range between 1 and 65534, inclusive."
}

variable "rule02_backend_port" {
  type        = string
  default     = "80"
  description = "The port used for internal connections on the endpoint. Possible values range between 1 and 65535, inclusive."
}

variable "docker_swarm_masters_networking_interface_id" {
  type        = list(string)
  description = "The Network Interface IDs for Docker Swarm Masters"
}

variable "probe_protocol" {
  type        = string
  default     = "Https"
  description = "Specifies the protocol of the end point. Possible values are Http, Https or Tcp. If Tcp is specified, a received ACK is required for the probe to be successful. If Http is specified, a 200 OK response from the specified URI is required for the probe to be successful."
}

variable "probe_port" {
  type        = number
  default     = 443
  description = "Specifies the port the probe should be listening to."
}

variable "request_path" {
  type        = string
  default     = "/health"
  description = "The URI used for requesting health status from the backend endpoint. Required if protocol is set to Http or Https. Otherwise, it is not allowed."
}

variable "interval_in_seconds" {
  type        = number
  default     = 60
  description = "The interval, in seconds between probes to the backend endpoint for health status. The minimum value is 5."
}

variable "number_of_probes" {
  type        = number
  default     = 2
  description = " The number of failed probe attempts after which the backend endpoint is removed from rotation. NumberOfProbes multiplied by intervalInSeconds value must be greater or equal to 10. Endpoints are returned to rotation when at least one probe is successful."
}
