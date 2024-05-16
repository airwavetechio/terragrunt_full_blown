variable "subdomain" {
  type        = string
  default     = "dev"
  description = "The name postfix that will be added to all resources"
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs to attach to the ELB."
}

variable "docker_swarm_master_ids" {
  type        = list(string)
  description = "The Network Interface IDs for Docker Swarm Masters"
}

variable "airwave_lb_sg" {
  type        = list(map(any))
  description = "Security group for the external loadbalancer"
  default = [
    {
      description            = "http"
      protocol               = "tcp"
      source_port_range      = "80"
      destination_port_range = "80"
      # This needs to be refactored as a variable or merge it with a configurable value
      source_address = "10.0.0.0/16"
    },
    {
      description            = "https"
      protocol               = "tcp"
      source_port_range      = "443"
      destination_port_range = "443"
      # This needs to be refactored as a variable or merge it with a configurable value
      source_address = "10.0.0.0/16"
    }
  ]
}

variable "airwave_lb_sg_egress" {
  type        = list(map(any))
  description = "Security group for the external loadbalancer egress"
  default = [
    {
      description            = "Egress"
      protocol               = "-1"
      source_port_range      = "0"
      destination_port_range = "0"
      source_address         = "10.20.0.0/24"
    },
  ]
}

variable "vpc_id" {
  type        = string
  description = "VPC id where compute machines will be provisioned"
}
