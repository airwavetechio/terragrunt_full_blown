variable "subdomain" {
  type        = string
  default     = "dev"
  description = "The name postfix that will be added to all resources"
}


variable "elastic_sg" {
  type        = list(map(any))
  description = "Security group for the elastic"
  default = [
    {
      description            = "https"
      protocol               = "Tcp"
      source_port_range      = "443"
      destination_port_range = "443"
      source_address         = "10.20.0.0/24"
    },
  ]
}

variable "vpc_id" {
  type        = string
  description = "VPC id where compute machines will be provisioned"
}

variable "storage_size_gb" {
  type        = number
  default     = 500
  description = "The Size of volume."
}

variable "subnet_ids" {
  type        = list(string)
  description = "The subnet ids which should access elastic"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags on the resources"
}

variable "instance_count" {
  description = "Number of elastic nodes"
  type        = number
  default     = 1
}
