variable "desired_size" {
    default = 1
    type = number
    description = "Desired size of EKS node"
}

variable "desired_gpu_size" {
    default = 1
    type = number
    description = "Desired GPU size of EKS node"
}

variable "cluster_name" {
    type = string
    description = "Name of cluster"
}

variable "nodegroup_name" {
    type = string
    description = "Name of node group"
}

variable "nodegroup_gpu_name" {
    type = string
    description = "Name of GPU node group"
}

variable "aws_region" {
    type = string
    description = "AWS region"
}


