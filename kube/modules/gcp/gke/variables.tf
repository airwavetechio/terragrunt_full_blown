variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "location" {
  type = string
}

variable "airwave_stack_name" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "vpc_subnetwork" {
  type = string
}

variable "gke_num_nodes" {
  type = number
}

variable "gke_num_gpu_nodes" {
  type = number
}

variable "gpu_node_type" {
  type = string
}

variable "node_type" {
  type = string
}
variable "gke_version" {
  type    = string
  default = "1.25.8-gke.1000"
}

