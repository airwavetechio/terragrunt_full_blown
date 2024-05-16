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
  description = "Aws availability zone where nodes should be deployed"
}

variable "subnet_id" {
  type        = string
  description = "The subnet ID of your aws environment"
}

variable "airwave_size" {
  type        = string
  description = "The size of airwave cluster"
}

variable "is_suspended" {
  type        = bool
  description = "Are the VMs slated for deletion"
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
    "moderate_solo" = "m5.large"
    "fast_solo"     = "m5.large"
    "slow_few"      = "m5.large"
    "moderate_few"  = "m5.large"
  }
}

variable "swarm_worker_flavor" {
  default = {
    "moderate_solo" = "m4.10xlarge"
    "fast_solo"     = "c5.18xlarge"
    "slow_few"      = "r5.2xlarge"
    "moderate_few"  = "m4.10xlarge"
  }
}

variable "swarm_gpu_worker_flavor" {
  default = {
    "moderate_solo" = "g4dn.xlarge"
    "fast_solo"     = "g4dn.xlarge"
    "slow_few"      = "g4dn.xlarge"
    "moderate_few"  = "g4dn.xlarge"
  }
}

variable "swarm_manager_count" {
  default = {
    "fast_solo"     = 3
    "slow_few"      = 3
    "moderate_few"  = 3
    "moderate_solo" = 3
  }
}

variable "swarm_worker_count" {
  default = {
    "fast_solo"     = 1
    "moderate_solo" = 1
    "slow_few"      = 3
    "moderate_few"  = 3
  }
}

variable "aws_ami" {
  default = {
    "centos" = "CentOS Linux 7 x86_64 HVM EBS ENA 1901_01-b7ee8a69-ee97-4a49-9e68-afaee216db2e-ami*"
    "ubuntu" = "ubuntu-minimal/images/hvm-ssd/ubuntu-bionic-18.04-amd64-minimal-*"
  }

  description = "AMI image used as machine operating system"
}

variable "aws_ami_owner" {
  default = {
    "centos" = "679593333241"
    "ubuntu" = "099720109477"
  }
}

variable "operatingsystem" {
  type        = string
  default     = "ubuntu"
  description = "The Operating System of the virtual machines."
}

variable "docker_swarm_master_public_key" {
  description = "An ssh public key for the admin user"
}

variable "docker_swarm_worker_public_key" {
  description = "An ssh public key for the admin user"
}

variable "vpc_id" {
  type        = string
  description = "VPC id where compute machines will be provisioned"
}

variable "docker_swarm_master_sg" {
  type        = list(map(any))
  description = "Security group ingress for the docker swarm masters"
  default     = []
}

variable "docker_swarm_master_sg_egress" {
  type        = list(map(any))
  description = "Security group egress for the docker swarm masters"
  default     = []
}


variable "docker_swarm_worker_sg" {
  type        = list(map(any))
  description = "Security group ingress for the docker swarm workers"
  default     = []
}

variable "docker_swarm_worker_sg_egress" {
  type        = list(map(any))
  description = "Security group egress for the docker swarm workers"
  default     = []
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
  }
}
