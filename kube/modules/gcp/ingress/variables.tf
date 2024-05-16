variable "app_name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "ssl_policy_name" {
  type = string
}

variable "gke_project_id" {
  type = string
  default = null
}