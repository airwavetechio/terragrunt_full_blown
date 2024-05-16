variable "name_postfix" {
  type        = string
  default     = "dev"
  description = "The name postfix that will be added to all resources"
}

variable "address_space" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Address CIDR for the network"
}

variable "zone" {
  type        = string
  description = "Aws availability zone network will be created"
}

variable "airwave_postgres_sg" {
  type        = list(map(any))
  description = "Security group for the postgres"
  default = [
    {
      description            = "postgres"
      protocol               = "Tcp"
      source_port_range      = "5432"
      destination_port_range = "5432"
      source_address         = "10.0.2.0/24"
    },
  ]
}
